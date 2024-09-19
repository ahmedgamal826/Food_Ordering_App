// import 'package:flutter/material.dart';

// class PriceDisplayWidget extends StatelessWidget {
//   final String collectionName;
//   final double price;
//   final double? priceBeforeDiscount;

//   const PriceDisplayWidget({
//     Key? key,
//     required this.collectionName,
//     required this.price,
//     this.priceBeforeDiscount,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 60,
//       child: collectionName == 'offers_category'
//           ? Text(
//               textAlign: TextAlign.center,
//               '\$${priceBeforeDiscount?.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 decoration: TextDecoration.lineThrough,
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             )
//           : Text(
//               textAlign: TextAlign.center,
//               '\$${price.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.orange,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//     );
//   }
// }
