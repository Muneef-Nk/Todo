import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/color_constants.dart';

class CustomeTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? errorMessage;
  final TextEditingController? matchingController;
  final bool isEmail;
  final bool isPassword;

  const CustomeTextfield({
    super.key,
    required this.hint,
    required this.controller,
    this.errorMessage = null,
    this.matchingController,
    this.isEmail = false,
    this.isPassword = false,
  });

  @override
  _CustomeTextfieldState createState() => _CustomeTextfieldState();
}

class _CustomeTextfieldState extends State<CustomeTextfield> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && !_isPasswordVisible,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorMessage;
          }
          if (widget.isEmail &&
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          if (widget.isPassword && value.length < 8) {
            return 'Password must be at least 8 characters long';
          }
          if (widget.matchingController != null &&
              value != widget.matchingController!.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.greyLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.greyLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.greyLight),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(color: AppColors.grey, fontSize: 14),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
