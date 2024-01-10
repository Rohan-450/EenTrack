import 'package:flutter/material.dart';

class MultiSelectionSwitch extends StatelessWidget {
  final List<String> lables;
  final int selectedIndex;
  final double? fontSize;
  final void Function(int) onChanged;

  const MultiSelectionSwitch({
    super.key,
    required this.lables,
    required this.selectedIndex,
    required this.onChanged,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: lables.asMap().entries.map((entry) {
            final index = entry.key;
            final label = entry.value;
            return Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: index == selectedIndex
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  foregroundColor: index == selectedIndex
                      ? Theme.of(context).colorScheme.onPrimary
                      : null,
                ),
                onPressed: () => onChanged(index),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label.toString(),
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
