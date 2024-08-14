// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/widgets/search_textform_field.dart';

// // class BurgersScreen extends StatelessWidget {
// //   const BurgersScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: ListView(
// //         children: [
// //           const Padding(
// //             padding: EdgeInsets.only(left: 20, top: 50),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "What is your",
// //                   style: TextStyle(
// //                     fontSize: 30,
// //                   ),
// //                 ),
// //                 Text(
// //                   'favourite burger?',
// //                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// //                 )
// //               ],
// //             ),
// //           ),
// //           SearchTextformField(
// //             hintText: 'Search your burger...',
// //           ),
// //           SizedBox(
// //             height: 400,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 15),
// //               child: GridView.builder(
// //                   itemCount: 10,
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 2, crossAxisSpacing: 10),
// //                   itemBuilder: (context, index) {
// //                     return Column(
// //                       children: [
// //                         Container(
// //                           height: 150,
// //                           decoration: BoxDecoration(
// //                             image: DecorationImage(
// //                               image: AssetImage(
// //                                 'assets/images/chicken-burger.jpg',
// //                               ),
// //                             ),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                         ),
// //                         Text('data')
// //                       ],
// //                     );
// //                   }),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/search_textform_field.dart';

class BurgersScreen extends StatefulWidget {
  const BurgersScreen({super.key});

  @override
  _BurgersScreenState createState() => _BurgersScreenState();
}

class _BurgersScreenState extends State<BurgersScreen> {
  // List<String> burgerImages = [
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  //   'assets/images/chicken-burger.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What is your",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'favourite burger?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SearchTextformField(
            hintText: 'Search your burger...',
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'burgerDetailsScreen');
                        },
                        child: Container(
                          width: 200, // Adjust width as needed
                          height: 200, // Adjust height as needed
                          decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: AssetImage(
                              //       'assets/images/burger_gridView.png'),
                              // ),
                              // borderRadius: BorderRadius.circular(10),
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text(
                    //   'Grilled Chicken Burger',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 16,
                    //   ),
                    // ),
                    SizedBox(height: 4),
                    SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class BurgersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ListView(
//           children: [
            
//           ],
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 50),
//               Text(
//                 "What is your",
//                 style: TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//               Text(
//                 'favorite burger?',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search your burger...',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 10,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pushNamed(context, 'burgerDetailsScreen');
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                       'assets/images/chicken-burger.jpg'),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Grilled Chicken Burger',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         SizedBox(height: 8),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_bag),
//             label: 'Shop',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
