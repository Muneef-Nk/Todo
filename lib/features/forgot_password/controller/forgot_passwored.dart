import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/utils/helper_function.dart';

class ForgotPasswordController with ChangeNotifier {
  Future<void> sendPasswordResetEmail(
      String emailAddress, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress)
          .then(
        (value) {
          showSnackBar(context, 'Password reset email sent. Check your inbox.',
              backgroundColor: AppColors.primaryColor);

          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      print('An unexpected error occurred.');
    }
    notifyListeners();
  }
}
