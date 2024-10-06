// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/auth/auth_services_user.dart';
// import 'package:food_ordering_app/auth/login_page.dart';
// import 'package:food_ordering_app/components/clip_path_widget.dart';
// import 'package:food_ordering_app/components/loading_dots.dart';
// import 'package:food_ordering_app/widgets/custom_button.dart';
// import 'package:food_ordering_app/widgets/custom_text_filed.dart';
// import 'package:food_ordering_app/widgets/register_single_child_list_view.dart';
// import 'package:food_ordering_app/widgets/show_snack_bar.dart';
// import 'package:provider/provider.dart';

// class RegisterPage extends StatefulWidget {
//   final void Function()? onTap;
//   const RegisterPage({super.key, required this.onTap});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   void signUp() async {
//     if (passwordController.text != confirmPasswordController.text) {
//       customShowSnackBar(context: context, content: 'Passwords do not match!');
//       return;
//     }

//     if (_formKey.currentState!.validate()) {
//       // get auth services
//       final authServices = Provider.of<AuthService>(context, listen: false);

//       setState(() {
//         isLoading = true;
//       });

//       try {
//         // Sign up the user
//         UserCredential userCredential =
//             await authServices.signUpWithEmailandPassword(
//           nameController.text,
//           emailController.text,
//           passwordController.text,
//         );

//         // Get the signed-in user
//         User? user = userCredential.user;

//         if (user != null) {
//           // Save user details to Firestore
//           await FirebaseFirestore.instance
//               .collection('user_app')
//               .doc(user.uid)
//               .set({
//             'name': nameController.text,
//             'email': emailController.text,
//             'isLoggedIn': true,
//             'rool': 'user', // Set role to 'user',
//             'loginTimestamp':
//                 FieldValue.serverTimestamp(), // Add login timestamp
//           });
//         }

