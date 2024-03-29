import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
// import 'package:get/get_core/src/get_main.dart';
import '../../core/theme/theme.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    Key? key,
    this.label,
    this.initalValue,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.isRounded = false,
    this.counterText,
    this.controller,
    this.filledColor = Colors.transparent,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.phoneController,
    this.onPhoneChanged,
    this.autofillHints,
    this.isPhoneNumber = false,
    this.autovalidateMode,
    this.prefexIcon,
    this.contentPadding = const EdgeInsets.fromLTRB(15, 10, 19, 10),
    this.borderSide = const BorderSide(
      width: 1,
      color: Color(0xFF828282),
    ),
    this.borderRadius = 10,
  }) : super(key: key);

  final String? label;
  final bool isRounded;
  final String hintText;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final bool? isPhoneNumber;
  final EdgeInsetsGeometry? contentPadding;
  final Color filledColor;
  final TextEditingController? phoneController;
  final Widget? suffixIcon;
  final Widget? prefexIcon;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Iterable<String>? autofillHints;
  final Function(String)? onChanged;
  final BorderSide borderSide;
  final double borderRadius;
  final TextAlign textAlign;
  final int? maxLength, maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? initalValue;
  final Function(PhoneNumber)? onPhoneChanged;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
    if (widget.controller != null) {
      if (widget.controller!.text.isNotEmpty) {
        if (widget.isPhoneNumber == true) {}
      }
    }
  }

  void _onObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: widget.borderSide
          .copyWith(color: const Color(0xFF828282).withOpacity(.3)),
    );

    // var contentPadding = widget.contentPadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding: EdgeInsets.only(
                    left: widget.borderSide == BorderSide.none ? 15 : 5),
                child: Text(
                  widget.label!,
                  style: AppTextStyle.bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: widget.label != null ? 3 : 0,
        ),
        widget.isPhoneNumber!
            ? IntlPhoneField(
                //   initialCountryCode: 'NG',
                initialValue: widget.initalValue,
                obscureText: obscureText,
                readOnly: widget.readOnly,
                textAlign: widget.textAlign,
                autovalidateMode: widget.autovalidateMode,
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                onChanged: widget.onPhoneChanged,
                style: AppTextStyle.bodyText2.copyWith(
                  fontWeight: widget.borderSide == BorderSide.none
                      ? FontWeight.w600
                      : FontWeight.w500,
                  fontSize:
                      Get.width > 600 ? Get.width * .025 : Get.width * .035,
                ),
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  suffixIcon: widget.obscureText == true
                      ? GestureDetector(
                          onTap: _onObscureText,
                          child: Icon(
                            obscureText
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye,
                            color: AppColors.spanishGray,
                            size: 19,
                          ),
                        )
                      : widget.suffixIcon,
                  prefixIcon: widget.prefexIcon,
                  contentPadding: widget.contentPadding,
                  hintText: widget.hintText,
                  counterText: widget.counterText,
                  border: outlineInputBorder,
                  fillColor: widget.filledColor,
                  filled: true,
                  focusColor: AppColors.spanishGray,
                  hintStyle: AppTextStyle.bodyText2.copyWith(
                    color: const Color(0xFFC4C4C4),
                    fontSize:
                        Get.width > 600 ? Get.width * .025 : Get.width * .035,
                    fontWeight: widget.borderSide == BorderSide.none
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                ),
              )
            : TextFormField(
                initialValue: widget.initalValue,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                onFieldSubmitted: widget.onFieldSubmitted,
                onChanged: widget.onChanged,
                obscureText: obscureText,
                readOnly: widget.readOnly,
                textAlign: widget.textAlign,
                autovalidateMode: widget.autovalidateMode,
                maxLines: widget.maxLines,
                controller: widget.controller,
                maxLength: widget.maxLength,
                validator: widget.validator,
                autofillHints: widget.autofillHints,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                style: AppTextStyle.bodyText2.copyWith(
                  fontWeight: widget.borderSide == BorderSide.none
                      ? FontWeight.w600
                      : FontWeight.w500,
                  fontSize:
                      Get.width > 600 ? Get.width * .025 : Get.width * .035,
                ),
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  suffixIcon: widget.obscureText == true
                      ? GestureDetector(
                          onTap: _onObscureText,
                          child: Icon(
                            obscureText
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye,
                            color: AppColors.spanishGray,
                            size: 19,
                          ),
                        )
                      : widget.suffixIcon,
                  prefixIcon: widget.prefexIcon,
                  contentPadding: widget.contentPadding,
                  hintText: widget.hintText,
                  counterText: widget.counterText,
                  border: outlineInputBorder,
                  fillColor: widget.filledColor,
                  filled: true,
                  focusColor: AppColors.spanishGray,
                  hintStyle: AppTextStyle.bodyText2.copyWith(
                    color: const Color(0xFFC4C4C4),
                    fontSize:
                        Get.width > 600 ? Get.width * .025 : Get.width * .035,
                    fontWeight: widget.borderSide == BorderSide.none
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                ),
              ),
      ],
    );
  }
}

