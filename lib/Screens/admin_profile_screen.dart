import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/about_us_screen.dart';
import 'package:food_ordering_app/Screens/account_management.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/bills_screen.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/finanicial_managmenet_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/orders_managment.dart';
import 'package:food_ordering_app/Screens/my_payments_card.dart';
import 'package:food_ordering_app/Screens/order_in_profile.dart';
import 'package:food_ordering_app/auth/auth_services_admin.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/widgets/card_profile.dart';
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
          profileImageUrl = imageUrl; // تحديث عنوان الصورة المحفوظة
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

  Future<void> logout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminOrUserScreen(),
      ),
    ).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
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
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(''),
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
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      InkWell(
                        onTap: pickImage,
                        child: Center(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: image != null
                                ? FileImage(File(image!.path))
                                : profileImageUrl != null
                                    ? NetworkImage(profileImageUrl!)
                                    : null,
                            child: image == null && profileImageUrl == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.orange,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160,
                        bottom: 0,
                        right: 130,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.orange,
                            size: 30,
                          ),
                          onPressed: pickImage,
                        ),
                      ),
                    ],
                  ),
                  if (isLoading) const SizedBox(height: 20),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    '${name ?? ''}',
                    // '${adminauthService.adminEmail ?? 'loading...'}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    '${email ?? ''}',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersManagment(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdersManagment(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Orders Management',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinancialScreen(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FinancialScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Money Management',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountManagement(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountManagement(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Account Managment',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      logout(context);
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          logout(context);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Logout',
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
