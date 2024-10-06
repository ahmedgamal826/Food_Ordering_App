// // import 'package:flutter/material.dart';

// // class OnboardingScreen extends StatefulWidget {
// //   @override
// //   _OnboardingScreenState createState() => _OnboardingScreenState();
// // }

// // class _OnboardingScreenState extends State<OnboardingScreen> {
// //   final PageController _pageController = PageController();
// //   int _currentIndex = 0;

// //   void _onPageChanged(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //   }

// //   void _nextPage() {
// //     if (_currentIndex < 2) {
// //       _pageController.nextPage(
// //         duration: Duration(milliseconds: 300),
// //         curve: Curves.easeIn,
// //       );
// //     } else {
// //       // هنا يمكنك الانتقال إلى الصفحة الرئيسية
// //       print("Go to Home Page");
// //     }
// //   }

// //   void _previousPage() {
// //     if (_currentIndex > 0) {
// //       _pageController.previousPage(
// //         duration: Duration(milliseconds: 300),
// //         curve: Curves.easeIn,
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: PageView(
// //               controller: _pageController,
// //               onPageChanged: _onPageChanged,
// //               children: [
// //                 _buildPage(
// //                   color: Colors.orange,
// //                   title: 'توصيل الطعام',
// //                   description: 'استمتع بتوصيل الطعام إلى باب منزلك.',
// //                 ),
// //                 _buildPage(
// //                   color: Colors.green,
// //                   title: 'اختيار المفضل',
// //                   description: 'اختر من مجموعة متنوعة من المطاعم.',
// //                 ),
// //                 _buildPage(
// //                   color: Colors.blue,
// //                   title: 'طلب سريع',
// //                   description: 'اطلب طعامك المفضل في ثوانٍ.',
// //                 ),
// //               ],
// //             ),
// //           ),
// //           const SizedBox(
// //             height: 20,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: List.generate(3, (index) {
// //               return Container(
// //                 margin: const EdgeInsets.all(4.0),
// //                 width: _currentIndex == index ? 25 : 8.0,
// //                 height: 8.0,
// //                 decoration: BoxDecoration(
// //                   color: _currentIndex == index ? Colors.orange : Colors.grey,
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //               );
// //             }),
// //           ),
// //           const SizedBox(height: 20),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 10),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange,
// //                   ),
// //                   onPressed: _previousPage,
// //                   child: const Text(
// //                     'Back',
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.orange,
// //                   ),
// //                   onPressed: _nextPage,
// //                   child: Text(
// //                     _currentIndex == 2 ? 'ٍStart' : 'Next',
// //                     style: const TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 40),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildPage(
// //       {required Color color,
// //       required String title,
// //       required String description}) {
// //     return Container(
// //       color: color,
// //       child: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               title,
// //               style: TextStyle(
// //                   fontSize: 32,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.white),
// //             ),
// //             SizedBox(height: 20),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
// //               child: Text(
// //                 description,
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(fontSize: 18, color: Colors.white),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _nextPage() {
//     if (_currentIndex < 2) {
//       _pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     } else {
//       // هنا يمكنك الانتقال إلى الصفحة الرئيسية
//       print("Go to Home Page");
//     }
//   }

//   void _previousPage() {
//     if (_currentIndex > 0) {
//       _pageController.previousPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               onPageChanged: _onPageChanged,
//               children: [
//                 _buildPage(
//                   color: Colors.orange,
//                   title: 'توصيل الطعام',
//                   description: 'استمتع بتوصيل الطعام إلى باب منزلك.',
//                 ),
//                 _buildPage(
//                   color: Colors.green,
//                   title: 'اختيار المفضل',
//                   description: 'اختر من مجموعة متنوعة من المطاعم.',
//                 ),
//                 _buildPage(
//                   color: Colors.blue,
//                   title: 'طلب سريع',
//                   description: 'اطلب طعامك المفضل في ثوانٍ.',
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(3, (index) {
//               return Container(
//                 margin: const EdgeInsets.all(4.0),
//                 width: _currentIndex == index ? 25 : 8.0,
//                 height: 8.0,
//                 decoration: BoxDecoration(
//                   color: _currentIndex == index ? Colors.orange : Colors.grey,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               );
//             }),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                   ),
//                   onPressed: _previousPage,
//                   child: const Text(
//                     'Back',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                   ),
//                   onPressed: _nextPage,
//                   child: Text(
//                     _currentIndex == 2 ? 'Start' : 'Next',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 40),
//         ],
//       ),
//     );
//   }

//   Widget _buildPage(
//       {required Color color,
//       required String title,
//       required String description}) {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 500),
//       child: Container(
//         key: ValueKey(color), // مفتاح فريد لتفعيل الأنيميشن
//         color: color,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: Text(
//                   description,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin_or_user_screen.dart';
import 'package:food_ordering_app/widgets/build_onboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _nextPage() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminOrUserScreen(),
        ),
        (route) => false,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                buildOnboardScreen(
                  image: 'assets/images/onboarding 1.jpg',
                  color: Colors.white,
                  title: 'Let’s Discover Your Favorite Flavor!',
                  description:
                      'With so many choices, making the right decision can be tough! Do you prefer pizza, burgers, or maybe sushi? Let us help you find what suits your taste!',
                ),
                buildOnboardScreen(
                  image: 'assets/images/onboarding 2.jpg',
                  color: Colors.white,
                  title: 'Speedy Deliveries at Your Service!',
                  description:
                      "Ready to deliver orders in a flash! With every minute counting, we're here to provide the best delivery service right to your door. Let us take you to your favorite destination!",
                ),
                buildOnboardScreen(
                  image: 'assets/images/on boadring 3.jpg',
                  color: Colors.white,
                  title: 'Delicious Delights Just Delivered!',
                  description:
                      "A delicious assortment of mouthwatering foods! From a tasty burger to delightful sushi and refreshing drinks, everything you need to satisfy your cravings in one meal. Enjoy a diverse culinary experience!",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                width: _currentIndex == index ? 30 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.orange : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: _previousPage,
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: _nextPage,
                  child: Text(
                    _currentIndex == 2 ? 'Start' : 'Next',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
