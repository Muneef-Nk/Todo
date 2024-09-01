import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/helper_function.dart';

class SettingController with ChangeNotifier {
  String? name;
  String? email;

  Future<void> getUserDetails() async {
    final userId = await getId();
    if (userId == null) {
      print('User ID is null');
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        name = doc.data()?['name'] ?? 'No name';
        email = doc.data()?['email'] ?? 'No email';
        print(name);
        print(email);
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }

    notifyListeners();
  }
}
