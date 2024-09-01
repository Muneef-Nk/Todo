import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/core/global/widgets/custom_textfield.dart';
import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/forgot_password/controller/forgot_passwored.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(fontSize: headingSize, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomeTextfield(
                    hint: "Email",
                    controller: _emailController,
                    errorMessage: 'Please eneter email',
                    isEmail: true,
                  ),
                  Text(
                    'Enter the email address you used to create your account and we will email you a link to reset your password',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: textSizeSmall,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<ForgotPasswordController>(context,
                                  listen: false)
                              .sendPasswordResetEmail(
                            _emailController.text,
                            context,
                          );
                        }
                      },
                      child: Ink(
                        width: size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: textSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: textSizeSmall,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: textSizeSmall,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration
                                  .underline, // Add underline here
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
