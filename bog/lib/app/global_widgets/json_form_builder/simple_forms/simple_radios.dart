import 'package:flutter/material.dart';

import '../helpers/function.dart';

class SimpleRadios extends StatefulWidget {
  const SimpleRadios({
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
  State<SimpleRadios> createState() => _SimpleRadiosState();
}

class _SimpleRadiosState extends State<SimpleRadios> {
  dynamic item;
  late dynamic radioValue;

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['label']] ?? 'Please enter some text';
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
    List<Widget> radios = [];

    if (Fun.labelHidden(item)) {
      radios.add(Text(item['label'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)));
    }
    //  radioValue = item['_values'][0]['value'];
    radioValue = item['placeholder'];
    for (var i = 0; i < item['_values'].length; i++) {
      radios.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(item['_values'][i]['label'])),
            Radio<dynamic>(
                value: item['_values'][i]['value'],
                groupValue: radioValue ?? true,
                onChanged: (dynamic value) {
                  setState(() {
                    radioValue = value;
                    item['placeholder'] = value;
                    widget.onChange(widget.position, value);
                  });
                })
          ],
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: radios,
      ),
    );
  }
}
