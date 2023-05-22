import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.red, toastLength: Toast.LENGTH_LONG);
  }

  static flushbarError(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          backgroundColor: Colors.black,
        )..show(context));
  }
}
