import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final String? initialValue;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Color? labelColor;

  const CustomTextBox({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
    this.obscureText = false,
    this.validator,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(
              color: labelColor ?? Theme.of(context).primaryColor,
            )),
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
