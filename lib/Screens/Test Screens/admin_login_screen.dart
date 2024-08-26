import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_management.dart';
import 'package:food_ordering_app/widgets/auth_functions.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
import 'package:food_ordering_app/widgets/login_with_google_button.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/admin_login.png'),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFiled(
                                controller: emailController,
                                hintText: 'Enter your Email',
                                validatorMessage: 'Email is required',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFiled(
                                controller: passwordController,
                                hintText: 'Enter your Password',
                                validatorMessage: 'Password is required',
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                    elevation: 5.0,
                                    minimumSize: const Size.fromHeight(40),
                                    fixedSize: const Size(
                                      double.infinity,
                                      50,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      visible = true;
                                    });
                                    signIn(emailController.text,
                                        passwordController.text);
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: visible,
                                child: Container(
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminManagement(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        visible = true; // إظهار الـ CircularProgressIndicator
      });

      setState(() {
        isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // عند تسجيل الدخول بنجاح، تابع إلى الشاشة المناسبة
        route();
      } on FirebaseAuthException catch (e) {
        // إخفاء الـ CircularProgressIndicator
        setState(() {
          visible = false;
        });

        // عرض رسائل الخطأ باستخدام Snackbar
        if (e.code == 'user-not-found') {
          customShowSnackBar(context: context, content: 'Email not found');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Email not found')),
          // );
        } else if (e.code == 'wrong-password') {
          customShowSnackBar(context: context, content: 'Wrong password');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Wrong password')),
          // );
        } else {
          customShowSnackBar(
              context: context,
              content: 'Error: This email does not belong to an admin.');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Error: This email does not belong to an admin.'),
          //   ),
          // );
        }
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }
}
