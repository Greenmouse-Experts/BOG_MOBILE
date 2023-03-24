import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class AppDatePicker extends StatefulWidget {
  final String label;
  final Function onChanged;
  final String? initialDate;
  const AppDatePicker(
      {super.key, required this.label, required this.onChanged, this.initialDate = ''});

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = widget.initialDate ?? ''; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide()
          .copyWith(color: const Color(0xFF828282).withOpacity(.3)),
    );
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
        const SizedBox(height: 5),
        TextFormField(
          controller: dateinput,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            icon: const Icon(
              Icons.calendar_today,
              color: AppColors.primary,
            ),
            border: outlineInputBorder,
            filled: true,
            focusColor: Colors.black,
            hintStyle: AppTextStyle.bodyText2.copyWith(
              color: Colors.black,
              fontSize: Get.width * .035,
              fontWeight: FontWeight.normal,
            ),
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
             
              final formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              widget.onChanged(formattedDate);

              setState(() {
                dateinput.text = formattedDate;
              });
            } else {
              // print("Date is not selected");
            }
          },
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}
