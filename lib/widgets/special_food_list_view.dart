// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/models/special_food_model.dart';
// // import 'package:food_ordering_app/widgets/custom_category.dart';
// // import 'package:food_ordering_app/widgets/special_food_list.dart';

// // class SpecialFoodListView extends StatelessWidget {
// //   const SpecialFoodListView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     ScrollController _scrollController = ScrollController();

// //     return Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.only(left: 20, bottom: 10),
// //           child: Row(
// //             children: [
// //               const Text(
// //                 'Special Food',
// //                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
// //               ),
// //               const Spacer(),
// //               TextButton(
// //                 onPressed: () {
// //                   _scrollController.animateTo(
// //                       _scrollController.position.maxScrollExtent,
// //                       duration: const Duration(milliseconds: 500),
// //                       curve: Curves.easeIn);
// //                 },
// //                 child: const Text(
// //                   'View all >',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     color: Color(0xffF97316),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         SizedBox(
// //           height: 270,
// //           child: ListView.builder(
// //             itemCount: specialFoods.length,
// //             itemBuilder: (context, index) {
// //               SpecialFood food = specialFoods[index];
// //               return Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(8.0),
// //                       child: Image.network(
// //                         food.imageUrl,
// //                         width: 200,
// //                         height: 150,
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                     SizedBox(height: 8.0),
// //                     Text(
// //                       food.title,
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 16.0,
// //                       ),
// //                     ),
// //                     SizedBox(height: 4.0),
// //                     Row(
// //                       children: [
// //                         Text(
// //                           '\$${food.price.toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 16.0,
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           width: 50,
// //                         ),
// //                         ElevatedButton(
// //                           style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.orange),
// //                           onPressed: () {},
// //                           child: Text(
// //                             'Add to cart',
// //                             style: TextStyle(
// //                                 fontSize: 15,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.white),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //             controller: _scrollController,
// //             scrollDirection: Axis.horizontal,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/order_screen.dart';
// import 'package:food_ordering_app/models/special_food_model.dart';
// import 'package:food_ordering_app/widgets/special_food_list.dart';

// class SpecialFoodListView extends StatelessWidget {
//   SpecialFoodListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ScrollController _scrollController = ScrollController();

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20, bottom: 10),
//           child: Row(
//             children: [
//               const Text(
//                 'Special Food',
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               TextButton(
//                 onPressed: () {
//                   _scrollController.animateTo(
//                       _scrollController.position.maxScrollExtent,
//                       duration: const Duration(milliseconds: 500),
//                       curve: Curves.easeIn);
//                 },
//                 child: const Text(
//                   'View all >',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Color(0xffF97316),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 270,
//           child: ListView.builder(
//             itemCount: specialFoods.length,
//             itemBuilder: (context, index) {
//               SpecialFood food = specialFoods[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.network(
//                         food.imageUrl,
//                         width: 200,
//                         height: 150,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       food.title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     SizedBox(height: 4.0),
//                     Row(
//                       children: [
//                         Text(
//                           '\$${food.price.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 50,
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orange),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => MyOrderScreen(
//                                   food: food,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             'Add to cart',
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/special_food_model.dart';
import 'package:food_ordering_app/widgets/orders_list.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:food_ordering_app/widgets/special_food_list.dart';

class SpecialFoodListView extends StatelessWidget {
  SpecialFoodListView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Row(
            children: [
              const Text(
                'Special Food',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffF97316),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            itemCount: specialFoods.length,
            itemBuilder: (context, index) {
              SpecialFood food = specialFoods[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        food.imageUrl,
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      food.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          '\$${food.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            orderList.add(food);
                            customShowSnackBar(
                                context: context,
                                content: '${food.title} is added to cart');
                          },
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
