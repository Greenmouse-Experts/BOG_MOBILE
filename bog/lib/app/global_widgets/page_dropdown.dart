import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class PageDropButton extends StatelessWidget {
  const PageDropButton({
    Key? key,
    required this.label,
    required this.hint,
    this.padding = const EdgeInsets.fromLTRB(5, 0, 0, 0),
    this.validator,
    this.items,
    this.value,
    this.onChanged,
    this.bckgrndColor,
    this.style
  }) : super(key: key);

  final TextStyle? style;
  final String label;
  final String hint;
  final dynamic value;
  final EdgeInsets padding;
  final String? Function(dynamic)? validator;
  final Color? bckgrndColor;
  final List<DropdownMenuItem<dynamic>>? items;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(label,style: style ?? AppTextStyle.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            : const SizedBox.shrink(),
        AppDropdownButton(
          value: value,
          borderRadius: 10,
          hint: hint,
          borderSide: BorderSide(
            width: 1,
            color: const Color(0xFF828282).withOpacity(.3),
          ),
          validator: validator,
          padding: padding,
          onChanged: onChanged,
          items: items,
        ),
      ],
    );
  }
}

class PageDropButtonWithoutBackground extends StatelessWidget {
  const PageDropButtonWithoutBackground({
    Key? key,
    required this.label,
    required this.hint,
    this.padding = const EdgeInsets.fromLTRB(5, 0, 0, 0),
    this.validator,
    this.items,
    this.value,
    this.onChanged,
    this.bckgrndColor,
    this.style
  }) : super(key: key);

  final TextStyle? style;
  final String label;
  final String hint;
  final dynamic value;
  final EdgeInsets padding;
  final String? Function(dynamic)? validator;
  final Color? bckgrndColor;
  final List<DropdownMenuItem<dynamic>>? items;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isNotEmpty
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(label,style: style),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )
            : const SizedBox.shrink(),
        AppDropdownButtonWithoutBackground(
          value: value,
          borderRadius: 0,
          hint: hint,
          borderSide: BorderSide.none,
          validator: validator,
          padding: padding,
          onChanged: onChanged,
          items: items,
        ),
      ],
    );
  }
}

class AppDropdownButton<T> extends StatelessWidget {
  const AppDropdownButton({
    Key? key,
    this.borderRadius = 8,
    this.borderSide = BorderSide.none,
    this.padding = const EdgeInsets.fromLTRB(25, 20, 19, 20),
    required this.hint,
    this.validator,
    this.items,
    this.onChanged,
    this.value,
  }) : super(key: key);

  final EdgeInsets padding;
  final double borderRadius;
  final String hint;
  final BorderSide borderSide;
  final String? Function(T?)? validator;

  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final T? value;
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: borderSide,
    );

    return DropdownButtonFormField<T>(
      onChanged: onChanged,
      value: value,
      validator: validator,
      items: items,
      isExpanded: true,
      hint: Center(child: Text(hint)),
      style: const TextStyle(color: Colors.black),
      alignment: AlignmentDirectional.center,
      decoration: InputDecoration(
          enabledBorder: outlineInputBorder,
          border: outlineInputBorder,
          contentPadding: padding
      ),
      icon:  const Icon(Icons.arrow_drop_down,color: Colors.black,),
      dropdownColor: Colors.white,
    );
  }
}

class AppDropdownButtonWithoutBackground<T> extends StatelessWidget {
  const AppDropdownButtonWithoutBackground({
    Key? key,
    this.borderRadius = 8,
    this.borderSide = BorderSide.none,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    required this.hint,
    this.validator,
    this.items,
    this.onChanged,
    this.value,
  }) : super(key: key);

  final EdgeInsets padding;
  final double borderRadius;
  final String hint;
  final BorderSide borderSide;
  final String? Function(T?)? validator;

  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final T? value;
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: borderSide,
    );

    return ButtonTheme(
      alignedDropdown: false,
      layoutBehavior: ButtonBarLayoutBehavior.values[1],
      child: DropdownButtonFormField<T>(
        onChanged: onChanged,
        value: value,
        validator: validator,
        items: items,
        isExpanded: true,
        isDense: true,
        hint: Text(hint),
        style: const TextStyle(color: Colors.black),
        alignment: AlignmentDirectional.center,
        decoration: InputDecoration(
            enabledBorder: outlineInputBorder,
            border: outlineInputBorder,
            contentPadding: padding
        ),
        iconSize: Get.height * .04,
        icon:  Image.asset('assets/images/filter.png'),
        dropdownColor: Colors.white,
      ),
    );
  }
}

