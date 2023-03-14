import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../helpers/function.dart';

class SimpleText extends StatefulWidget {
  const SimpleText({
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
  State<SimpleText> createState() => _SimpleTextState();
}

class _SimpleTextState extends State<SimpleText> {
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
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          label,
          const SizedBox(height: 5),
          TextFormField(
            controller: null,
            initialValue: item['value'] ?? '',
            style: AppTextStyle.bodyText2.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Get.width * .035,
            ),
            decoration: item['decoration'] ??
                widget.decorations[item['key']] ??
                InputDecoration(
                  border: outlineInputBorder,
                  fillColor: AppColors.blue,
                  focusColor: AppColors.spanishGray,
                  hintStyle: AppTextStyle.bodyText2.copyWith(
                    color: const Color(0xFFC4C4C4),
                    fontSize: Get.width * .035,
                    fontWeight: FontWeight.normal,
                  ),
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  hintText: item['placeholder'] ?? "",
                  helperText: item['helpText'] ?? "",
                ),
            maxLines: item['inputType'] == "textarea" ? 10 : 1,
            onChanged: (String value) {
              item['value'] = value;
              // _handleChanged();
              //  print(value);
              widget.onChange(widget.position, value);
            },
            obscureText: item['type'] == "Password" ? true : false,
            keyboardType: item['inputType'] == 'number'
                ? TextInputType.number
                : item['keyboardType'] ??
                    widget.keyboardTypes[item['key']] ??
                    TextInputType.text,
            validator: (value) {
              if (widget.validations.containsKey(item['key'])) {
                return widget.validations[item['key']](item, value);
              }
              if (item.containsKey('validator')) {
                if (item['validator'] != null) {
                  if (item['validator'] is Function) {
                    return item['validator'](item, value);
                  }
                }
              }
              if (item['type'] == "Email") {
                return Fun.validateEmail(item, value!);
              }

              if (item.containsKey('required')) {
                if (item['required'] == true ||
                    item['required'] == 'True' ||
                    item['required'] == 'true') {
                  return isRequired(item, value);
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