//         Navigator.pushReplacementNamed(context, 'userScreen');
//       } catch (e) {
//         customShowSnackBar(context: context, content: '${e.toString()}');
//       } finally {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: isLoading
//             ? Center(child: LoadingDots())
//             : RegisterSingleChildListView(),
//         // : SingleChildScrollView(
//         //     child: Column(
//         //       children: [
//         //         ClipPathWidget(
//         //           txt: 'Sign Up',
//         //         ),
//         //         Padding(
//         //           padding: const EdgeInsets.symmetric(horizontal: 25),
//         //           child: isLoading
//         //               ? Center(child: LoadingDots())
//         //               : Column(
//         //                   crossAxisAlignment: CrossAxisAlignment.start,
//         //                   children: [
//         //                     const Text(
//         //                       'Name',
//         //                       style: TextStyle(
//         //                         fontSize: 23,
//         //                         fontWeight: FontWeight.bold,
//         //                         color: Colors.black,
//         //                         fontStyle: FontStyle.italic,
//         //                       ),
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 10,
//         //                     ),
//         //                     CustomTextFiled(
//         //                       hintText: 'Enter your Name',
//         //                       controller: nameController,
//         //                       validatorMessage: 'Username is required',
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 20,
//         //                     ),
//         //                     const Text(
//         //                       'Email',
//         //                       style: TextStyle(
//         //                         fontSize: 23,
//         //                         fontWeight: FontWeight.bold,
//         //                         color: Colors.black,
//         //                         fontStyle: FontStyle.italic,
//         //                       ),
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 10,
//         //                     ),
//         //                     CustomTextFiled(
//         //                       controller: emailController,
//         //                       hintText: 'Enter your Email',
//         //                       validatorMessage: 'Email is required',
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 20,
//         //                     ),
//         //                     const Text(
//         //                       'Phone Number',
//         //                       style: TextStyle(
//         //                         fontSize: 23,
//         //                         fontWeight: FontWeight.bold,
//         //                         color: Colors.black,
//         //                         fontStyle: FontStyle.italic,
//         //                       ),
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 10,
//         //                     ),
//         //                     CustomTextFiled(
//         //                       hintText: 'Enter your Phone Number',
//         //                       controller: phoneNumberController,
//         //                       validatorMessage: 'Phone Number is required',
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 20,
//         //                     ),
//         //                     const Text(
//         //                       'Password',
//         //                       style: TextStyle(
//         //                         fontSize: 23,
//         //                         fontWeight: FontWeight.bold,
//         //                         color: Colors.black,
//         //                         fontStyle: FontStyle.italic,
//         //                       ),
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 10,
//         //                     ),
//         //                     CustomTextFiled(
//         //                       controller: passwordController,
//         //                       hintText: 'Enter your Password',
//         //                       validatorMessage: 'Password is required',
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 20,
//         //                     ),
//         //                     const Text(
//         //                       'Confirm Password',
//         //                       style: TextStyle(
//         //                         fontSize: 23,
//         //                         fontWeight: FontWeight.bold,
//         //                         color: Colors.black,
//         //                         fontStyle: FontStyle.italic,
//         //                       ),
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 10,
//         //                     ),
//         //                     CustomTextFiled(
//         //                       controller: confirmPasswordController,
//         //                       hintText: 'Enter Confirm Password',
//         //                       validatorMessage:
//         //                           'Confirm Password is required',
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 40,
//         //                     ),
//         //                     CustomButton(
//         //                       buttonText: 'Sign Up',
//         //                       onPressed: signUp,
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 15,
//         //                     ),
//         //                     Center(
//         //                       child: FittedBox(
//         //                         fit: BoxFit.scaleDown,
//         //                         child: Row(
//         //                           mainAxisAlignment:
//         //                               MainAxisAlignment.center,
//         //                           children: [
//         //                             const Text(
//         //                               "already have an account ?",
//         //                               style: TextStyle(fontSize: 20),
//         //                             ),
//         //                             const SizedBox(
//         //                               width: 4,
//         //                             ),
//         //                             InkWell(
//         //                               onTap: () {
//         //                                 Navigator.pushAndRemoveUntil(
//         //                                   context,
//         //                                   MaterialPageRoute(
//         //                                     builder: (context) => LoginPage(
//         //                                       onTap: () {},
//         //                                     ),
//         //                                   ),
//         //                                   (route) => false,
//         //                                 );
//         //                               },
//         //                               child: const Text(
//         //                                 "Sign In",
//         //                                 style: TextStyle(
//         //                                   color: Colors.orange,
//         //                                   fontWeight: FontWeight.bold,
//         //                                   fontSize: 23,
//         //                                 ),
//         //                               ),
//         //                             ),
//         //                           ],
//         //                         ),
//         //                       ),
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 20,
//         //                     ),
//         //                   ],
//         //                 ),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/widgets/register_single_child_list_view.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      customShowSnackBar(context: context, content: 'Passwords do not match!');
      return;
    }

    if (_formKey.currentState!.validate()) {
      // get auth services
      final authServices = Provider.of<AuthService>(context, listen: false);

      setState(() {
        isLoading = true;
      });

      try {
        // Sign up the user
        UserCredential userCredential =
            await authServices.signUpWithEmailandPassword(
          nameController.text,
          emailController.text,
          passwordController.text,
        );

        // Get the signed-in user
        User? user = userCredential.user;

        if (user != null) {
          // Save user details to Firestore
          await FirebaseFirestore.instance
              .collection('user_app')
              .doc(user.uid)
              .set({
            'name': nameController.text,
            'email': emailController.text,
            'isLoggedIn': true,
            'rool': 'user', // Set role to 'user',
            'loginTimestamp':
                FieldValue.serverTimestamp(), // Add login timestamp
          });
        }

        Navigator.pushReplacementNamed(context, 'userScreen');
      } catch (e) {
        customShowSnackBar(context: context, content: '${e.toString()}');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: LoadingDots())
            : RegisterSingleChildListView(
                nameController: nameController,
                emailController: emailController,
                phoneNumberController: phoneNumberController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                signUp: signUp,
              ),
      ),
    );
  }
}
