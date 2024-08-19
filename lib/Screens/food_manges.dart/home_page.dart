// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:food_ordering_app/auth/auth_services.dart';
// // // // // import 'package:food_ordering_app/auth/profile_screen.dart';
// // // // // import 'package:provider/provider.dart';

// // // // // // import '../model/chat_user.dart';

// // // // // class HomePage extends StatefulWidget {
// // // // //   const HomePage({super.key});

// // // // //   @override
// // // // //   State<HomePage> createState() => _HomePageState();
// // // // // }

// // // // // class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
// // // // //   @override
// // // // //   FirebaseFirestore _firestore = FirebaseFirestore.instance;

// // // // //   void initState() {
// // // // //     // TODO: implement initState
// // // // //     super.initState();
// // // // //     WidgetsBinding.instance.addObserver(this);
// // // // //     // setStatus("Online");
// // // // //   }

// // // // //   // void setStatus(String status) async {
// // // // //   //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
// // // // //   //     "status": status,
// // // // //   //   });
// // // // //   // }

// // // // //   // @override
// // // // //   // void didChangeAppLifecycleState(AppLifecycleState state) {
// // // // //   //   if (state == AppLifecycleState.resumed) {
// // // // //   //     setStatus("Online");

// // // // //   //     // online
// // // // //   //   } else {
// // // // //   //     setStatus("Offline");
// // // // //   //     // offline
// // // // //   //   }
// // // // //   // }

// // // // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // // // //   final _controller = ScrollController();

// // // // //   final nameController = TextEditingController();

// // // // //   late Map<String, dynamic> userMap;

// // // // //   //void onSearch() async {}

// // // // //   // sign user out
// // // // //   void signOut() {
// // // // //     // get auth service

// // // // //     final authService = Provider.of<AuthService>(context, listen: false);

// // // // //     authService.signOut();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         leading: BackButton(onPressed: signOut),
// // // // //         actions: [
// // // // //           IconButton(
// // // // //               onPressed: () {
// // // // //                 // Navigator.push(
// // // // //                 //   context,
// // // // //                 //   MaterialPageRoute(
// // // // //                 //     builder: (context) => SearchPage(),
// // // // //                 //   ),
// // // // //                 // );
// // // // //               },
// // // // //               // search icon
// // // // //               icon: Icon(
// // // // //                 Icons.search,
// // // // //                 size: 30,
// // // // //               )),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.only(right: 5, left: 3),
// // // // //             child: IconButton(
// // // // //                 onPressed: () {
// // // // //                   Navigator.push(
// // // // //                     context,
// // // // //                     MaterialPageRoute(
// // // // //                       builder: (context) => Profile_Screen(),
// // // // //                     ),
// // // // //                   );
// // // // //                 },
// // // // //                 icon: Icon(
// // // // //                   Icons.account_circle_rounded,
// // // // //                   size: 40,
// // // // //                   color: Colors.white,
// // // // //                 )),
// // // // //           )
// // // // //         ],
// // // // //         title: Text(
// // // // //           "Chats",
// // // // //           style: TextStyle(fontSize: 30),
// // // // //         ),
// // // // //       ),
// // // // //       body: _buildUserList(),
// // // // //     );
// // // // //   }

// // // // //   // build a list of users except for the current logged in user

// // // // //   Widget _buildUserList() {
// // // // //     return StreamBuilder<QuerySnapshot>(
// // // // //         stream: FirebaseFirestore.instance.collection('users').snapshots(),
// // // // //         builder: (context, snapshot) {
// // // // //           if (snapshot.hasError) {
// // // // //             return const Text('error');
// // // // //           }

// // // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // //             return const Text('leading..');
// // // // //           }

// // // // //           return ListView(
// // // // //             children: snapshot.data!.docs
// // // // //                 .map<Widget>((doc) => _buildUserListItem(doc))
// // // // //                 .toList(),
// // // // //           );
// // // // //         });
// // // // //   }

// // // // //   // build individual user list items
// // // // //   Widget _buildUserListItem(DocumentSnapshot document) {
// // // // //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

// // // // //     // display all users except current user

// // // // //     if (_auth.currentUser!.displayName != data['name']) {
// // // // //       return Padding(
// // // // //         padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             Text(
// // // // //               'Name: ',
// // // // //               style: TextStyle(fontSize: 30),
// // // // //             ),
// // // // //             Text(data['name']),
// // // // //             SizedBox(
// // // // //               height: 20,
// // // // //             ),
// // // // //             Container(
// // // // //               color: Colors.white,
// // // // //               child: ListTile(
// // // // //                 title: Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.start,
// // // // //                   children: [
// // // // //                     CircleAvatar(
// // // // //                       minRadius: 25,
// // // // //                       child: Text(
// // // // //                         data['name'][0],
// // // // //                         style: TextStyle(fontSize: 30),
// // // // //                       ),
// // // // //                     ),
// // // // //                     SizedBox(
// // // // //                       width: 8,
// // // // //                     ),
// // // // //                     Text(
// // // // //                       data['name'],
// // // // //                       style: TextStyle(fontSize: 25, color: Colors.black),
// // // // //                     ),
// // // // //                   ],
// // // // //                 )

// // // // //                 //
// // // // //                 ,
// // // // //                 onTap: () {
// // // // //                   _controller.position.maxScrollExtent;
// // // // //                   // pass the clicked user's ID to the chat page

