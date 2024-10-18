import 'package:flutter/material.dart';
import 'package:food_ordering_app/auth/auth_services_user.dart';
import 'package:food_ordering_app/auth/register_page.dart';
import 'package:food_ordering_app/auth/reset_password_screen.dart';
import 'package:food_ordering_app/components/clip_path_widget.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_text_button.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
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
      final authService = Provider.of<UserAuthService>(context, listen: false);

      setState(() {
        isLoading = true; // Start loading
      });

      try {
        LoadingDots();
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
    final authService = Provider.of<UserAuthService>(context, listen: false);

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      await authService.signInWithGoogle();
      Navigator.pushReplacementNamed(context, 'userScreen');
    } catch (e) {
      customShowSnackBar(
          context: context, content: 'Failed to login with Google');
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
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: LoadingDots())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ClipPathWidget(
                      txt: 'Sign In',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const SizedBox(
                            height: 30,
                          ),
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
                              validatorMessage: 'Password is required'),
                          CustomTextButton(
                            text: 'Forget Password?',
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetPasswordPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: CustomButton(
                                  buttonText: 'Sign In',
                                  onPressed: signIn,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "don't have an account ?",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage(onTap: () {}),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Sign Up",
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
                              const SizedBox(
                                height: 20,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const ClipRect(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 1,
                                      height: 40,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: const Text(
                                      'Or login with',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: signInWithGoogle,
                                child: Image.asset(
                                  'assets/images/google232.png',
                                  width: 60,
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
                  ],
                ),
              ),
      ),
    );
  }
}
