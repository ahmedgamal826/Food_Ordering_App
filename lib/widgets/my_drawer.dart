// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/order_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class MyDrawer extends StatelessWidget {
//   MyDrawer({super.key, required this.name, required this.email});

//   String name;
//   String email;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.orange,
//       child: ListView(
//         children: [
//           DrawerHeader(
//             child: Column(
//               children: [
//                 const CircleAvatar(
//                   backgroundImage: AssetImage('assets/images/ahmed.jpg'),
//                   radius: 40,
//                 ),
//                 Text(
//                   name,
//                   style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 Expanded(
//                   child: Text(
//                     email,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'My Profile',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//               // Add navigation to My Profile screen
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.info,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'About',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//               // Add navigation to My Profile screen
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.restaurant_menu,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'Menu',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//               // Add navigation to Order History screen
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.shopping_cart,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'Order',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyOrderScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.local_offer,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'Offers',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//               // Add navigation to Help & Support screen
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.contact_phone,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'Contact',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//               // Add navigation to Help & Support screen
//             },
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(
//               Icons.exit_to_app,
//               color: Colors.white,
//             ),
//             title: const Text(
//               'Sign Out',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             onTap: () async {
//               GoogleSignIn googleSignIn = GoogleSignIn();
//               googleSignIn.disconnect();
//               await FirebaseAuth.instance.signOut();
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil("loginScreen", (route) => false);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
