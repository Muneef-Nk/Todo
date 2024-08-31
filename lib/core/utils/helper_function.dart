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
