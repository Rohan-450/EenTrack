// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color textcolor;
  final Color backgroundColor;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textcolor = Colors.black,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // ButtonStyle(
      //     fixedSize: MaterialStateProperty.all(
      //       const Size(200, 50),
      //     ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(textcolor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        fixedSize: MaterialStateProperty.all(const Size(200, 50)),
      ),

      child: Text(
        buttonText,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color textcolor;
  final Color backgroundColor;

  const CustomTextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textcolor = Colors.blue,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(textcolor),
      ),
      child: Text(buttonText),
    );
  }
}
