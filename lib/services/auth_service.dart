import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/services/firestore_service.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<User?> _userFromFirebase(auth.User? user) async {
    if (user == null) {
      return null;
    }
    return await _firestoreService.getUser(user.uid);
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      final newUser = User(
        id: credential.user!.uid,
        firstName: name,
        lastName: '',
        email: email,
        username: email.split('@').first,
        favoriteGenres: [],
        profilePictureUrl: 'assets/carlos.jpeg', // default picture
      );

      await _firestoreService.createUser(newUser);

      return _userFromFirebase(credential.user);
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
