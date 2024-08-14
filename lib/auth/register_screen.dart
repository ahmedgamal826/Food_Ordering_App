// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/home_page.dart';
// import 'package:food_ordering_app/widgets/auth_functions.dart';
// import 'package:food_ordering_app/widgets/custom_button.dart';
// import 'package:food_ordering_app/widgets/custom_text_filed.dart';
// import 'package:food_ordering_app/widgets/custom_text_textButton..dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegisterScreen extends StatefulWidget {
//   RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     TextEditingController confirmPasswordController = TextEditingController();

//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//     // void handleSignUp() {
//     //   if (_formKey.currentState!.validate()) {
//     //     signUp(
//     //       context: context,
//     //       nameController: nameController,
//     //       emailController: emailController,
//     //       passwordController: passwordController,
//     //       confirmPasswordController: confirmPasswordController,
//     //     ).then((_) {
//     //       Navigator.of(context).pushReplacement(
//     //         MaterialPageRoute(
//     //           builder: (context) => HomePage(
//     //             name: nameController.text,
//     //             email: emailController.text,
//     //           ),
//     //         ),
//     //       );
//     //     }).catchError((error) {
//     //       print('Sign Up Error: $error');
//     //     });
//     //   }
//     // }

//     // void handleSignUp() {
//     //   if (_formKey.currentState!.validate()) {
//     //     signUp(
//     //       context: context,
//     //       nameController: nameController,
//     //       emailController: emailController,
//     //       passwordController: passwordController,
//     //       confirmPasswordController: confirmPasswordController,
//     //     ).then((_) async {
//     //       SharedPreferences prefs = await SharedPreferences.getInstance();
//     //       await prefs.setString('name', nameController.text);
//     //       await prefs.setString('emailLogin', emailController.text);

//     //       Navigator.of(context).pushReplacement(
//     //         MaterialPageRoute(
//     //           builder: (context) => HomePage(),
//     //         ),
//     //       );
//     //     }).catchError((error) {
//     //       // Handle errors here, if any
//     //       print('Sign Up Error: $error');
//     //     });
//     //   }
//     // }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.arrow_back))
//               ],
//             ),
//             Expanded(
//               child: ListView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.only(top: 0, bottom: 30),
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/login_logooo.png'),
//                           ),
//                         ),
//                         //width: 100,
//                         height: 150,
//                       ),
//                       const Positioned(
//                         top: 125,
//                         right: 130,
//                         child: Text(
//                           'Food Delivery App',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontStyle: FontStyle.italic),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 15),
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(fontSize: 40, color: Colors.orange),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       'Username',
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomTextFiled(
//                     hintText: 'Enter your Name',
//                     controller: nameController,
//                     validatorMessage: 'Username is required',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       'Email',
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomTextFiled(
//                     hintText: 'Enter your Email',
//                     controller: emailController,
//                     validatorMessage: 'Email is required',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       'Password',
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomTextFiled(
//                     hintText: 'Enter your Password',
//                     controller: passwordController,
//                     validatorMessage: 'Password is required',
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20),
//                     child: Text(
//                       'Confirm Password',
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomTextFiled(
//                     hintText: 'Enter Confirm Password',
//                     controller: confirmPasswordController,
//                     validatorMessage: 'Confirm Password is required',
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   CustomButton(buttonText: 'Sign Up', onPressed: () {}),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomTextAndTextbutton(
//                     text1: 'Already have an account? ',
//                     text2: 'Login',
//                     onTap: () {
//                       Navigator.of(context).pushReplacementNamed("loginScreen");
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
