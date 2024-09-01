import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/core/utils/helper_function.dart';

class SettingController with ChangeNotifier {
  String? name;
  String? email;
  String? otherField;

  Future<void> getUserDetails() async {
    final userId = await getId();
    if (userId == null) {
      print('User ID is null');
      return;
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        name = doc.data()['name'] ?? 'No name';
        email = doc.data()['email'] ?? 'No email';
        otherField = doc.data()['otherField'] ?? 'No value';
        print('Name: $name');
        print('Email: $email');
        print('Other Field: $otherField');
      } else {
        print('No matching document found');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }

    notifyListeners();
  }
}
