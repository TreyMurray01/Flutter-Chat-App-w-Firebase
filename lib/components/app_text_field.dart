import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;

  const AppTextField(
      {super.key,
      required this.hint,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return (TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade200,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
            ))));
  }
}
