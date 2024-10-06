import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/Screens/food_manges.dart/admin_management.dart';
import 'package:food_ordering_app/components/clip_path_widget.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/widgets/custom_button.dart';
import 'package:food_ordering_app/widgets/custom_text_filed.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: LoadingDots())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ClipPathWidget(
                    txt: 'Admin Sign In',
                  ),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFiled(
                                controller: nameController,
                                hintText: 'Enter your Name',
                                validatorMessage: 'Name is required',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFiled(
                                controller: emailController,
                                hintText: 'Enter your Email',
                                validatorMessage: 'Email is required',
                              ),
                              const SizedBox(
                                height: 20,
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
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFiled(
                                controller: passwordController,
                                hintText: 'Enter your Password',
                                validatorMessage: 'Password is required',
                              ),
                              const SizedBox(
                                height: 40,
                              ),

                              CustomButton(
                                buttonText: 'Sign In',
                                onPressed: () {
                                  setState(() {
                                    visible = true;
                                  });
                                  signIn(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text);
                                },
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              // Visibility(
                              //   maintainSize: true,
                              //   maintainAnimation: true,
                              //   maintainState: true,
                              //   visible: visible,
                              //   child: Container(
                              //     child: const CircularProgressIndicator(
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
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

  void signIn(String name, String email, String password) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        visible = true;
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

        // احصل على الـ UID الخاص بالمستخدم
        User? user = userCredential.user;

        // تحقق من وجود المستخدم في Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (!userDoc.exists) {
          // إذا لم يكن المستخدم موجودًا، أضف وثيقة جديدة تتضمن الاسم والبريد الإلكتروني
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': name,
            'email': email,
            'role': 'admin', // أو أي دور آخر
          });
        } else {
          // تحديث الاسم إذا كان المستخدم موجود بالفعل
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'name': name,
          });
        }

        // تابع إلى الشاشة المناسبة
        route();
      } on FirebaseAuthException catch (e) {
        setState(() {
          visible = false;
        });

        if (e.code == 'user-not-found') {
          customShowSnackBar(context: context, content: 'Email not found');
        } else if (e.code == 'wrong-password') {
          customShowSnackBar(context: context, content: 'Wrong password');
        } else {
          customShowSnackBar(
              context: context,
              content: 'Error: This email does not belong to an admin.');
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
