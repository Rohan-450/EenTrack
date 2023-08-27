import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color? labelColor;
  final Color? containerColor;
  final Widget? trailing;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.labelColor,
    this.containerColor,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: containerColor ?? Colors.grey[900],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