class DisabledAppInput extends StatefulWidget {
  const DisabledAppInput({
    Key? key,
    this.label,
    this.initalValue,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.isRounded = false,
    this.counterText,
    this.controller,
    this.filledColor = Colors.transparent,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.autovalidateMode,
    this.prefexIcon,
    this.contentPadding = const EdgeInsets.fromLTRB(15, 10, 19, 10),
    this.borderSide = const BorderSide(
      width: 1,
      color: Color(0xFF828282),
    ),
    this.borderRadius = 10,
  }) : super(key: key);

  final String? label;
  final bool isRounded;
  final String hintText;
  final String? counterText;
  final bool obscureText;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Color filledColor;
  final Widget? suffixIcon;
  final Widget? prefexIcon;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final BorderSide borderSide;
  final double borderRadius;
  final TextAlign textAlign;
  final int? maxLength, maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? initalValue;

  @override
  State<DisabledAppInput> createState() => _DisabledAppInputState();
}

class _DisabledAppInputState extends State<DisabledAppInput> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  void _onObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: widget.borderSide
          .copyWith(color: const Color(0xFF828282).withOpacity(.3)),
    );

    // var contentPadding = widget.contentPadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding: EdgeInsets.only(
                    left: widget.borderSide == BorderSide.none ? 15 : 5),
                child: Text(
                  widget.label!,
                  style: AppTextStyle.bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: widget.label != null ? 3 : 0,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: const Color(0xFF828282).withOpacity(.3))),
          child: TextFormField(
            enabled: false,
            initialValue: widget.initalValue,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            obscureText: obscureText,
            readOnly: widget.readOnly,
            textAlign: widget.textAlign,
            autovalidateMode: widget.autovalidateMode,
            maxLines: widget.maxLines,
            controller: widget.controller,
            maxLength: widget.maxLength,
            validator: widget.validator,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            style: AppTextStyle.bodyText2.copyWith(
              fontWeight: widget.borderSide == BorderSide.none
                  ? FontWeight.w600
                  : FontWeight.w500,
              fontSize: Get.width > 600 ? Get.width * .025 : Get.width * .035,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              suffixIcon: widget.obscureText == true
                  ? GestureDetector(
                      onTap: _onObscureText,
                      child: Icon(
                        obscureText ? FeatherIcons.eyeOff : FeatherIcons.eye,
                        color: AppColors.spanishGray,
                        size: 19,
                      ),
                    )
                  : widget.suffixIcon,
              prefixIcon: widget.prefexIcon,
              contentPadding: widget.contentPadding,
              hintText: widget.hintText,
              counterText: widget.counterText,
              border: outlineInputBorder,
              fillColor: widget.filledColor,
              filled: true,
              focusColor: AppColors.spanishGray,
              hintStyle: AppTextStyle.bodyText2.copyWith(
                color: const Color(0xFFC4C4C4),
                fontSize: Get.width > 600 ? Get.width * .025 : Get.width * .035,
                fontWeight: widget.borderSide == BorderSide.none
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
            ),
          ),
        ),
      ],
    );
  }
}
