import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final String? initialValue;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final Color? labelColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextBox({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
    this.obscureText = false,
    this.enabled = true,
    this.textInputAction,
    this.keyboardType,
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
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
