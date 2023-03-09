import 'package:bog/core/theme/app_colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_styles.dart';

class ExpandableFAQ extends StatelessWidget {
  final String question;
  final String answer;
  const ExpandableFAQ(
      {super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ExpandablePanel(
          collapsed: ExpandableButton(
            child: ExpandableHeader(
              isArrowDown: true,
              header: question,
            ),
          ),
          expanded: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandableButton(
                child: ExpandableHeader(
                  isArrowDown: false,
                  header: question,
                ),
              ),
              Text(
                answer,
                style: AppTextStyle.bodyText1
                    .copyWith(color: AppColors.blue.withOpacity(0.8)),
              )
            ],
          )),
    );
  }
}

class ExpandableHeader extends StatelessWidget {
  final bool isArrowDown;
  final String header;
  const ExpandableHeader({
    super.key,
    required this.isArrowDown,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width * 0.7,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              header,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: AppTextStyle.subtitle1.copyWith(
                  color: Colors.black,
                  fontSize: Get.width * 0.038,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ]),
        ),
        Icon(
          isArrowDown
              ? Icons.keyboard_arrow_down_rounded
              : Icons.keyboard_arrow_up_rounded,
          color: Colors.black,
          size: Get.width * 0.075,
        )
      ],
    );
  }
}
