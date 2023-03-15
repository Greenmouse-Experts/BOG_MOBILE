import 'package:bog/app/global_widgets/page_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
    return
    // PageInput(hint: '', label: item['label'], );
    
    Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          label,
          const SizedBox(height: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                  // onTap: () {
                  //   selectDate();
                  // },
                  child: TextFormField(
                readOnly: true,
                style: AppTextStyle.bodyText2.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Get.width * .035,
                ),
                decoration: InputDecoration(
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
                  //border: OutlineInputBorder(),
                  hintText: item['placeholder'] ?? '',
                  //prefixIcon: Icon(Icons.date_range_rounded),
                  suffixIcon: IconButton(
                    onPressed: () {
                      selectDate();
                    },
                    icon: const Icon(Icons.calendar_today_rounded),
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  Future selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 360)),
        firstDate: DateTime.now().subtract(const Duration(days: 360)),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      String date =
          "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {
        item['placeholder'] = date;
        widget.onChange(widget.position, date);
      });
    }
  }
}
