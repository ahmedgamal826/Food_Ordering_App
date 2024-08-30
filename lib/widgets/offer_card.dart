import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/offers_model.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.27,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ClipRRect(
                    child: Image.asset(
                      offer.imageUrl,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          offer.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '\$${offer.originalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '\$${offer.discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          // color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                //   child: Text(
                //     'Discount: ${offer.discount}',
                //     style: TextStyle(
                //         color: Colors.orange,
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 5,
          child: Container(
            width: 40,
            color: Colors.red,
            child: Text(
              textAlign: TextAlign.center,
              '${offer.discount}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
    // return Card(
    //   margin: EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 150,
    //         width: double.infinity,
    //         child: ClipRRect(
    //           child: Image.asset(
    //             offer.imageUrl,
    //             fit: BoxFit.cover,
    //             width: double.infinity,
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           offer.title,
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //         child: Row(
    //           children: [
    //             Text(
    //               '\$${offer.originalPrice.toStringAsFixed(2)}',
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 decoration: TextDecoration.lineThrough,
    //                 color: Colors.red,
    //               ),
    //             ),
    //             SizedBox(width: 8),
    //             Text(
    //               '\$${offer.discountedPrice.toStringAsFixed(2)}',
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 color: Colors.green,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    //         child: Text(
    //           'Discount: ${offer.discount}',
    //           style: TextStyle(
    //               color: Colors.orange,
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
