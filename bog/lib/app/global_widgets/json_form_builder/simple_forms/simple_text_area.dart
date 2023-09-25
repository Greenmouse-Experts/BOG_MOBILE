import 'package:flutter/material.dart';

import '../../page_input.dart';

class SimpleTextArea extends StatefulWidget {
  const SimpleTextArea({
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
  State<SimpleTextArea> createState() => _SimpleTextAreaState();
}

class _SimpleTextAreaState extends State<SimpleTextArea> {
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
    return PageInput(
      hint: item['value'] ?? '',
      boldLabel: true,
      isCompulsory: item["required"] == true,
      label: item['label'],
      isTextArea: true,
    );
  }
}
