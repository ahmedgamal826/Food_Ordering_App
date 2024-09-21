import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/widgets/awesome_dialog.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_text_button.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
import 'package:food_ordering_app/widgets/login_with_google_button.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      final authService = Provider.of<AuthService>(context, listen: false);

      setState(() {
        isLoading = true; // Start loading
      });

      try {
        await authService.signInWithEmailandPassword(
            emailController.text, passwordController.text);
        Navigator.pushReplacementNamed(context, 'userScreen');
      } catch (e) {
        customShowSnackBar(context: context, content: '${e.toString()}');
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }

  void signInWithGoogle() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      await authService.signInWithGoogle();
      Navigator.pushReplacementNamed(context, 'userScreen');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
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
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Image.asset(
                                  'assets/images/login_image_222.png',
                                ),
                              ),
                              const Center(
                                child: Text(
                                  "Login Now",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
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
                                  validatorMessage: 'Password is required'),
                              CustomTextButton(
                                text: 'Forget Password?',
                                onPressed: () async {
                                  if (emailController.text == '') {
                                    awesomeDialog(
                                        context: context,
                                        content:
                                            'الرجاء من كتابة بريدك الالكتروني');
                                    return;
                                  }
                                  try {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
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
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                buttonText: 'Login',
                                onPressed: signIn,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LoginWithGoogleButton(
                                onpressed: signInWithGoogle,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "don't have an account ?",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    InkWell(
                                      onTap: widget.onTap,
                                      child: const Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        "Register now",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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
