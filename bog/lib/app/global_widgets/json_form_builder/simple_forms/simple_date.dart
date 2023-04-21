
import 'package:flutter/material.dart';

import '../../app_date_picker.dart';


class SimpleDate extends StatefulWidget {
  const SimpleDate({
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
  State<SimpleDate> createState() => _SimpleDateState();
}

class _SimpleDateState extends State<SimpleDate> {
  dynamic item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return AppDatePicker(
      onChanged: (value) {
        widget.onChange(widget.position, value);
      },
      boldLabel: true,
      label: item['label'],
    );
  }
}
