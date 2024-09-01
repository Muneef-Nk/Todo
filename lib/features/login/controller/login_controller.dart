import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/categories/view/category_screen.dart';

class LoginController with ChangeNotifier {
  bool isLoading = false;

  Future<void> signInWithEmailAndPassword(
      String emailAddress, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (credential.user != null) {
        saveUserId(credential.user?.uid ?? "");
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setBool('isAccountCreated', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen()),
        );
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error: ${_getErrorMessage(e)}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Wrong password provided for that user.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        default:
          return 'An unexpected error occurred. Please try again.';
      }
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
