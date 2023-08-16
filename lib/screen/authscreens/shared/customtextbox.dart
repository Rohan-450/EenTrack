import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final String? initialValue;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextBox({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
    this.obscureText = false,
    this.validator,
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
        border: const OutlineInputBorder(),
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
