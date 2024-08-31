import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/register/controller/register_controller.dart';
import 'package:todo_list/features/register/view/register_screen.dart';
import 'package:todo_list/features/splash_screen/view/splash_screen.dart';
import 'package:todo_list/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    responsive(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mimo',
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            elevation: 0,
          ),
        ),
        home: RegisterScreen(),
      ),
    );
  }
}
