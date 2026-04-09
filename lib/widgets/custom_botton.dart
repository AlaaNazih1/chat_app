import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  const CustomBotton(this.text,this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(text!, style: TextStyle(color: Colors.black, fontSize: 18)),
        ),
      ),
    );
  }
}
