import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:literary_heaven/models/user.dart';
import 'package:literary_heaven/services/firestore_service.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    // This is a placeholder. In a real app, you would fetch the user profile
    // from Firestore here based on the user.uid.
    return User(
      id: user.uid,
      firstName: user.displayName ?? '',
      lastName: '',
      email: user.email ?? '',
      username: user.email?.split('@').first ?? '',
      favoriteGenres: [],
    );
  }

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
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
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
