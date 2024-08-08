import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void awesomeDialog({required BuildContext context, required String content}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    //animType: AnimType.rightSlide,
    title: 'Error',
    desc: content,
  ).show();
}
