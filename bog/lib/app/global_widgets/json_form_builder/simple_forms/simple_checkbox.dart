import 'package:flutter/material.dart';

import '../helpers/function.dart';

class SimpleListCheckbox extends StatefulWidget {
  const SimpleListCheckbox({
    Key? key,
    required this.item,
    required this.onChange,
    required this.answer,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  }) : super(key: key);
  final dynamic item;
  final Function onChange;
  final int position;
  final dynamic answer;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;

  @override
  _SimpleListCheckbox createState() => _SimpleListCheckbox();
}

class _SimpleListCheckbox extends State<SimpleListCheckbox> {
  dynamic item;
  List<dynamic> selectItems = [];
  List<int> selectedIds = [];
  dynamic answer;

  // String? isRequired(item, value) {
  //   if (value.isEmpty) {
  //     return widget.errorMessages[item['key']] ?? 'Please enter some text';
  //   }
  //   return null;
  // }

  @override
  void initState() {
    super.initState();
    answer = widget.answer;
    item = widget.item;
    for (var i = 0; i < item['_values'].length; i++) {
      if (item['_values'][i]['value'] == true) {
        selectItems.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> checkboxes = [];
    if (Fun.labelHidden(item)) {
      checkboxes.add(Text(item['label'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)));
    }
    for (var i = 0; i < item['_values'].length; i++) {
      checkboxes.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(item['_values'][i]['label'])),
            Checkbox(
              //value: true,
              value: selectItems.contains(item['_values'][i]['value']),
              onChanged: (bool? value) {
                setState(
                  () {
                    //   item['_values'][i]['value'] = value;
                    if (value!) {
                      selectItems.add(item['_values'][i]['value']);
                      selectedIds.add(item['_values'][i]['id']);
                      //  answer.add(item['_values'][i]['value']);
                    } else {
                      selectItems.remove(item['_values'][i]['value']);
                      //  answer.remove(item['_values'][i]['value']);
                      selectedIds.remove(item['_values'][i]['id']);
                    }

                    widget.onChange(widget.position, selectItems, selectedIds);
                    //_handleChanged();
                  },
                );
              },
            ),
          ],
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checkboxes,
      ),
    );
  }
}
