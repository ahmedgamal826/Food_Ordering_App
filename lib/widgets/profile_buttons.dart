import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/about_us_screen.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/bills_screen.dart';
import 'package:food_ordering_app/Screens/favourite_screen.dart';
import 'package:food_ordering_app/Screens/my_payments_card.dart';
import 'package:food_ordering_app/Screens/order_in_profile.dart';
import 'package:food_ordering_app/widgets/card_profile.dart';

class ProfileButtons extends StatefulWidget {
  const ProfileButtons({super.key});

  @override
  State<ProfileButtons> createState() => _ProfileButtonsState();
}

class _ProfileButtonsState extends State<ProfileButtons> {
  bool isLoading = false;

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
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyPaymentCardsScreen(),
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
                    builder: (context) => const MyPaymentCardsScreen(),
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
                builder: (context) => const AboutUsScreen(),
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
                    builder: (context) => const AboutUsScreen(),
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
    );
  }
}
