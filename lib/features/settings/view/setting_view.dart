import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/features/login/view/login_screen.dart';
import 'package:todo_list/features/settings/controller/setting_controller.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
    Provider.of<SettingController>(context, listen: false).getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: headingSize, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<SettingController>(builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/png/profile.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${provider.name ?? 'unknown'}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${provider.email ?? 'exmaple@gmail.com'}",
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
                ),
                SettingContainer(
                  icon: Icons.logout,
                  onPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                    FirebaseAuth.instance.signOut();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.setBool('isAccountCreated', false);
                  },
                  text: "Logout",
                )
              ],
            ),
          ),
        );
      }),
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
        onPressed();
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
