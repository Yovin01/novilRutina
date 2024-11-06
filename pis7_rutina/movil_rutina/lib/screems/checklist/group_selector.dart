import 'package:flutter/material.dart';

class OneSelector extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int?> onSelectionChanged;

  OneSelector({
    required this.items,
    required this.selectedIndex,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(items.length, (int index) {
        return RadioListTile<int>(
          title: Text(items[index]),
          value: index,
          groupValue: selectedIndex,
          onChanged: onSelectionChanged,
        );
      }),
    );
  }
}
