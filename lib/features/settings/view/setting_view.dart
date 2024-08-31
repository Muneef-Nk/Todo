import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(fontSize: headingSize, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Muneef",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "muneef@gamil.com",
                      style: TextStyle(fontSize: textSizeSmall),
                    ),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.dark,
                  child: Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Hi My name is Muneef, I'm a community manager form Muhammed Muneef",
                style: TextStyle(
                  fontSize: headingSize2,
                ),
              ),
            ),
            SettingContainer(
              icon: Icons.notifications,
              onPressed: () {
                //
              },
              text: "Notifications",
            ),
            SettingContainer(
              icon: Icons.settings,
              onPressed: () {
                //
              },
              text: "General",
            ),
            SettingContainer(
              icon: Icons.person,
              onPressed: () {
                //
              },
              text: "Account",
            ),
            SettingContainer(
              icon: Icons.info,
              onPressed: () {
                //
              },
              text: "About",
            )
          ],
        ),
      ),
    );
  }
}

class SettingContainer extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final String text;
  const SettingContainer({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //
      },
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.dark,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
