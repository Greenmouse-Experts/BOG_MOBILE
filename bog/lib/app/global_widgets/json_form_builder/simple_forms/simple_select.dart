import 'package:bog/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../helpers/function.dart';

class SimpleSelect extends StatefulWidget {
  const SimpleSelect({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  }) : super(key: key);
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;

  @override
  State<SimpleSelect> createState() => _SimpleSelectState();
}

class _SimpleSelectState extends State<SimpleSelect> {
  dynamic item;

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    Widget label = const SizedBox.shrink();
    if (Fun.labelHidden(item)) {
      label = Text(item['label'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
    }
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          label,
          const SizedBox(height: 5),
          DropdownButton<String>(
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            dropdownColor: AppColors.background,
            hint: const Text("Select a value"),
            value: item['placeholder'] ?? 'MALE',
            onChanged: (String? value) {
              setState(() {
                item['placeholder'] = value;
                widget.onChange(widget.position, value);
              });
            },
            items:
                item['_values'].map<DropdownMenuItem<String>>((dynamic data) {
              return DropdownMenuItem<String>(
                value: data['value'],
                child: Text(
                  data['label'],
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
