import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final bool enabled;
  final double padding;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.enabled = true,
    this.padding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
              ),
              onPressed: enabled ? onPressed : null,
              child: Text(text),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final double padding;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.padding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: padding),
        Expanded(
          child: TextButton(
            onPressed: enabled ? onPressed : null,
            child: Text(text),
          ),
        ),
        SizedBox(width: padding),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final IconData icon;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    required this.icon,
    this.iconColor = Colors.black,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
      highlightColor: backgroundColor,
    );
  }
}
