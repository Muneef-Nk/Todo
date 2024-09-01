import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        backgroundColor: color ?? Colors.white,
        strokeWidth: 3,
      ),
    );
  }
}
