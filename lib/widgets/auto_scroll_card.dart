// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/widgets/action_admin_buttons.dart';
// import 'package:food_ordering_app/widgets/custom_name_category.dart';
// import 'package:food_ordering_app/widgets/price_admin_category.dart';
// import 'package:food_ordering_app/widgets/price_after_discount_admin.dart';
// import 'package:food_ordering_app/widgets/price_and_favourite_button.dart';

// class AutoScrollCard extends StatefulWidget {
//   final String imageUrl;
//   final String collectionName;
//   final String name;
//   final String discountOffer;
//   final double price;
//   final double priceAfterDiscount;
//   final bool isAdmin;
//   final String docId;
//   final dynamic data;
//   final Function onDelete;
//   final String description;
//   final List<bool> isFavouriteList;
//   final int index;

//   const AutoScrollCard({
//     Key? key,
//     required this.imageUrl,
//     required this.collectionName,
//     required this.name,
//     required this.discountOffer,
//     required this.price,
//     required this.priceAfterDiscount,
//     required this.isAdmin,
//     required this.docId,
//     required this.data,
//     required this.onDelete,
//     required this.description,
//     required this.isFavouriteList,
//     required this.index,
//   }) : super(key: key);

//   @override
//   _AutoScrollCardState createState() => _AutoScrollCardState();
// }

// class _AutoScrollCardState extends State<AutoScrollCard> {
//   final ScrollController _scrollController = ScrollController();
//   bool _autoScrollEnabled = true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       if (_scrollController.position.maxScrollExtent >
//               _scrollController.offset &&
//           _autoScrollEnabled) {
//         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: SingleChildScrollView(
//         controller: _scrollController,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('dsffff'),
//             widget.collectionName == 'offers_category'
//                 ? Stack(
//                     children: [
//                       SizedBox(
//                         height: 115,
//                         width: double.infinity,
//                         child: widget.imageUrl.startsWith('http')
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.network(
//                                   fit: BoxFit.cover,
//                                   widget.imageUrl,
//                                 ),
//                               )
//                             : const Center(
//                                 child: Icon(
//                                   Icons.image,
//                                   size: 120,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                       ),
//                       Container(
//                         width: 40,
//                         color: Colors.red,
//                         child: Text(
//                           textAlign: TextAlign.center,
//                           '${widget.discountOffer}%',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : SizedBox(
//                     height: 115,
//                     width: double.infinity,
//                     child: widget.imageUrl.startsWith('http')
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               fit: BoxFit.cover,
//                               widget.imageUrl,
//                             ),
//                           )
//                         : const Center(
//                             child: Icon(
//                               Icons.image,
//                               size: 120,
//                               color: Colors.black,
//                             ),
//                           ),
//                   ),
//             CustomNameCategory(name: widget.name),
//             const SizedBox(height: 5),
//             Flexible(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   PriceAdminCategory(
//                     collectionName: widget.collectionName,
//                     price: widget.price as double,
//                     priceBeforeDiscount: widget.priceAfterDiscount as double,
//                   ),
//                   const SizedBox(width: 10),
//                   widget.collectionName == 'offers_category'
//                       ? PriceAfterDiscountAdmin(price: widget.price as double)
//                       : const SizedBox(),
//                 ],
//               ),
//             ),
//             Flexible(
//               child: widget.isAdmin
//                   ? ActionAdminButtons(
//                       collectionName: widget.collectionName,
//                       foodData: widget.data,
//                       docId: widget.docId,
//                       name: widget.name,
//                       onDelete: widget.onDelete,
//                     )
//                   : PriceAndFavouriteButton(
//                       description: widget.description,
//                       docId: widget.docId,
//                       imageUrl: widget.imageUrl,
//                       index: widget.index,
//                       isFavouriteList: widget.isFavouriteList,
//                       name: widget.name,
//                       price: widget.price.toString(),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
