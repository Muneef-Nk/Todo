import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/categories/view/category_screen.dart';

class RegisterController with ChangeNotifier {
  bool isLoading = false;
  createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    if (credential.user != null) {
      saveUserId(credential.user?.uid ?? "");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CategoryScreen()),
      );

      await usersCollection.add({
        'userId': credential.user?.uid,
        'name': name,
        'email': emailAddress,
      });
    }
    isLoading = false;
    notifyListeners();
  }
}
