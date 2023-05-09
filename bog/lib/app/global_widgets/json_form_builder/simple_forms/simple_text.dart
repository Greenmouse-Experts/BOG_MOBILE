import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../core/theme/theme.dart';
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
          style: AppTextStyle.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
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
          TextFormField(
            style: AppTextStyle.bodyText2,
            decoration: InputDecoration(
                border: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder),
            controller: null,
            validator: MinLengthValidator(1, errorText: 'Enter a valid number'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onChange(widget.position, value);
            },
          ),
        if (item['inputType'] != 'number')
          TextFormField(
            style: AppTextStyle.bodyText2,
            decoration: InputDecoration(
                border: outlineInputBorder,
                disabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder),
            controller: null,
            maxLines: item['inputType'] == 'textarea' ? 5 : 1,
            validator: MinLengthValidator(3, errorText: 'Enter a valid text'),
            onChanged: (value) {
              widget.onChange(widget.position, value);
            },
          ),
      ],
    );
  }
}
