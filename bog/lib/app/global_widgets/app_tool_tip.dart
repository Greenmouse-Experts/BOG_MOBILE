import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/theme.dart';

class AppToolTip extends StatelessWidget {
  final String message;
  const AppToolTip({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: message,
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 2, milliseconds: 500),
          child: Icon(
            Icons.info,
            color: AppColors.primary,
            size: Get.width * 0.075,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
