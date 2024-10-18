import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/discount_image.dart';
import 'custom_image_offers.dart'; // Update with your actual path
import 'custom_text_widget.dart'; // Update with your actual path
import 'price_before_discount_widget.dart'; // Update with your actual path
import 'price_after_discount.dart'; // Update with your actual path
import 'favourite_icon_button.dart'; // Update with your actual path

class UserCategoryCard extends StatelessWidget {
  final String collectionName;
  final String imageUrl;
  final String name;
  final double price;
  final double priceBeforeDiscount;

  final String description;
  final String docId;
  final dynamic discountOffer; // Change to the appropriate type
  final List<bool>
      isFavouriteList; // Assuming this is a list for your favourites
  final int index; // If you need to specify index

  const UserCategoryCard({
    Key? key,
    required this.collectionName,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.priceBeforeDiscount,
    required this.description,
    required this.docId,
    this.discountOffer,
    required this.isFavouriteList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight =
        MediaQuery.of(context).size.height * 0.25; // 25% من ارتفاع الشاشة

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: cardHeight, // تعيين ارتفاع الـ Card
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('dfgdffd'),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'dfgdgf',
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Expanded(
              child: collectionName == 'offers_category'
                  ? DiscountedImage(
                      discountOffer: discountOffer,
                      imageUrl: imageUrl,
                    )
                  : CustomImageOffers(
                      imageUrl: imageUrl,
                    ),
            ),

            CustomTextWidget(name: name),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PriceBeforeDiscountWidget(
                    collectionName: collectionName,
                    price: price,
                    priceBeforeDiscount: priceBeforeDiscount,
                  ),
                  if (collectionName == 'offers_category')
                    PriceAfterDiscount(price: price),
                  if (collectionName != 'offers_category')
                    StatefulBuilder(
                      builder: (context, setState) {
                        return FavouriteIconButton(
                          description: description,
                          docId: docId,
                          imageUrl: imageUrl,
                          isFavourite: isFavouriteList[index],
                          name: name,
                          price: price,
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
