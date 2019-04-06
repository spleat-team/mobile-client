import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Shared State for Widgets
  Observable<FirebaseUser> user; // firebase user

  // constructor
  AuthService();

  Future<FirebaseUser> googleSignIn() async {
    try {
      // loading.add(true);
      // Step 1
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      // Step 2
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      return user;
    } catch (err) {
      print(err);
    }
    return null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  void signOut() {
    _googleSignIn.signOut();
    _auth.signOut();
  }
}

final AuthService authService = AuthService();
