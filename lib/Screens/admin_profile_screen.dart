import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services_admin.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/widgets/custom_profile_list_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  bool isLoading = false;
  String? profileImageUrl;
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    getUserData();
  }

  void getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        name = userDoc.get('name');
        email = user.email;
      });
    }
  }

  Future<void> _loadProfileImage() async {
    try {
      setState(() {
        isLoading = true;
      });

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

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = pickedFile;
        });

        await uploadAndSaveImage();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> uploadAndSaveImage() async {
    try {
      setState(() {
        isLoading = true;
      });

      final imageUrl = await uploadImage(image!);
      if (imageUrl != null) {
        await saveImageUrlToFirestore(imageUrl);
        setState(() {
          profileImageUrl = imageUrl;
        });
      } else {
        print("Image upload failed.");
      }
    } catch (e) {
      print("Error in upload and save process: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/${image.name}');
      final uploadTask = imageRef.putFile(File(image.path));

      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();
      print("Image uploaded successfully: $imageUrl");
      return imageUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> saveImageUrlToFirestore(String imageUrl) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userDoc.set({
          'profileImage': imageUrl,
        }, SetOptions(merge: true));

        print("Image URL saved to Firestore: $imageUrl");
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error saving image URL to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminauthService = Provider.of<AdminAuthService>(context);
    return StreamBuilder<User?>(
      stream: adminauthService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: Center(
              child: LoadingDots(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Check if user is logged in
          if (!adminauthService.isAdminLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: Text(''),
              ),
              body: const Center(
                child: Text('Admin is not logged in'),
              ),
            );
          }

          // Display user information

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.orange,
              centerTitle: true,
              title: const Text(
                'Admin Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: Center(
              child: CustomProfileListView(
                email: email,
                image: image,
                isLoading: isLoading,
                name: name,
                pickImage: pickImage,
                profileImageUrl: profileImageUrl,
              ),
            ),
          );
        }
      },
    );
  }
}
