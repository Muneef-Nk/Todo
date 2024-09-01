import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/constants/color_constants.dart';
import 'package:todo_list/core/constants/font_size.dart';
import 'package:todo_list/core/global/widgets/custom_textfield.dart';
import 'package:todo_list/core/global/widgets/loading.dart';
import 'package:todo_list/core/utils/helper_function.dart';
import 'package:todo_list/features/login/view/login_screen.dart';
import 'package:todo_list/features/register/controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop,
        ),
        title: Text(
          "Create an Account",
          style: TextStyle(fontSize: headingSize, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<RegisterController>(builder: (context, provider, _) {
        return Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomeTextfield(
                      hint: "Full Name",
                      controller: _nameController,
                      errorMessage: 'Please eneter name',
                    ),
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
                    CustomeTextfield(
                      hint: "Confirm Password",
                      controller: _confirmController,
                      matchingController: _passwordController,
                      errorMessage: 'Please eneter fonfirm password',
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // Proceed only if validation passes
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            // Ensure these are non-null
                            assert(email.isNotEmpty && password.isNotEmpty);

                            Provider.of<RegisterController>(context,
                                    listen: false)
                                .createUserWithEmailAndPassword(
                              emailAddress: email,
                              context: context,
                              password: password,
                              name: _nameController.text,
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
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: textSizeSmall,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
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
        );
      }),
    );
  }
}
