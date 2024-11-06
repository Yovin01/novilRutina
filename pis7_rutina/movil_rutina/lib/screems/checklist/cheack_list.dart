import 'package:flutter/material.dart';

class GroupSelector extends StatefulWidget {
  final List<String> items;
  final List<bool> selectedGroups;
  final Function(List<bool>) onSelectionChanged;

  GroupSelector({
    required this.items,
    required this.selectedGroups,
    required this.onSelectionChanged,
  });

  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.items.length, (index) {
          return CheckboxListTile(
            title: Text(widget.items[index]),
            value: widget.selectedGroups[index],
            onChanged: (bool? value) {
              setState(() {
                widget.selectedGroups[index] = value!;
              });
              widget.onSelectionChanged(widget.selectedGroups);
            },
          );
        },growable: true),
      ),
    );
  }
}
