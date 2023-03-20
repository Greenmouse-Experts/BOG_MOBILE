import 'package:bog/core/theme/theme.dart';
import 'package:flutter/material.dart';

import '../helpers/function.dart';

class SimpleTexts extends StatefulWidget {
  const SimpleTexts({
    Key? key,
    required this.item,
    required this.answer,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  }) : super(key: key);
  final dynamic item;
  final dynamic answer;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;

  @override
  State<SimpleTexts> createState() => _SimpleTextsState();
}

class _SimpleTextsState extends State<SimpleTexts> {
  dynamic item;
  dynamic answer;

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
    answer = widget.answer;
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide()
          .copyWith(color: const Color(0xFF828282).withOpacity(.3)),
    );
    Widget label = const SizedBox.shrink();
    if (Fun.labelHidden(item)) {
      label = SizedBox(
        child: Text(
          item['label'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        const SizedBox(height: 5),
        if (item['inputType'] == 'number')
          TextField(
            style: AppTextStyle.bodyText2,
            decoration: InputDecoration(
                border: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder),
            controller: null,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onChange(widget.position, value);
            },
          ),
        if (item['inputType'] != 'number')
          TextField(
            style: AppTextStyle.bodyText2,
            decoration: InputDecoration(
                border: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder),
            controller: null,
            maxLines: item['inputType'] == 'textarea' ? 5 : 1,
            onChanged: (value) {
              widget.onChange(widget.position, value);
            },
          ),
      ],
    );
  }
}
