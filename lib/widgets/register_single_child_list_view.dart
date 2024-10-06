// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/auth/auth_services_user.dart';
// import 'package:food_ordering_app/auth/login_page.dart';
// import 'package:food_ordering_app/components/loading_dots.dart';
// import 'package:food_ordering_app/widgets/clip_path_widget.dart';
// import 'package:food_ordering_app/widgets/custom_button.dart';
// import 'package:food_ordering_app/widgets/custom_text_filed.dart';
// import 'package:food_ordering_app/widgets/show_snack_bar.dart';
// import 'package:provider/provider.dart';

// class RegisterSingleChildListView extends StatefulWidget {
//   const RegisterSingleChildListView({super.key});

//   @override
//   State<RegisterSingleChildListView> createState() =>
//       _RegisterSingleChildListViewState();
// }

// class _RegisterSingleChildListViewState
//     extends State<RegisterSingleChildListView> {

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ClipPathWidget(
//             txt: 'Sign Up',
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: isLoading
//                 ? Center(child: LoadingDots())
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Name',
//                         style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFiled(
//                         hintText: 'Enter your Name',
//                         controller: nameController,
//                         validatorMessage: 'Username is required',
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'Email',
//                         style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFiled(
//                         controller: emailController,
//                         hintText: 'Enter your Email',
//                         validatorMessage: 'Email is required',
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'Phone Number',
//                         style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFiled(
//                         hintText: 'Enter your Phone Number',
//                         controller: phoneNumberController,
//                         validatorMessage: 'Phone Number is required',
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'Password',
//                         style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFiled(
//                         controller: passwordController,
//                         hintText: 'Enter your Password',
//                         validatorMessage: 'Password is required',
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'Confirm Password',
//                         style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFiled(
//                         controller: confirmPasswordController,
//                         hintText: 'Enter Confirm Password',
//                         validatorMessage: 'Confirm Password is required',
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       CustomButton(
//                         buttonText: 'Sign Up',
//                         onPressed: signUp,
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Center(
//                         child: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "already have an account ?",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               const SizedBox(
//                                 width: 4,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => LoginPage(
//                                         onTap: () {},
//                                       ),
//                                     ),
//                                     (route) => false,
//                                   );
//                                 },
//                                 child: const Text(
//                                   "Sign In",
//                                   style: TextStyle(
//                                     color: Colors.orange,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 23,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/login_page.dart';
import 'package:food_ordering_app/components/clip_path_widget.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';

class RegisterSingleChildListView extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function signUp;

  const RegisterSingleChildListView({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.signUp,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipPathWidget(
            txt: 'Sign Up',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  hintText: 'Enter your Name',
                  controller: nameController,
                  validatorMessage: 'Username is required',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  controller: emailController,
                  hintText: 'Enter your Email',
                  validatorMessage: 'Email is required',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  hintText: 'Enter your Phone Number',
                  controller: phoneNumberController,
                  validatorMessage: 'Phone Number is required',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  validatorMessage: 'Password is required',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextFiled(
                  controller: confirmPasswordController,
                  hintText: 'Enter Confirm Password',
                  validatorMessage: 'Confirm Password is required',
                ),
                const SizedBox(height: 40),
                CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: () => signUp(),
                ),
                const SizedBox(height: 15),
                Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "already have an account ?",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(onTap: () {}),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
