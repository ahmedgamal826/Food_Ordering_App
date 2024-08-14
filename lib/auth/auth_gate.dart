import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/splash_screen.dart';
import 'package:food_ordering_app/auth/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in

          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/Test%20Screens/admin_home_page.dart';
// import 'package:food_ordering_app/Screens/splash_screen.dart';
// import 'package:food_ordering_app/auth/home_page.dart';

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasData) {
//             // User is authenticated
//             User? user = snapshot.data;
//             return FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(user!.uid)
//                   .get(),
//               builder: (context, userSnapshot) {
//                 if (userSnapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (userSnapshot.hasData) {
//                   bool isAdmin = userSnapshot.data!['role'] == 'admin';

//                   // Navigate to different pages based on role
//                   if (isAdmin) {
//                     return AdminHomePage();
//                   } else {
//                     return HomePage();
//                   }
//                 } else {
//                   // Handle case where user data is not found
//                   return SplashScreen();
//                 }
//               },
//             );
//           } else {
//             // User is not authenticated
//             return const SplashScreen();
//           }
//         },
//       ),
//     );
//   }
// }
