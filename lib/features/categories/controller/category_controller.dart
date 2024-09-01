import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_list/core/utils/helper_function.dart';

class CategoryController with ChangeNotifier {
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('category');

  var imageUrl;

  pickImage() async {
    final ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("categoryIcons");
      final uploadRef =
          imageRef.child(DateTime.now().microsecondsSinceEpoch.toString());

      await uploadRef.putFile(File(image.path));

      imageUrl = await uploadRef.getDownloadURL();
      notifyListeners();
    }
  }

  void addCategory(String categoryName) async {
    print(categoryName);

    String userId = await getId();

    await categoryCollection.add({
      'userId': userId,
      'category': categoryName,
      'image': imageUrl ?? '',
    });

    notifyListeners();
  }

  getTaskCount(String categoryId) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('category')
        .doc(categoryId)
        .collection('task')
        .get();

    print(querySnapshot.docs.length);

    return querySnapshot.docs.length;
  }
}
