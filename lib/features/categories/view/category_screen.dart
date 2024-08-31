import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/features/settings/view/setting_view.dart';
import 'package:todo_list/features/to_do_view/view/todo_view.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
              //
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
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 1.4,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: 11,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(30),
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  //
                                                },
                                                child:
                                                    Icon(Icons.image_outlined),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  //
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: AppColors.grey,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextField(
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
                                                fontSize: textSize,
                                                color: AppColors.grey),
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
                                          shape: BoxShape.circle,
                                          color: AppColors.dark),
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
                              color: AppColors.dark, shape: BoxShape.circle),
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        )),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TodoView()));
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
                          padding: const EdgeInsets.only(left: 12, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.abc),
                              Text(
                                "Home",
                                style: TextStyle(
                                  fontSize: textSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "10 task",
                                style: TextStyle(
                                  fontSize: textSize,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
