import 'package:bog/app/global_widgets/app_drop_down_button.dart';
import 'package:bog/core/theme/app_colors.dart';
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

  // String? isRequired(item, value) {
  //   if (value.isEmpty) {
  //     return widget.errorMessages[item['key']] ?? 'Please enter some text';
  //   }
  //   return null;
  // }

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

    for (var element in theOptions) {
      options.add(element['value'].toString());
    }

    if (Fun.labelHidden(item)) {
      label = Text(
        item['label'],
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
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
