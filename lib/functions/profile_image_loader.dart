import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileImageLoader extends StatefulWidget {
  @override
  _ProfileImageLoaderState createState() => _ProfileImageLoaderState();
}

class _ProfileImageLoaderState extends State<ProfileImageLoader> {
  String? profileImageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final docSnapshot = await userDoc.get();
        final data = docSnapshot.data();

        if (data != null && data['profileImage'] != null) {
          setState(() {
            profileImageUrl = data['profileImage'] as String?;
          });
        }
      }
    } catch (e) {
      print("Error loading profile image: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : profileImageUrl != null
            ? CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageUrl!),
              )
            : const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50),
              );
  }
}
