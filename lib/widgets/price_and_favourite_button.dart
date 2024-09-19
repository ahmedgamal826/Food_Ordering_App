import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class PriceAndFavouriteButton extends StatefulWidget {
  final String price;
  final String name;
  final String imageUrl;
  final String description;
  final String docId;
  final List<bool> isFavouriteList;
  final int index;

  const PriceAndFavouriteButton({
    Key? key,
    required this.price,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.docId,
    required this.isFavouriteList,
    required this.index,
  }) : super(key: key);

  @override
  _PriceAndFavouriteButtonState createState() =>
      _PriceAndFavouriteButtonState();
}

class _PriceAndFavouriteButtonState extends State<PriceAndFavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '\$${widget.price}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
              maxLines: 2, // Limit the number of lines
            ),
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                widget.isFavouriteList[widget.index] =
                    !widget.isFavouriteList[widget.index];
              });

              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                final userId = user.uid;

                final docRef = FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('favourites')
                    .doc(widget
                        .docId); // Use user ID to create or reference the document

                if (widget.isFavouriteList[widget.index]) {
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

              customShowSnackBar(
                context: context,
                content:
                    '${widget.name} is ${widget.isFavouriteList[widget.index] ? 'added to' : 'removed from'} favourites',
              );
            },
            icon: Icon(
              widget.isFavouriteList[widget.index]
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: widget.isFavouriteList[widget.index]
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
