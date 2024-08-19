// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
// import 'package:food_ordering_app/Screens/food_manges.dart/food_list.dart';
// import 'package:food_ordering_app/widgets/category_list_view.dart';

// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key});

//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   bool isLoading = false;

//   // void updateSearchQuery(String query) {
//   //   setState(() {
//   //     searchQuery = query;
//   //   });
//   // }

//   Future<void> logout(BuildContext context) async {
//     setState(() {
//       isLoading = true; // عرض دائرة التحميل
//     });

//     await FirebaseAuth.instance.signOut();

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AdminOrUserScreen(),
//       ),
//     ).whenComplete(() {
//       setState(() {
//         isLoading = false; // إخفاء دائرة التحميل
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         centerTitle: true,
//         title: const Text(
//           "Admin - Manage Foods",
//           style: TextStyle(
//             fontSize: 23,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               logout(context);
//             },
//             icon: const Icon(
//               Icons.logout,
//             ),
//           )
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Text(
//               'Welcome, User! 👋 ',
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'Explore our delicious range of foods, refreshing drinks, and tempting sweets. Find your favorites and enjoy amazing offers just for you!',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           FoodList(
//             collectionName: 'burgers',
//             foodDetailsRoute: '',
//             foodName: 'Burger',
//             searchQuery: '',
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/Foods%20Screens/burgers_screen.dart';
import 'package:food_ordering_app/auth/auth_services.dart';
import 'package:food_ordering_app/widgets/category_list_view.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Page'),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Home Page'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Check if user is logged in
          if (!authService.isLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Page'),
              ),
              body: const Center(
                child: Text('User is not logged in'),
              ),
            );
          }

          // Display user information

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              centerTitle: true,
              title: const Text(
                'User Home Page',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    logout(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                  ),
                )
              ],
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    'Welcome 👋 ${authService.userName ?? 'Loading...'}',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Let's eat",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    'Nutrious food.',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(height: 20),
                CategoryListView(
                  categoryName: 'Foods',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BurgersScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
                CategoryListView(
                  categoryName: 'Drinks',
                  onTap: () {
                    Navigator.pushNamed(context, 'drinksScreen');
                  },
                ),
                SizedBox(height: 20),
                CategoryListView(
                  categoryName: 'Sweets',
                  onTap: () {
                    Navigator.pushNamed(context, 'sweetsScreen');
                  },
                ),
                SizedBox(height: 20),
                CategoryListView(
                  categoryName: 'Popular Offers',
                  onTap: () {
                    Navigator.pushNamed(context, 'offersScreen');
                  },
                ),
              ],
            ),
          );

          // return Scaffold(
          //   appBar: AppBar(
          //     centerTitle: true,
          //     backgroundColor: Colors.orange,
          //     title: Text(
          //       'Home Page',
          //       style: TextStyle(
          //         fontSize: 25,
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     actions: [
          //       IconButton(
          //         icon: const Icon(Icons.logout),
          //         onPressed: () {
          //           authService.signOut();
          //           Navigator.pushReplacementNamed(context, 'LoginOrRegister');
          //         },
          //       ),
          //     ],
          //   ),
          //   body: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ListView(
          //       children: [
          //         const SizedBox(
          //           height: 30,
          //         ),
          //         Text(
          //           'Welcome 👋 ${authService.userName ?? 'Loading...'}',
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         SizedBox(height: 10),
          //         // Text(
          //         //   'Email: ${authService.userEmail ?? 'Loading...'}',
          //         //   style: TextStyle(fontSize: 20),
          //         // ),
          //       ],
          //     ),
          //   ),
          // );
        }
      },
      // child: Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Colors.orange,
      //     centerTitle: true,
      //     title: const Text(
      //       'Welcome to Food Ordering',
      //       style: TextStyle(
      //         fontSize: 23,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //       ),
      //     ),
      //     actions: [
      //       IconButton(
      //         onPressed: () {
      //           logout(context);
      //         },
      //         icon: const Icon(
      //           Icons.logout,
      //         ),
      //       )
      //     ],
      //   ),
      //   body: ListView(
      //     physics: const BouncingScrollPhysics(),
      //     children: [
      //       Padding(
      //         padding: EdgeInsets.all(20),
      //         child: Text(
      //           'Explore our delicious range of foods, refreshing drinks, and tempting sweets.',
      //           style: TextStyle(
      //             fontSize: 18,
      //             color: Colors.grey,
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       CategoryListView(
      //         categoryName: 'Foods',
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => BurgersScreen()),
      //           );
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       CategoryListView(
      //         categoryName: 'Drinks',
      //         onTap: () {
      //           Navigator.pushNamed(context, 'drinksScreen');
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       CategoryListView(
      //         categoryName: 'Sweets',
      //         onTap: () {
      //           Navigator.pushNamed(context, 'sweetsScreen');
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       CategoryListView(
      //         categoryName: 'Popular Offers',
      //         onTap: () {
      //           Navigator.pushNamed(context, 'offersScreen');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
