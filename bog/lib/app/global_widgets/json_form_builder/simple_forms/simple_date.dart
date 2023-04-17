// import 'package:bog/app/global_widgets/page_input.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';
import '../../app_date_picker.dart';
import '../helpers/function.dart';

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

  // String val = '';
  // final myController = TextEditingController();

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
    return AppDatePicker(
      onChanged: (value) {
        widget.onChange(widget.position, value);
      },
      boldLabel: true,
      label: item['label'],
    );
  }
}
