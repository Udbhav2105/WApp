import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool byGoogle = false;

  Future<User?> signInAnonymously() async {
    try {
      print("Trying to sign in anonymously");
      UserCredential userCredential = await _auth.signInAnonymously();
      print("Success");
      return userCredential.user;
    } catch (e, stacktrace) {
      print('Error in signInAnonymously: $e');
      print('Stacktrace: $stacktrace');
      return null;
    }
  }
  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
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
    if (byGoogle){
      _googleSignIn.disconnect();
    }
  }

// Auth state changes now
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
