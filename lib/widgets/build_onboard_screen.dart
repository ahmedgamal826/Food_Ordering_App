// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/constants/constants_variables.dart';

// // Widget buildOnboardScreen({
// //   required String image,
// //   required Color color,
// //   required String title,
// //   required String description,
// //   required BuildContext context,
// //   required bool isOut,
// // }) {
// //   return AnimatedSwitcher(
// //     duration: const Duration(milliseconds: 500),
// //     child: Container(
// //       key: ValueKey(color), // مفتاح فريد لتفعيل الأنيميشن
// //       color: color,
// //       child: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             SizedBox(
// //               width: width(context),
// //               height: height(context) * 0.5,
// //               child: AnimatedScale(
// //                 // ignore: dead_code
// //                 scale: isOut ? 0 : 1,
// //                 duration: const Duration(
// //                   milliseconds: 250,
// //                   // values of Animation ==> from 200 to 300
// //                 ),
// //                 child: Image.asset(image),
// //               ),
// //             ),
// //             // Image.asset(image),
// //             // const SizedBox(height: 20),
// //             FittedBox(
// //               fit: BoxFit.scaleDown,
// //               child: Text(
// //                 textAlign: TextAlign.center,
// //                 title,
// //                 style: const TextStyle(
// //                   fontSize: 23,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
// //               child: Text(
// //                 description,
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(
// //                   fontSize: 18,
// //                   color: Colors.black,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //   );
// // }

// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/constants/constants_variables.dart';

// // Widget buildOnboardScreen({
// //   required String image,
// //   required Color color,
// //   required String title,
// //   required String description,
// //   required BuildContext context,
// //   required bool isOut,
// // }) {
// //   return Stack(
// //     children: [
// //       AnimatedSwitcher(
// //         duration: const Duration(milliseconds: 500),
// //         child: Container(
// //           key: ValueKey(color), // مفتاح فريد لتفعيل الأنيميشن
// //           color: color,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               SizedBox(
// //                 width: width(context),
// //                 height: height(context) * 0.5,
// //                 child: AnimatedScale(
// //                   scale: isOut ? 0 : 1,
// //                   duration: const Duration(milliseconds: 250),
// //                   child: Image.asset(image),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),

// //       // Position the Title using AnimatedPositioned
// //       AnimatedPositioned(
// //         duration: const Duration(milliseconds: 500),
// //         left: isOut
// //             ? width(context) + 100
// //             : width(context) * 0.2, // تحريك النص عند تغيير isOut
// //         top: height(context) * 0.6,
// //         child: FittedBox(
// //           fit: BoxFit.scaleDown,
// //           child: Text(
// //             title,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 23,
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black,
// //             ),
// //           ),
// //         ),
// //       ),

// //       // Position the Description using AnimatedPositioned
// //       AnimatedPositioned(
// //         duration: const Duration(milliseconds: 500),
// //         left: isOut
// //             ? width(context) + 100
// //             : width(context) * 0.2, // تحريك النص عند تغيير isOut
// //         bottom: 80,
// //         right: 40,
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 40.0),
// //           child: Text(
// //             description,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 18,
// //               color: Colors.black,
// //             ),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );
// // }

// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/constants/constants_variables.dart';

// Widget buildOnboardScreen({
//   required String image,
//   required Color color,
//   required String title,
//   required String description,
//   required BuildContext context,
//   required bool isOut,
// }) {
//   return AnimatedContainer(
//     duration: const Duration(milliseconds: 500),
//     color: color,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // صورة متحركة باستخدام AnimatedScale
//         SizedBox(
//           width: width(context),
//           height: height(context) * 0.5,
//           child: AnimatedScale(
//             scale: isOut ? 0 : 1,
//             duration: const Duration(milliseconds: 250),
//             child: Image.asset(image),
//           ),
//         ),

//         // مسافة فارغة بعد الصورة
//         const SizedBox(height: 20),

//         // عنوان متحرك باستخدام AnimatedOpacity
//         AnimatedOpacity(
//           opacity: isOut ? 0 : 1,
//           duration: const Duration(milliseconds: 500),
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 23,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),

//         // مسافة فارغة بين العنوان والوصف
//         const SizedBox(height: 20),

//         // وصف متحرك باستخدام AnimatedOpacity
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0),
//           child: AnimatedPositioned(
//             left: isOut ? 0 : 1,
//             // opacity:
//             duration: const Duration(milliseconds: 500),
//             child: Text(
//               description,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/constants/constants_variables.dart';

Widget buildOnboardScreen({
  required String image,
  required Color color,
  required String title,
  required String description,
  required BuildContext context,
  required bool isOut,
}) {
  return Stack(
    children: [
      // خلفية الشاشة
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: color,
        width: width(context),
        height: height(context),
      ),

      // صورة متحركة باستخدام AnimatedScale
      Positioned(
        top: height(context) * 0.1,
        left: 0,
        right: 0,
        child: AnimatedScale(
          scale: isOut ? 0 : 1,
          duration: const Duration(milliseconds: 250),
          child: SizedBox(
            width: width(context),
            height: height(context) * 0.4,
            child: Image.asset(image),
          ),
        ),
      ),

      // عنوان متحرك باستخدام AnimatedPositioned
      AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        top: height(context) * 0.55,
        left: isOut ? width(context) : width(context) * 0.2,
        right: isOut ? width(context) : width(context) * 0.2,
        child: AnimatedOpacity(
          opacity: isOut ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),

      // وصف متحرك باستخدام AnimatedPositioned
      AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        bottom: isOut ? -50 : 80, // تحريك الوصف للأسفل عند تغيير isOut
        left: isOut ? width(context) : 40, // تحريك الوصف من الجانب
        right: isOut ? width(context) : 40,
        child: AnimatedOpacity(
          opacity: isOut ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