// // // // //                   // Navigator.push(
// // // // //                   //   context,
// // // // //                   //   MaterialPageRoute(
// // // // //                   //     builder: (context) => ChatPage(
// // // // //                   //       receiverUserEmail: data['email'],
// // // // //                   //       receiverUserID: data['uid'],
// // // // //                   //       receiverUserName: data['name'],
// // // // //                   //       receiverUserStatus: data['status'],
// // // // //                   //     ),
// // // // //                   //   ),
// // // // //                   // );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       );
// // // // //     } else {
// // // // //       // return empty container
// // // // //       return Container();
// // // // //     }
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:food_ordering_app/auth/auth_services.dart';

// // // // class HomePage extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final authService = Provider.of<AuthService>(context);

// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Home Page'),
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: Icon(Icons.logout),
// // // //             onPressed: () {
// // // //               authService.signOut();
// // // //               Navigator.pushReplacementNamed(context, 'loginScreen');
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             Text(
// // // //               'Name: ${authService.userName ?? 'Loading...'}',
// // // //               style: TextStyle(fontSize: 20),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             Text(
// // // //               'Email: ${authService.userEmail ?? 'Loading...'}',
// // // //               style: TextStyle(fontSize: 20),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:food_ordering_app/auth/auth_services.dart';

// // // class HomePage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final authService = Provider.of<AuthService>(context);

// // //     // Ensure user data is loaded before displaying the page
// // //     return FutureBuilder(
// // //       future: authService
// // //           .loadUserData(), // Ensure this method is implemented in AuthService
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return Scaffold(
// // //             appBar: AppBar(
// // //               title: Text('Home Page'),
// // //             ),
// // //             body: Center(
// // //               child: CircularProgressIndicator(),
// // //             ),
// // //           );
// // //         } else if (snapshot.hasError) {
// // //           return Scaffold(
// // //             appBar: AppBar(
// // //               title: Text('Home Page'),
// // //             ),
// // //             body: Center(
// // //               child: Text('Error: ${snapshot.error}'),
// // //             ),
// // //           );
// // //         } else {
// // //           return Scaffold(
// // //             appBar: AppBar(
// // //               title: Text('Home Page'),
// // //               actions: [
// // //                 IconButton(
// // //                   icon: Icon(Icons.logout),
// // //                   onPressed: () {
// // //                     authService.signOut();
// // //                     Navigator.pushReplacementNamed(context, 'loginScreen');
// // //                   },
// // //                 ),
// // //               ],
// // //             ),
// // //             body: Center(
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   Text(
// // //                     'Name: ${authService.userName ?? 'Loading...'}',
// // //                     style: TextStyle(fontSize: 20),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Text(
// // //                     'Email: ${authService.userEmail ?? 'Loading...'}',
// // //                     style: TextStyle(fontSize: 20),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         }
// // //       },
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:food_ordering_app/auth/auth_services.dart';

// // class HomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final authService = Provider.of<AuthService>(context);

// //     // Ensure user data is loaded before displaying the page
// //     return StreamBuilder(
// //       stream: authService
// //           .authStateChanges, // Stream of authentication state changes
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Scaffold(
// //             appBar: AppBar(
// //               title: Text('Home Page'),
// //             ),
// //             body: Center(
// //               child: CircularProgressIndicator(),
// //             ),
// //           );
// //         } else if (snapshot.hasError) {
// //           return Scaffold(
// //             appBar: AppBar(
// //               title: Text('Home Page'),
// //             ),
// //             body: Center(
// //               child: Text('Error: ${snapshot.error}'),
// //             ),
// //           );
// //         } else {
// //           // Check if user is logged in
// //           if (!authService.isLoggedIn) {
// //             return Scaffold(
// //               appBar: AppBar(
// //                 title: Text('Home Page'),
// //               ),
// //               body: Center(
// //                 child: Text('User is not logged in'),
// //               ),
// //             );
// //           }

// //           // Display user information
// //           return Scaffold(
// //             appBar: AppBar(
// //               title: Text('Home Page'),
// //               actions: [
// //                 IconButton(
// //                   icon: Icon(Icons.logout),
// //                   onPressed: () {
// //                     authService.signOut();
// //                     Navigator.pushReplacementNamed(context, 'loginScreen');
// //                   },
// //                 ),
// //               ],
// //             ),
// //             body: Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     'Name: ${authService.userName ?? 'Loading...'}',
// //                     style: TextStyle(fontSize: 20),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Text(
// //                     'Email: ${authService.userEmail ?? 'Loading...'}',
// //                     style: TextStyle(fontSize: 20),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }
// //       },
// //     );
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:food_ordering_app/auth/auth_services.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);

//     // Ensure user data is loaded before displaying the page
//     return StreamBuilder<User?>(
//       stream: authService.authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Home Page'),
//             ),
//             body: const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.orange,
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Home Page'),
//             ),
//             body: Center(
//               child: Text('Error: ${snapshot.error}'),
//             ),
//           );
//         } else {
//           // Check if user is logged in
//           if (!authService.isLoggedIn) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text('Home Page'),
//               ),
//               body: const Center(
//                 child: Text('User is not logged in'),
//               ),
//             );
//           }

//           // Display user information
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Home Page'),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.logout),
//                   onPressed: () {
//                     authService.signOut();
//                     Navigator.pushReplacementNamed(context, 'LoginOrRegister');
//                   },
//                 ),
//               ],
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Name: Welcome 👋 ${authService.userName ?? 'Loading...'}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Email: ${authService.userEmail ?? 'Loading...'}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
