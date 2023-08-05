import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {Key? key,
      required this.title,
      this.trailingTitle = '',
      this.onPressed,
      this.bckgrndColor = AppColors.primary,
      this.borderRadius = 10,
      this.border,
      this.width = double.infinity,
      this.padding = const EdgeInsets.symmetric(vertical: 16),
      this.fontSize = 16,
      this.fontColor = Colors.white,
      this.trailingColor = AppColors.orange,
      this.bold = true,
      this.enabled = true,
      this.hasIcon = false,
      this.isGoogle = true,
      this.isElevated = false})
      : super(key: key);
  final String title;
  final String trailingTitle;
  final Function()? onPressed;
  final double borderRadius;
  final Color bckgrndColor;
  final Color fontColor;
  final Color trailingColor;
  final EdgeInsets padding;
  final double? width;
  final double fontSize;
  final bool bold;
  final bool enabled;
  final Border? border;
  final bool? hasIcon;
  final bool? isGoogle;
  final bool isElevated;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.enabled) {
          setState(() {
            loading = true;
          });
          await widget.onPressed!();
          setState(() {
            loading = false;
          });
        }
      },
      child: Material(
        elevation: widget.isElevated ? 4 : 0,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: widget.padding,
              // height: Get.width > 600 && Get.height < 800
              //     ? Get.height * 0.05
              //     : null,
              decoration: BoxDecoration(
                  color: widget.enabled ? widget.bckgrndColor : Colors.grey,
                  border: widget.border,
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
              child: Center(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: loading ? 0 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.hasIcon!
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(widget.isGoogle!
                                      ? 'assets/icons/googleIcon.webp'
                                      : 'assets/icons/apple-emblem.jpeg'))
                              : const SizedBox.shrink(),
                          const SizedBox(width: 5),
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: widget.fontColor,
                                fontSize: widget.fontSize *
                                    Get.textScaleFactor *
                                    0.90,
                                fontWeight: widget.bold
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                          Text(
                            widget.trailingTitle,
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: widget.trailingColor,
                                fontSize: widget.fontSize *
                                    Get.textScaleFactor *
                                    0.90,
                                fontWeight: widget.bold
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Opacity(
                          opacity: !loading ? 0 : 1,
                          child: SizedBox.square(
                            dimension:
                                widget.fontSize * Get.textScaleFactor * 0.9,
                            child: CircularProgressIndicator(
                              color: widget.fontColor,
                              strokeWidth: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppButton2 extends StatefulWidget {
  const AppButton2(
      {Key? key,
      required this.title,
      this.trailingTitle = '',
      this.onPressed,
      this.bckgrndColor = AppColors.primary,
      this.borderRadius = 10,
      this.border,
      this.width = double.infinity,
      this.padding = const EdgeInsets.symmetric(vertical: 16),
      this.fontSize = 16,
      this.fontColor = Colors.white,
      this.trailingColor = AppColors.orange,
      this.bold = true,
      this.enabled = true,
      this.hasIcon = false,
      this.isGoogle = true,
      this.isElevated = false})
      : super(key: key);
  final String title;
  final String trailingTitle;
  final Function()? onPressed;
  final double borderRadius;
  final Color bckgrndColor;
  final Color fontColor;
  final Color trailingColor;
  final EdgeInsets padding;
  final double? width;
  final double fontSize;
  final bool bold;
  final bool enabled;
  final Border? border;
  final bool? hasIcon;
  final bool? isGoogle;
  final bool isElevated;

  @override
  State<AppButton2> createState() => _AppButton2State();
}

class _AppButton2State extends State<AppButton2> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed!();
      },
      child: Material(
        elevation: widget.isElevated ? 4 : 0,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: widget.padding,
              // height: Get.width > 600 && Get.height < 800
              //     ? Get.height * 0.05
              //     : null,
              decoration: BoxDecoration(
                  color: widget.enabled ? widget.bckgrndColor : Colors.grey,
                  border: widget.border,
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
              child: Center(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: loading ? 0 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.hasIcon!
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(widget.isGoogle!
                                      ? 'assets/icons/googleIcon.webp'
                                      : 'assets/icons/apple-emblem.jpeg'))
                              : const SizedBox.shrink(),
                          const SizedBox(width: 5),
                          Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: widget.fontColor,
                                fontSize: widget.fontSize *
                                    Get.textScaleFactor *
                                    0.90,
                                fontWeight: widget.bold
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                          Text(
                            widget.trailingTitle,
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: widget.trailingColor,
                                fontSize: widget.fontSize *
                                    Get.textScaleFactor *
                                    0.90,
                                fontWeight: widget.bold
                                    ? FontWeight.w500
                                    : FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Opacity(
                          opacity: !loading ? 0 : 1,
                          child: SizedBox.square(
                            dimension:
                                widget.fontSize * Get.textScaleFactor * 0.9,
                            child: CircularProgressIndicator(
                              color: widget.fontColor,
                              strokeWidth: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.borderRadius = 10,
    this.border,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.fontSize = 16,
    this.fontColor = AppColors.bostonUniRed,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final double borderRadius;
  final Color fontColor;
  final EdgeInsets padding;
  final double? width;
  final double fontSize;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding,
        side: const BorderSide(
          width: 1.5,
          color: AppColors.bostonUniRed,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Get.theme.textTheme.bodyLarge!.copyWith(
          color: fontColor,
          fontSize: fontSize * Get.textScaleFactor * 0.9,
        ),
      ),
    );
  }
}
