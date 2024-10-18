import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/about_us_screen.dart';
import 'package:food_ordering_app/Screens/account_management.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/bills_screen.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/finanicial_managmenet_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/orders_managment.dart';
import 'package:food_ordering_app/Screens/my_payments_card.dart';
import 'package:food_ordering_app/Screens/order_screen.dart';
import 'package:food_ordering_app/widgets/card_profile.dart';

class ProfileInfoCards extends StatefulWidget {
  const ProfileInfoCards({super.key, required this.role});

  final String role;

  @override
  State<ProfileInfoCards> createState() => _ProfileInfoCardsState();
}

class _ProfileInfoCardsState extends State<ProfileInfoCards> {
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
    return Column(
      children: [
        widget.role == 'admin'
            ? _buildCard(
                context,
                title: 'Orders Management',
                icon: Icons.shopping_cart_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersManagment()),
                  );
                },
              )
            : _buildCard(
                context,
                title: 'My Payment Cards',
                icon: Icons.payments,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPaymentCardsScreen(),
                    ),
                  );
                },
              ),
        const SizedBox(height: 10),
        widget.role == 'admin'
            ? _buildCard(
                context,
                title: 'Money Management',
                icon: Icons.monetization_on,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FinancialScreen()),
                  );
                },
              )
            : _buildCard(
                context,
                title: 'Bills',
                icon: Icons.payment,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillsScreen(),
                    ),
                  );
                },
              ),
        const SizedBox(height: 10),
        widget.role == 'admin'
            ? _buildCard(
                context,
                title: 'Account Management',
                icon: Icons.account_circle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountManagement()),
                  );
                },
              )
            : _buildCard(
                context,
                title: 'My Orders',
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(),
                    ),
                  );
                },
              ),
        const SizedBox(height: 10),
        widget.role == 'admin'
            ? _buildCard(
                context,
                title: 'About Us',
                icon: Icons.info,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsScreen(),
                    ),
                  );
                },
              )
            : _buildCard(
                context,
                title: 'My Favourites',
                icon: Icons.favorite_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ),
                  );
                },
              ),
        const SizedBox(height: 10),
        widget.role == 'admin'
            ? _buildCard(
                context,
                title: 'Logout',
                icon: Icons.logout,
                onTap: () => logout(context),
              )
            : _buildCard(
                context,
                title: 'About Us',
                icon: Icons.info,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsScreen(),
                    ),
                  );
                },
              ),
        const SizedBox(height: 10),
        widget.role == 'user'
            ? _buildCard(
                context,
                title: 'Logout',
                icon: Icons.logout,
                onTap: () => logout(context),
              )
            : const Text(''),
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
