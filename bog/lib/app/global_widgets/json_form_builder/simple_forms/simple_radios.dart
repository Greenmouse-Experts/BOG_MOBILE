import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

import '../helpers/function.dart';

class SimpleRadio extends StatefulWidget {
  const SimpleRadio({
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
  State<SimpleRadio> createState() => _SimpleRadioState();
}

class _SimpleRadioState extends State<SimpleRadio> {
  dynamic answer;
  dynamic item;
  dynamic id;
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
    answer = widget.answer;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> radios = [];

    if (Fun.labelHidden(item)) {
      radios.add(Text(item['label'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)));
    }
    //  radioValue = item['_values'][0]['value'];

    radioValue = item['value'];
    for (var i = 0; i < item['_values'].length; i++) {
      //options.add(item['_values'][i]['value']);
      radios.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(item['_values'][i]['label'])),
            Radio<dynamic>(
                activeColor: AppColors.primary,
                fillColor: MaterialStateColor.resolveWith((states) {
                  return AppColors.primary;
                }),
                value: item['_values'][i]['value'],
                groupValue: radioValue,
                onChanged: (dynamic value) {
                  setState(() {
                    radioValue = value;
                    item['value'] = value;
                    answer['value'] = value;
                     final resolver = widget.item['_values'] as List<dynamic>;
                    id = resolver.firstWhere((element) => element['value'] == value);
                    widget.onChange(widget.position, value, id['id']);
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

class AppRadioButtonForm extends StatefulWidget {
  final List<String> options;
  final String label;
  final Function onChange;
  final String? option1;
  final int position;
  final dynamic answer;
  const AppRadioButtonForm(
      {super.key,
      required this.options,
      required this.label,
      required this.option1,
      required this.position,
      required this.onChange,
      required this.answer});

  @override
  State<AppRadioButtonForm> createState() => _AppRadioButtonFormState();
}

class _AppRadioButtonFormState extends State<AppRadioButtonForm> {
  late String option;
  dynamic answer;

  @override
  void initState() {
    answer = widget.answer;
    option = widget.option1 ?? widget.options[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyle.bodyText2.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Column(
          children: List.generate(widget.options.length, (index) {
            return ListTile(
              title: Text(
                widget.options[index],
                style: AppTextStyle.subtitle1.copyWith(color: Colors.black87),
              ),
              leading: Radio(
                activeColor: AppColors.primary,
                value: widget.options[index],
                groupValue: option,
                onChanged: (value) {
                  setState(() {
                    widget.onChange(widget.position, value.toString(), );
                    answer['value'] = value.toString();
                   
                    option = value.toString();
                  });
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
