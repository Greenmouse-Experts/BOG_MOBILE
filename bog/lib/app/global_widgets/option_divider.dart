import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/theme.dart';

class OptionDivider extends StatelessWidget {
  const OptionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.015),
      child: Row(
        children: [
          const Expanded(
              child: Divider(
            color: Colors.black45,
          )),
          const SizedBox(width: 10),
          Text(
            'OR',
            style: AppTextStyle.bodyText2,
          ),
          const SizedBox(width: 10),
          const Expanded(
              child: Divider(
            color: Colors.black45,
          )),
        ],
      ),
    );
  }
}
