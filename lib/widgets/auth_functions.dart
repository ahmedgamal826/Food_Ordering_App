import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_ordering_app/widgets/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Sign Up Function  ==> Register

Future<void> signUp({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
}) async {
  // Check if any required fields are empty
  if (nameController.text == '' ||
      emailController.text == '' ||
      passwordController.text == '' ||
      confirmPasswordController.text == '') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All fields are required"),
      ),
    );
    return;
  }
  if (passwordController.text != confirmPasswordController.text) {
    awesomeDialog(context: context, content: 'Passwords do not match.');
    return;
  }

  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.of(context).pushReplacementNamed("homeScreen");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      awesomeDialog(context: context, content: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      awesomeDialog(context: context, content: 'Wrong password');
    } else if (e.code == 'user-disabled') {
      awesomeDialog(context: context, content: 'This user has been disabled.');
    } else if (e.code == 'too-many-requests') {
      awesomeDialog(
          context: context, content: 'Too many requests. Try again later.');
    } else if (e.code == 'operation-not-allowed') {
      awesomeDialog(
          context: context,
          content: 'Signing in with email and password is not enabled.');
    } else if (e.code == 'invalid-email') {
      awesomeDialog(context: context, content: 'The email address is invalid.');
    } else {
      awesomeDialog(context: context, content: 'No user found for that email.');
    }
  } catch (e) {
    awesomeDialog(
        context: context, content: 'An error occurred. Please try again.');
  }
}

//Sign In Function  ===> Login

void signIn({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    Navigator.of(context).pushReplacementNamed("homeScreen");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      awesomeDialog(context: context, content: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      awesomeDialog(context: context, content: 'Wrong password');
    } else if (e.code == 'user-disabled') {
      awesomeDialog(context: context, content: 'This user has been disabled.');
    } else if (e.code == 'too-many-requests') {
      awesomeDialog(
          context: context, content: 'Too many requests. Try again later.');
    } else if (e.code == 'operation-not-allowed') {
      awesomeDialog(
          context: context,
          content: 'Signing in with email and password is not enabled.');
    } else if (e.code == 'invalid-email') {
      awesomeDialog(context: context, content: 'The email address is invalid.');
    } else {
      awesomeDialog(context: context, content: 'No user found for that email.');
    }
  } catch (e) {
    awesomeDialog(
        context: context, content: 'An error occurred. Please try again.');
  }
}

// Future<UserCredential> signInWithGoogle({required BuildContext context}) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

Future signInWithGoogle({required BuildContext context}) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    return; // out of funcion ==============>
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);
  Navigator.of(context).pushNamedAndRemoveUntil("homeScreen", (route) => false);
}
