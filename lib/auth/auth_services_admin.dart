import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminAuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _adminName;
  String? _adminEmail;

  String? get adminName => _adminName;
  String? get adminEmail => _adminEmail;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  bool get isAdminLoggedIn => _firebaseAuth.currentUser != null;

  AdminAuthService() {
    _initializeAdminData();
  }

  Future<void> _initializeAdminData() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _fetchAdminData(user.uid);
      notifyListeners();
    }
  }

  Future<UserCredential> signInAdminWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await _fetchAdminData(userCredential.user!.uid);
      notifyListeners();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No admin found with this email.';
        case 'wrong-password':
          throw 'Incorrect password.';
        case 'invalid-email':
          throw 'The email address is not valid.';
        default:
          throw 'Error during sign in.';
      }
    }
  }

  Future<void> _fetchAdminData(String uid) async {
    DocumentSnapshot adminDoc =
        await _firestore.collection('users').doc(uid).get();
    if (adminDoc.exists) {
      _adminName = adminDoc['name'];
      _adminEmail = adminDoc['email'];
    } else {
      throw 'Admin data not found.';
    }
  }

  Future<void> signOutAdmin() async {
    await _firebaseAuth.signOut();
    _adminName = null;
    _adminEmail = null;
    notifyListeners();
  }
}
