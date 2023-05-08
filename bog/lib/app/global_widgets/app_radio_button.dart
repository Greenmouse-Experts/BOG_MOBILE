import 'package:bog/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRadioButton extends StatefulWidget {
  final List<String> options;
  final String label;
  final String? option1;
  final Function onchanged;
  const AppRadioButton(
      {super.key,
      required this.options,
      required this.label,
      required this.option1,
      required this.onchanged});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  late String option;

  @override
  void initState() {
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
                  widget.onchanged(value);
                  setState(() {
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

class NewAppRadioButton extends StatefulWidget {
  final List<String> options;
  final String label;
  final String? option1;
  final Function onchanged;
  const NewAppRadioButton(
      {super.key,
      required this.options,
      required this.label,
      required this.option1,
      required this.onchanged});

  @override
  State<NewAppRadioButton> createState() => _NewAppRadioButtonState();
}

class _NewAppRadioButtonState extends State<NewAppRadioButton> {
  late String option;

  @override
  void initState() {
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
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
              horizontalTitleGap: 0,
              minLeadingWidth: Get.width * 0.01,
              title: Text(
                widget.options[index],
                style: AppTextStyle.subtitle1.copyWith(color: Colors.black87),
              ),
              leading: SizedBox(
                height: 30,
                width: 30,
                child: FittedBox(
                  alignment: Alignment.center,
                  child: Radio(
                    activeColor: AppColors.primary,
                    value: widget.options[index],
                    groupValue: option,
                    onChanged: (value) {
                      widget.onchanged(value);
                      setState(() {
                        option = value.toString();
                      });
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
