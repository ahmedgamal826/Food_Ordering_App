import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/Screens/Test%20Screens/admin_home_page.dart';
import 'package:food_ordering_app/widgets/auth_functions.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
import 'package:food_ordering_app/widgets/login_with_google_button.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                      // mainAxisAlignment: MainAxisAlignment.center,
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
                          validatorMessage: 'Email is required',
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor:
                        //         Colors.orange, // اختر اللون المناسب هنا
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(20.0)),
                        //     ),
                        //     elevation: 5.0,
                        //     minimumSize: const Size(
                        //         150, 40), // تحديد الحجم إذا لزم الأمر
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       visible = true;
                        //     });
                        //     signIn(
                        //         emailController.text, passwordController.text);
                        //   },
                        //   child: const Text(
                        //     "Login",
                        //     style: TextStyle(
                        //         fontSize: 23,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.orange, // اختر اللون المناسب هنا
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              elevation: 5.0,
                              minimumSize: const Size.fromHeight(
                                  40), // تحديد الارتفاع فقط
                              fixedSize: const Size(double.infinity,
                                  50), // جعل العرض ممتداً بالكامل
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
              builder: (context) => const AdminHomePage(),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email not found')),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong password')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: This email does not belong to an admin.'),
            ),
          );
        }
      }
    }
  }
}
