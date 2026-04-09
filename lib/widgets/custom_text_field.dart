import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
 final bool isPassword;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
      this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
