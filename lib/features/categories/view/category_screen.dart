import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/categories/controller/category_controller.dart';
import 'package:todo_list/features/settings/view/setting_view.dart';
import 'package:todo_list/features/task/view/task_view.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  var userId;

  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    getUserId();

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  getUserId() async {
    userId = await getId();
    setState(() {});
  }

  Future<int> getTaskCount(String categoryId) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('category')
        .doc(categoryId)
        .collection('task')
        .get();
    return querySnapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingView()));
          },
          child: Container(
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/png/profile.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          "Categories",
          style: TextStyle(
            color: AppColors.dark,
            fontWeight: FontWeight.bold,
            fontSize: headingSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              search(context);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(3, 5)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/png/profile.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'The memories is a shield and life helper.',
                          style: GoogleFonts.courgette(
                            fontSize: textSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tamim Al-Aarghouti',
                          style: TextStyle(
                            fontSize: textSizeSmall,
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            StreamBuilder(
                stream: category.where('userId', isEqualTo: userId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {});
                      },
                      child: Ink(
                          width: size.width * 0.5,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(
                                10,
                              )),
                          child: Center(
                            child: Text(
                              'Try again',
                              style: TextStyle(
                                  fontSize: textSize, color: AppColors.white),
                            ),
                          )),
                    ));
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    var categories = snapshot.data!.docs;

                    if (searchQuery.isNotEmpty) {
                      categories = categories.where((category) {
                        String categoryName =
                            category['category']?.toLowerCase() ?? '';
                        return categoryName.contains(searchQuery.toLowerCase());
                      }).toList();
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.3,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: categories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return InkWell(
                            onTap: () {
                              addCategory(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(3, 5)),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.dark,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          );
                        } else {
                          var categoryData = categories[index - 1];
                          String categoryId = categoryData.id;

                          return FutureBuilder<int>(
                            future: getTaskCount(categoryId),
                            builder: (context, snapshot) {
                              int taskCount = snapshot.data ?? 0;

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => TodoView(
                                            categoryName:
                                                categoryData['category'],
                                            documentId: categoryData.id,
                                          )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: Offset(3, 5)),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          categoryData['image'] != null
                                              ? Image.network(
                                                  categoryData['image'],
                                                  width: 45,
                                                  height: 45,
                                                )
                                              : Icon(Icons.category),
                                          SizedBox(height: 5),
                                          Text(
                                            categoryData['category'] ??
                                                'Category',
                                            style: TextStyle(
                                              fontSize: textSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${taskCount} tasks",
                                            style: TextStyle(
                                              fontSize: textSize,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 6, bottom: 5),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: AppColors.grey,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          );
                        }
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            addCategory(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.dark, shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No categories added yet',
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> addCategory(BuildContext context) {
    TextEditingController _categoryController = TextEditingController();
    final provider = Provider.of<CategoryController>(context, listen: false);
    provider.imageUrl = null;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(onTap: () {
                              Provider.of<CategoryController>(context,
                                      listen: false)
                                  .pickImage();
                            }, child: Consumer<CategoryController>(
                                builder: (context, provider, _) {
                              return provider.imageUrl != null
                                  ? Image.network(
                                      provider.imageUrl,
                                      width: 50,
                                      height: 50,
                                    )
                                  : Icon(Icons.image_outlined);
                            })),
                          ],
                        ),
                        TextField(
                          onEditingComplete: () {
                            Provider.of<CategoryController>(context,
                                    listen: false)
                                .addCategory(_categoryController.text);

                            Navigator.of(context).pop();
                          },
                          onSubmitted: (value) {},
                          controller: _categoryController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: headingSize,
                              color: AppColors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Title",
                          ),
                        ),
                        Text(
                          "0 Task",
                          style: TextStyle(
                              fontSize: textSize, color: AppColors.grey),
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
