import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';
import '../../page_dropdown.dart';
import '../helpers/function.dart';

class SimpleSelects extends StatefulWidget {
  const SimpleSelects({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
    required this.answer,
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
  State<SimpleSelects> createState() => _SimpleSelectsState();
}

class _SimpleSelectsState extends State<SimpleSelects> {
  dynamic item;
  dynamic answer;
  dynamic id;
  dynamic initial;

  @override
  void initState() {
    super.initState();
    initial = widget.item['_values'][0]['value'].toString();
    item = widget.item;
    answer = widget.answer;
  }

  @override
  Widget build(BuildContext context) {
    Widget label = const SizedBox.shrink();
    final theOptions = item['_values'] as List<dynamic>;
    final options = <String>[];

    Widget required = const SizedBox.shrink();
    if (item["required"] == true) {
      required = const Text("*", style: TextStyle(color: Colors.red));
    }

    for (var element in theOptions) {
      options.add(element['value'].toString());
    }

    if (Fun.labelHidden(item)) {
      label = Text(
        item['label'],
        style: AppTextStyle.bodyText2.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [label, const SizedBox(width: 5), required],
        ),
        const SizedBox(height: 5),
        PageDropButton(
          label: '',
          hint: '',
          padding: const EdgeInsets.symmetric(horizontal: 10),
          style: AppTextStyle.bodyText2.copyWith(color: Colors.black),
          items: options.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: AppTextStyle.bodyText2.copyWith(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            final resolver = widget.item['_values'] as List<dynamic>;
            id = resolver.firstWhere((element) => element['value'] == newValue);
            widget.onChange(widget.position, newValue, id['id']);

            setState(() {
              initial = newValue!;
            });
          },
          value: initial,
        ),
      ],
    );
  }
}
