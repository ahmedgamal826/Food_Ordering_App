import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/clip_path_widget.dart';
import 'package:food_ordering_app/widgets/awesome_dialog.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);

        SuccessAwesomeDialog(
            context: context,
            content:
                'A link to reset your password has been sent to your email.');
      } catch (e) {
        awesomeDialog(
            context: context,
            content: 'An error occurred, please check the email address.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPathWidget(txt: 'Forgot password'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Please enter your email to reset the password',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextFiled(
                      controller: emailController,
                      hintText: 'Enter your Email',
                      validatorMessage: 'Email is required',
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: CustomButton(
                        buttonText: 'Reset Password',
                        onPressed: resetPassword,
                      ),
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
