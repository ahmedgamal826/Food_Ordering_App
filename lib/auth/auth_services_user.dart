import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthService extends ChangeNotifier {
  // Firebase Auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Variables to hold user data
  String? _userName;
  String? _userEmail;

  // Getters for user data
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  // Stream of authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Check if user is logged in
  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  // Constructor
  AuthService() {
    // Load user data when the AuthService is instantiated
    _initializeUserData();
  }

  // Initialize user data
  Future<void> _initializeUserData() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _fetchUserData(user.uid);
      notifyListeners();
    }
  }

  // Sign in user
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Update loginTimestamp in Firestore
      await _firestore
          .collection('user_app')
          .doc(userCredential.user!.uid)
          .update({
        'isLoggedIn': true,
        'loginTimestamp': FieldValue.serverTimestamp(), // Add login timestamp
      });

      // Fetch user data from Firestore
      await _fetchUserData(userCredential.user!.uid);

      // Notify listeners to update UI
      notifyListeners();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific error cases
      switch (e.code) {
        case 'user-not-found':
          throw 'No user found with this email.';
        case 'wrong-password':
          throw 'Incorrect password.';
        case 'invalid-email':
          throw 'The email address is not valid.';
        default:
          throw 'No user found for this email.';
      }
    }
  }

  // Sign up user
  Future<UserCredential> signUpWithEmailandPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user data in Firestore with loginTimestamp
      await _firestore
          .collection('user_app')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'uid': userCredential.user!.uid,
        'isLoggedIn': true,
        'loginTimestamp': FieldValue.serverTimestamp(), // Add login timestamp
        'email': email,
      });

      // Fetch user data
      await _fetchUserData(userCredential.user!.uid);

      // Notify listeners to update UI
      notifyListeners();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign in user with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();

      // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign in was aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Save user data in Firestore with loginTimestamp
      await _firestore
          .collection('user_app')
          .doc(userCredential.user!.uid)
          .set({
        'name': userCredential.user!.displayName,
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'profile_picture': userCredential.user!.photoURL,
        'isLoggedIn': true, // Set user as logged in
        'loginTimestamp': FieldValue.serverTimestamp(), // Add login timestamp
        'rool': 'user',
      }, SetOptions(merge: true));

      // Fetch user data
      await _fetchUserData(userCredential.user!.uid);

      // Notify listeners to update UI
      notifyListeners();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Error, please try again!');
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // Future<UserCredential?> signInWithFacebook() async {
  //   try {
  //     // Trigger the sign-in flow
  //     final LoginResult loginResult = await FacebookAuth.instance.login();

  //     // Check if the login was successful
  //     if (loginResult.status == LoginStatus.success) {
  //       // Create a credential from the access token
  //       final AccessToken accessToken = loginResult.accessToken!;

  //       // Use the access token to create a credential
  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(accessToken.tokenString);

  //       // Once signed in, return the UserCredential
  //       return await FirebaseAuth.instance
  //           .signInWithCredential(facebookAuthCredential);
  //     } else if (loginResult.status == LoginStatus.cancelled) {
  //       print('Login cancelled by user');
  //       return null; // Handle the cancellation as appropriate
  //     } else {
  //       print('Facebook login failed: ${loginResult.message}');
  //       return null; // Handle the error accordingly
  //     }
  //   } catch (e) {
  //     print('Error during Facebook sign in: $e');
  //     return null; // Handle the error accordingly
  //   }
  // }

  // Fetch user data from Firestore
  Future<void> _fetchUserData(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('user_app').doc(uid).get();

    if (userDoc.exists) {
      _userName = userDoc['name'];
      _userEmail = userDoc['email'];
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    // Clear user data
    _userName = null;
    _userEmail = null;

    // Notify listeners to update UI
    notifyListeners();
  }
}
