import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/about_us_screen.dart';
import 'package:food_ordering_app/Screens/account_management.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/finanicial_managmenet_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/orders_managment.dart';
import 'package:food_ordering_app/widgets/card_profile.dart';
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
  bool isLoading = false;
  Future<void> logout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminOrUserScreen(),
      ),
    ).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: widget.image == null && widget.profileImageUrl == null
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
        _buildCard(
          context,
          title: 'Orders Management',
          icon: Icons.shopping_cart_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrdersManagment()),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildCard(
          context,
          title: 'Money Management',
          icon: Icons.monetization_on,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinancialScreen()),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildCard(
          context,
          title: 'Account Management',
          icon: Icons.account_circle,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountManagement()),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildCard(
          context,
          title: 'About Us',
          icon: Icons.logout,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutUsScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildCard(
          context,
          title: 'Logout',
          icon: Icons.logout,
          onTap: () => logout(context),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CardProfile(
        prefixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: Colors.white,
            size: 27,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
        title: title,
      ),
    );
  }
}
