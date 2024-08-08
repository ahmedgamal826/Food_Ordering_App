import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  CustomTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validatorMessage,
  });

  final String hintText;
  final TextEditingController controller;
  final String validatorMessage;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isPasswordField = (widget.hintText == 'Enter your Password' ||
        widget.hintText == 'Enter Confirm Password');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          validator: (value) {
            if (value!.isEmpty) {
              return widget.validatorMessage;
            }
            return null;
          },
          obscureText: isPasswordField ? obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.orange,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: isPasswordField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                  )
                : null,
            prefixIcon: widget.hintText == 'Enter your Email'
                ? const Icon(
                    Icons.mail,
                    color: Colors.white,
                  )
                : widget.hintText == 'Enter your Name'
                    ? const Icon(
                        Icons.person,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
          ),
        ),
      ),
    );
  }
}
