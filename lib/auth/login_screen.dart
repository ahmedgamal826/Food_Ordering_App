import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/widgets/auth_functions.dart';
import 'package:food_ordering_app/widgets/awesome_dialog.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_text_button.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
import 'package:food_ordering_app/widgets/custom_text_textButton..dart';
import 'package:food_ordering_app/widgets/login_with_google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void handleSignIn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        signIn(
            context: context,
            emailController: emailController,
            passwordController: passwordController);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   toolbarHeight: 0,
        // ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 0, bottom: 30),
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/login_logooo.png'),
                          ),
                        ),
                        //width: 100,
                        height: 160,
                      ),
                      const Positioned(
                        top: 130,
                        right: 130,
                        child: Text(
                          'Food Delivery App',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 40, color: Colors.orange),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  CustomTextFiled(
                    hintText: 'Enter your Email',
                    controller: emailController,
                    validatorMessage: 'Email is required',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFiled(
                    hintText: 'Enter your Password',
                    validatorMessage: 'Password is required',
                    controller: passwordController,
                  ),
                  CustomTextButton(
                    text: 'Forget Password?',
                    onPressed: () async {
                      if (emailController.text == '') {
                        awesomeDialog(
                            context: context,
                            content: 'الرجاء من كتابة بريدك الالكتروني');
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          //animType: AnimType.rightSlide,
                          title: 'Error',
                          desc:
                              'لقد تم ارسال لينك لإعادة كلمة المرور إلي بريدك الالكتروني .. الرجاء التوجه الي بريدك الالكتروني والضغط علي اللينك',
                        ).show();
                      } catch (e) {
                        awesomeDialog(
                            context: context,
                            content:
                                'الرجاء التأكد من ان البريد الالكتروني الذي ادخلته صحيح ثم قم بإعادة المحاولة');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(buttonText: 'Login', onPressed: handleSignIn),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  LoginWithGoogleButton(
                    onpressed: () {
                      signInWithGoogle(context: context);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextAndTextbutton(
                    text1: "Don't have an account? ",
                    text2: 'Sign Up',
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed("registerScreen");
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
