import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/features/task/controller/task_controller.dart';

class TodoView extends StatefulWidget {
  final String documentId;
  final String categoryName;
  TodoView({super.key, required this.documentId, required this.categoryName});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late CollectionReference taskCollection;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    taskCollection = FirebaseFirestore.instance
        .collection('category')
        .doc(widget.documentId)
        .collection('task');

    Provider.of<TaskController>(context, listen: false).documentId =
        widget.documentId;

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            addTask(context);
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.dark,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "${widget.categoryName}",
            style: TextStyle(
              fontSize: headingSize,
              color: AppColors.dark,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  search(context);
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: taskCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tasks available'));
                  }

                  var tasks = snapshot.data!.docs;

                  tasks.sort((a, b) {
                    return DateTime.parse(a['date'])
                        .compareTo(DateTime.parse(b['date']));
                  });

                  if (searchQuery.isNotEmpty) {
                    tasks = tasks.where((task) {
                      String taskName = task['task']?.toLowerCase() ?? '';
                      return taskName.contains(searchQuery.toLowerCase());
                    }).toList();
                  }

                  List<Widget> taskWidgets = [];
                  DateTime? lastDate;

                  for (var task in tasks) {
                    DateTime taskDate = DateTime.parse(task['date']);
                    if (lastDate == null || !isSameDate(taskDate, lastDate)) {
                      lastDate = taskDate;
                      taskWidgets.add(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          formatDate(taskDate),
                          style: TextStyle(
                              fontSize: textSize,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w700),
                        ),
                      ));
                    }

                    taskWidgets.add(Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          task['isCompleted']
                              ? InkWell(
                                  borderRadius: BorderRadius.circular(40),
                                  onTap: () {
                                    Provider.of<TaskController>(context,
                                            listen: false)
                                        .taskCompletion(
                                            task.id, task['isCompleted']);
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    // padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.green,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  borderRadius: BorderRadius.circular(40),
                                  onTap: () {
                                    Provider.of<TaskController>(context,
                                            listen: false)
                                        .taskCompletion(
                                            task.id, task['isCompleted']);
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.Circle,
                                    color: AppColors.green,
                                    strokeWidth: 1,
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              task['task'] ?? '',
                              style: TextStyle(
                                  fontSize: headingSize1,
                                  color: AppColors.dark,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ));
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: taskWidgets,
                  );
                },
              ),
            ],
          ),
        ));
  }

  Future<dynamic> addTask(BuildContext context) {
    TextEditingController _taskController = TextEditingController();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(30),
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onSubmitted: (value) {
                            Provider.of<TaskController>(context, listen: false)
                                .addTask(
                                    task: _taskController.text,
                                    date: DateTime.now().toString(),
                                    isCompleted: false,
                                    context: context);

                            Navigator.of(context).pop();
                          },
                          controller: _taskController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: headingSize,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Type your task..",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.dark),
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));

    if (isSameDate(date, now)) {
      return 'Today';
    } else if (isSameDate(date, yesterday)) {
      return 'Yesterday';
    } else {
      final formatter = DateFormat('EEE MMM d, yyyy');
      return formatter.format(date);
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<dynamic> search(BuildContext context) {
    _searchController.clear();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(30),
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onSubmitted: (value) {
                            Navigator.of(context).pop();
                          },
                          onTapOutside: (event) {
                            Navigator.of(context).pop();
                          },
                          controller: _searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: headingSize,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Search your task..",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.dark),
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
