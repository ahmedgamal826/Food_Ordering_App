import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class CustomCheckButton extends StatefulWidget {
  final Function(BuildContext context, String userId) showCheckoutBottomSheet;

  const CustomCheckButton(
      {super.key, required this.showCheckoutBottomSheet}); // Function parameter

  @override
  State<CustomCheckButton> createState() => _CustomCheckButtonState();
}

class _CustomCheckButtonState extends State<CustomCheckButton> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        elevation: 5,
        onPressed: () async {
          final userId = FirebaseAuth.instance.currentUser?.uid;

          if (userId == null) {
            // Handle the case when userId is null
            customShowSnackBar(
              context: context,
              content: "User is not logged in.",
            );
            return;
          }
          final cartRef =
              FirebaseFirestore.instance.collection('carts').doc(userId);
          final cartSnapshot = await cartRef.get();
          final cartData = cartSnapshot.data() as Map<String, dynamic>?;

          if (cartData != null) {
            widget.showCheckoutBottomSheet(context, userId);
          } else {
            customShowSnackBar(
                context: context, content: 'No Products in Cart');
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Checkout',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
