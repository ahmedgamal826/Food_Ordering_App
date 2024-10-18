import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/animation_screen.dart';
import 'package:food_ordering_app/components/profile_info_cards.dart';
import 'package:image_picker/image_picker.dart';

class CustomProfileListView extends StatefulWidget {
  final String? name;
  final String? email;
  final String? profileImageUrl;
  final XFile? image;
  final bool isLoading;
  final VoidCallback pickImage;

  const CustomProfileListView({
    Key? key,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.image,
    required this.isLoading,
    required this.pickImage,
  }) : super(key: key);

  @override
  State<CustomProfileListView> createState() => _CustomProfileListViewState();
}

class _CustomProfileListViewState extends State<CustomProfileListView> {
  Future<Map<String, String?>> _fetchUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return {'role': '', 'uid': ''};
    }

    String role = '';
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user_app')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      role = userDoc.get('rool');
      return {'role': role, 'uid': user.uid};
    }

    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (adminDoc.exists) {
      role = adminDoc.get('rool');
      return {'role': role, 'uid': user.uid};
    }

    return {'role': '', 'uid': user.uid};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: _fetchUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.data == null || snapshot.data!['role'] == '') {
          return const AnimationScreen(role: '');
        }

        String role = snapshot.data!['role']!;

        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                InkWell(
                  onTap: widget.pickImage,
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: widget.image != null
                          ? FileImage(File(widget.image!.path))
                          : widget.profileImageUrl != null
                              ? NetworkImage(widget.profileImageUrl!)
                              : null,
                      child:
                          widget.image == null && widget.profileImageUrl == null
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
                    onPressed: widget.pickImage,
                  ),
                ),
              ],
            ),
            if (widget.isLoading) const SizedBox(height: 20),
            if (widget.isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              '${widget.name ?? ''}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              '${widget.email ?? ''}',
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            ProfileInfoCards(role: role),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
