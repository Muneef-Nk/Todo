import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskController with ChangeNotifier {
  var documentId;

  void addTask(
      {required String task,
      required String date,
      required bool isCompleted,
      required BuildContext context}) async {
    final CollectionReference taskCollection = FirebaseFirestore.instance
        .collection('category')
        .doc(documentId)
        .collection('task');

    await taskCollection.add({
      'task': task,
      'isCompleted': isCompleted,
      'date': date,
    });

    notifyListeners();
  }

  Future<void> taskCompletion(String taskId, bool isCompleted) async {
    try {
      await FirebaseFirestore.instance
          .collection('category')
          .doc(documentId)
          .collection('task')
          .doc(taskId)
          .update({'isCompleted': !isCompleted});
    } catch (e) {
      print('Error updating task completion: $e');
    }
    notifyListeners();
  }
}
