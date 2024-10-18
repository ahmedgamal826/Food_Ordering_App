import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

// ويدجيت مخصص لزر المفضلة
class FavouriteIconButton extends StatefulWidget {
  final String docId;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final bool isFavourite;

  const FavouriteIconButton({
    Key? key,
    required this.docId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.isFavourite,
  }) : super(key: key);

  @override
  _FavouriteIconButtonState createState() => _FavouriteIconButtonState();
}

class _FavouriteIconButtonState extends State<FavouriteIconButton> {
  late bool isFavourite;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.isFavourite;
  }

  Future<void> _toggleFavourite() async {
    setState(() {
      isFavourite = !isFavourite;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favourites')
          .doc(widget.docId);

      if (isFavourite) {
        // Add to favourites
        await docRef.set({
          'name': widget.name,
          'price': widget.price,
          'imageUrl': widget.imageUrl,
          'description': widget.description,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Remove from favourites
        await docRef.delete();
      }
    }

    // Show a snack bar
    customShowSnackBar(
      context: context,
      content: isFavourite
          ? '${widget.name} is added to favourites'
          : '${widget.name} is removed from favourites',
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavourite,
      icon: Icon(
        size: 25,
        isFavourite ? Icons.favorite : Icons.favorite_border,
        color: isFavourite ? Colors.red : Colors.black,
      ),
    );
  }
}
