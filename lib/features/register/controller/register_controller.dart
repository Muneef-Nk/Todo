import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/features/categories/view/category_screen.dart';

class RegisterController with ChangeNotifier {
  createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String name,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );

    notifyListeners();
  }
}
