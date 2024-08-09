import 'package:flutter/material.dart';

class TextfiedAdminLogin extends StatefulWidget {
  TextfiedAdminLogin(
      {super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  String hintText;

  @override
  State<TextfiedAdminLogin> createState() => _TextfiedAdminLoginState();
}

class _TextfiedAdminLoginState extends State<TextfiedAdminLogin> {
  @override
  Widget build(BuildContext context) {
    bool _isObscure3 = true;

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.hintText == 'Password' ? true : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        suffixIcon: widget.hintText == 'Password'
            ? Icon(Icons.delete_rounded)
            : Text('data'),
        // suffixIcon: widget.hintText == 'Password'
        //     ? IconButton(
        //         icon:
        //             Icon(_isObscure3 ? Icons.visibility : Icons.visibility_off),
        //         onPressed: () {
        //           setState(() {
        //             _isObscure3 = !_isObscure3;
        //           });
        //         })
        //     : Text(''),
        enabled: true,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.length == 0) {
          return "Email cannot be empty";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        widget.controller.text = value!;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
