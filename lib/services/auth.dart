import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool byGoogle = false;

  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print("Error signing in $e");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      byGoogle = true;
      return userCredential.user;
    } catch (e) {
      // print('signing in with Google $e');
      return null;
    }
  }

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

// This is to sign out
  Future<void> signOut() async {
    await _auth.signOut();
    // print("here in auth signing out ");
  }

// Auth state changes now
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
