import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import '../../core/theme/theme.dart';

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
                style: AppTextStyle.bodyText3
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
                  fontSize:
                      Get.width > 600 ? Get.width * 0.027 : Get.width * 0.03,
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
          size: Get.width > 600 ? Get.width * 0.06 : Get.width * 0.075,
        )
      ],
    );
  }
}
