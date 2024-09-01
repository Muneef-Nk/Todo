import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Size size;

responsive(BuildContext context) {
  size = MediaQuery.of(context).size;
}

bool isDarkTheme = false;

changeThemeColor(bool isDark) async {
  isDarkTheme = isDark;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isDark', isDarkTheme);
}

saveUserId(String id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('id', id);
}

getId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('id');
}

void showSnackBar(BuildContext context, String message,
    {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // Show SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor ?? Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: EdgeInsets.all(10),
      content: Text(
        message,
        style: TextStyle(fontSize: 13),
      ),
    ),
  );
}
