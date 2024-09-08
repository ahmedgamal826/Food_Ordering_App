import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/about_us_screen.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/bills_screen.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/my_payments_card.dart';
import 'package:food_ordering_app/Screens/order_in_profile.dart';
import 'package:food_ordering_app/auth/auth_services.dart';
import 'package:food_ordering_app/widgets/card_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  bool isLoading = false;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      setState(() {
        isLoading = true;
      });

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('user_app').doc(user.uid);
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
            FirebaseFirestore.instance.collection('user_app').doc(user.uid);
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
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
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
          if (!authService.isLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: Text(''),
              ),
              body: const Center(
                child: Text('User is not logged in'),
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
                'My Profile',
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
                            radius: 70,
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
                        top: 100,
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
                    height: 20,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    '${authService.userName ?? 'loading...'}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
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
                          builder: (context) => MyPaymentCardsScreen(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.payments,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyPaymentCardsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'My Payment Cards',
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
                          builder: (context) => BillsScreen(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.payment,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Bills',
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
                          builder: (context) => OrderInProfileUser(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.card_travel_outlined,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderInProfileUser(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'My Orders',
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
                          builder: (context) => FavouriteScreen(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavouriteScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'Favourites',
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
                          builder: (context) => AboutUsScreen(),
                        ),
                      );
                    },
                    child: CardProfile(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                      title: 'About us',
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
