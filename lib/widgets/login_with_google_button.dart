import 'package:flutter/material.dart';

class LoginWithGoogleButton extends StatelessWidget {
  LoginWithGoogleButton({super.key, required this.onpressed});

  void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          onPressed: onpressed,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login With Google',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/images/google.png',
                  width: 25,
                )
              ],
            ),
          )),
    );
  }
}
