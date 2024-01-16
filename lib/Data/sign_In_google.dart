import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //late String __userToken;
  Stream get authLoggingUser => _auth.authStateChanges();
  //String get userToken => __userToken;
  final googleSignIn = GoogleSignIn();
  // late GoogleSignInAccount _user = await  googleSignIn.signInSilently();
  // GoogleSignInAccount get user => _user;

  //get current user
  getCurrentUser() async {
    return _auth.currentUser!.uid;
  }

  Future signInWithGoogle() async {
    //   // Trigger the authentication flow
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn()
        .whenComplete(() => googleSignIn.signInSilently());

// Return null to prevent further exceptions if googleSignInAccount is null
    if (googleSignInAccount == null) return debugPrint("User is not signed in");

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    // // // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }


  Future<void> signOut() async {
    _auth.signOut();
  }
}
