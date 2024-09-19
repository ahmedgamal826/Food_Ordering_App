import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
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
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signUp() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fields are required"),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
        ),
      );
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
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
                  : ListView(
                      children: [
                        Container(
                          // width: 150,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Image.asset(
                            'assets/images/login_image_222.png',
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Let's create an account for you!",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Username',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        CustomTextFiled(
                          hintText: 'Enter your Name',
                          controller: nameController,
                          validatorMessage: 'Username is required',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        CustomTextFiled(
                          controller: emailController,
                          hintText: 'Enter your Email',
                          validatorMessage: 'Email is required',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        CustomTextFiled(
                          controller: passwordController,
                          hintText: 'Enter your Password',
                          validatorMessage: 'Password is required',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        CustomTextFiled(
                          controller: confirmPasswordController,
                          hintText: 'Enter Confirm Password',
                          validatorMessage: 'Confirm Password is required',
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          buttonText: 'Sign Up',
                          onPressed: signUp,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "already have an account ?",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                "Login now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
