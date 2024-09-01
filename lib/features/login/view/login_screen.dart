import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/core/global/widgets/custom_textfield.dart';
import 'package:todo_list/core/global/widgets/loading.dart';
import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/forgot_password/view/forgot_password_view.dart';
import 'package:todo_list/features/login/controller/login_controller.dart';
import 'package:todo_list/features/register/view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginController>(builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.3,
                  width: size.width,
                  child: Center(
                      child: Text(
                    "MIMO",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                SizedBox(height: 20),
                CustomeTextfield(
                  hint: "Email",
                  controller: _emailController,
                  errorMessage: 'Please eneter email',
                  isEmail: true,
                ),
                CustomeTextfield(
                  hint: "Password",
                  controller: _passwordController,
                  errorMessage: 'Please eneter password',
                  isPassword: true,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordView()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          "forgot passord",
                          style: TextStyle(fontSize: textSizeSmall),
                        ),
                      ),
                    )),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<LoginController>(context, listen: false)
                            .signInWithEmailAndPassword(_emailController.text,
                                _passwordController.text, context);
                      }
                    },
                    child: Ink(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryColor),
                      child: Center(
                        child: provider.isLoading
                            ? Loading()
                            : Text(
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: textSizeSmall,
                            fontWeight: FontWeight.bold,
                            decoration:
                                TextDecoration.underline, // Add underline here
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
