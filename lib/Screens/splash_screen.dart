// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   void initState() {
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => AdminOrUserScreen(),
//           ),
//         );
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Positioned(
//               top: screenHeight * 0.3,
//               child: Image.asset(
//                 width: screenWidth * 0.5,
//                 height: screenHeight * 0.3,
//                 'assets/images/delivery_man.png',
//               ),
//             ),
//             Positioned(
//               top: screenHeight * 0.53,
//               child: const Text(
//                 'Food Delivery App',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:food_ordering_app/auth/login_page.dart';
import 'package:food_ordering_app/onboarding%20screen/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.orange,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Food Delivery App', //
                speed: const Duration(milliseconds: 200), // سرعة الكتابة
              ),
            ],
            totalRepeatCount: 1, // تكرار الأنيميشن مرة واحدة فقط
            pause:
                const Duration(milliseconds: 500), // توقف قصير بعد نهاية النص
            displayFullTextOnTap: true, // عرض النص بالكامل عند الضغط
            stopPauseOnTap: true, // إيقاف التوقف عند الضغط
            onFinished: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
