import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:Urban_block_party/Screens/login/login.dart';
import 'package:Urban_block_party/main.dart';

class AuthServices{
  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MyApp();
          } else {
            return const login_Screen();
          }
        });
  }
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  // print( FirebaseAuth.instance.currentUser!.email!);
   // print( FirebaseAuth.instance.currentUser!.displayName!);
   // print( FirebaseAuth.instance.currentUser!.uid!);
   // print( FirebaseAuth.instance.currentUser!.photoURL!);
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // //Sign out
  // signOut() {
  //   FirebaseAuth.instance.signOut();
  // }

}