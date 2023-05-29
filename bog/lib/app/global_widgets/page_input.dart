import 'dart:io';

import 'package:dart_countries/dart_countries.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/theme.dart';
import 'app_input.dart';
import 'page_dropdown.dart';

class PageInput extends StatefulWidget {
  const PageInput({
    Key? key,
    required this.hint,
    required this.label,
    this.prefix,
    this.initialValue,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isTextArea = false,
    this.validator,
    this.autovalidateMode,
    this.readOnly = false,
    this.isCompulsory = false,
    this.isPhoneNumber = false,
    this.dropDownItems,
    this.onDropdownChanged,
    this.isReferral = false,
    this.showInfo = true,
    this.textWidth = 0.8,
    this.isFilePicker = false,
    this.borderSide = const BorderSide(
      width: 1,
      color: Color(0xFF828282),
    ),
    this.onchanged,
    this.onFilePicked,
    this.boldLabel = false,
  }) : super(key: key);

  final String hint;
  final String label;
  final AutovalidateMode? autovalidateMode;
  final Widget? prefix;
  final double textWidth;
  final TextInputType keyboardType;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final bool isCompulsory;
  final bool isPhoneNumber;
  final bool isReferral;
  final bool showInfo;
  final bool isTextArea;
  final bool isFilePicker;
  final BorderSide borderSide;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<dynamic>>? dropDownItems;
  final Function(dynamic)? onDropdownChanged;
  final Function(File)? onFilePicked;
  final Function? onchanged;
  final String? initialValue;
  final bool? boldLabel;

  @override
  State<PageInput> createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  var showText = false;

  @override
  void initState() {
    super.initState();
    if (widget.obscureText) {
      if (widget.controller != null) {
        widget.controller!.addListener(() {
          if (widget.controller!.text.isNotEmpty) {
            setState(() {
              showText = true;
            });
          } else {
            setState(() {
              showText = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: widget.borderSide == BorderSide.none ? 15 : 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // width: Get.width * widget.textWidth,
                child: Text(
                  widget.label,
                  style: AppTextStyle.bodyText2.copyWith(
                    fontWeight:
                        widget.boldLabel! ? FontWeight.w600 : FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              // if (widget.isCompulsory) const SizedBox(width: 5),
              if (widget.isCompulsory)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    "",
                    style: AppTextStyle.bodyText2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              if (widget.isReferral && widget.showInfo)
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showText = !showText;
                          });
                        },
                        child: Image.asset(
                          'assets/images/info.png',
                          width: Get.width * 0.04,
                          height: Get.width * 0.04,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                    ]))
            ],
          ),
        ),
        const SizedBox(height: 5),
        if (widget.isPhoneNumber && !showText)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: AppInput(
                hintText: widget.hint,
                isPhoneNumber: true,
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                validator: widget.validator,
                obscureText: widget.obscureText,
                autovalidateMode: widget.autovalidateMode,
                readOnly: widget.readOnly,
                prefexIcon: widget.prefix,
                suffixIcon: widget.suffix,
                borderSide: widget.borderSide,
              ))
              // SizedBox(
              //   width: Get.width * 0.2,
              //   child: PageDropButton(
              //     label: "",
              //     hint: '',
              //     onChanged: (val) {
              //       if (widget.onDropdownChanged != null) {
              //         widget.onDropdownChanged!(val);
              //       }
              //     },
              //     value: countries.firstWhere(
              //         (element) => element.name.toLowerCase() == 'nigeria'),
              //     items:
              //         countries.map<DropdownMenuItem<Country>>((Country value) {
              //       return DropdownMenuItem<Country>(
              //         value: value,
              //         child: Container(
              //           color: Colors.white,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(value.flag),
              //               Text("+${value.countryCode}"),
              //             ],
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
              // SizedBox(
              //   width: Get.width * 0.7,
              //   child: AppInput(
              //     hintText: widget.hint,
              //     keyboardType: widget.keyboardType,
              //     controller: widget.controller,
              //     validator: widget.validator,
              //     obscureText: widget.obscureText,
              //     autovalidateMode: widget.autovalidateMode,
              //     readOnly: widget.readOnly,
              //     prefexIcon: widget.prefix,
              //     suffixIcon: widget.suffix,
              //     borderSide: widget.borderSide,
              //   ),
              // ),
            ],
          ),
        if ((!widget.isPhoneNumber && !showText) || widget.obscureText)
          AppInput(
            initalValue: widget.initialValue,
            onChanged: (p0) {
              if (widget.onchanged != null) {
                widget.onchanged!(p0);
              }
            },
            hintText: !widget.isFilePicker
                ? widget.hint
                : 'Click to open file picker',
            maxLines: widget.isTextArea ? 5 : 1,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.obscureText,
            autovalidateMode: widget.autovalidateMode,
            borderSide: widget.borderSide,
            readOnly: widget.readOnly || widget.isFilePicker,
            prefexIcon: !widget.isFilePicker
                ? widget.prefix
                : InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path.toString());
                        if (widget.controller != null) {
                          widget.controller!.text = file.path.split('/').last;
                        }

                        if (widget.onFilePicked != null) {
                          widget.onFilePicked!(file);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        width: Get.width * 0.25,
                        child: Center(
                          child: Text(
                            'Choose file',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodyText2.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            suffixIcon: widget.suffix,
          ),
        const SizedBox(
          height: 5,
        ),
        if (showText && widget.showInfo)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffEAF3FB),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xffEAF3FB)),
            ),
            child: Padding(
              padding: EdgeInsets.all(Get.width * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/info.png',
                    width: Get.width * 0.04,
                    height: Get.width * 0.04,
                    color: Colors.black,
                  ),
                  SizedBox(width: Get.width * 0.02),
                  Expanded(
                    child: Text(
                      widget.isReferral
                          ? 'Please, only enter the referral. Leave empty if you don\'t have a referral code.'
                          : 'The password must contain minimum of 8 characters, uppercase character and a unique character',
                      style: AppTextStyle.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: Get.width > 600
                            ? Get.width * 0.025
                            : Get.width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}

class DisabledPageInput extends StatefulWidget {
  const DisabledPageInput({
    Key? key,
    required this.hint,
    required this.label,
    this.prefix,
    this.initialValue,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isTextArea = false,
    this.validator,
    this.autovalidateMode,
    this.readOnly = false,
    this.isCompulsory = false,
    this.isPhoneNumber = false,
    this.dropDownItems,
    this.onDropdownChanged,
    this.isReferral = false,
    this.showInfo = true,
    this.isFilePicker = false,
    this.borderSide = const BorderSide(
      width: 1,
      color: Color(0xFF828282),
    ),
    this.onFilePicked,
  }) : super(key: key);

  final String hint;
  final String label;
  final AutovalidateMode? autovalidateMode;
  final Widget? prefix;
  final TextInputType keyboardType;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final bool isCompulsory;
  final bool isPhoneNumber;
  final bool isReferral;
  final bool showInfo;
  final bool isTextArea;
  final bool isFilePicker;
  final BorderSide borderSide;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<dynamic>>? dropDownItems;
  final Function(dynamic)? onDropdownChanged;
  final Function(File)? onFilePicked;
  final String? initialValue;

  @override
  State<DisabledPageInput> createState() => _DisabledPageInputState();
}

class _DisabledPageInputState extends State<DisabledPageInput> {
  var showText = false;

  @override
  void initState() {
    super.initState();
    if (widget.obscureText) {
      if (widget.controller != null) {
        widget.controller!.addListener(() {
          if (widget.controller!.text.isNotEmpty) {
            setState(() {
              showText = true;
            });
          } else {
            setState(() {
              showText = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: widget.borderSide == BorderSide.none ? 15 : 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                //width: Get.width * 0.8,
                child: Text(
                  widget.label,
                  style: AppTextStyle.bodyText2.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              if (widget.isCompulsory) const SizedBox(width: 5),
              if (widget.isCompulsory)
                Text(
                  "*",
                  style: AppTextStyle.bodyText2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              if (widget.isReferral && widget.showInfo)
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            showText = !showText;
                          });
                        },
                        child: Image.asset(
                          'assets/images/info.png',
                          width: Get.width * 0.04,
                          height: Get.width * 0.04,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                    ]))
            ],
          ),
        ),
        const SizedBox(height: 5),
        if (widget.isPhoneNumber && !showText)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: PageDropButton(
                  label: "",
                  hint: '',
                  onChanged: (val) {
                    if (widget.onDropdownChanged != null) {
                      widget.onDropdownChanged!(val);
                    }
                  },
                  value: countries.firstWhere(
                      (element) => element.name.toLowerCase() == 'nigeria'),
                  items:
                      countries.map<DropdownMenuItem<Country>>((Country value) {
                    return DropdownMenuItem<Country>(
                      value: value,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(value.flag),
                            Text("+${value.countryCode}"),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: Get.width * 0.7,
                child: AppInput(
                  hintText: widget.hint,
                  keyboardType: widget.keyboardType,
                  controller: widget.controller,
                  validator: widget.validator,
                  obscureText: widget.obscureText,
                  autovalidateMode: widget.autovalidateMode,
                  readOnly: widget.readOnly,
                  prefexIcon: widget.prefix,
                  suffixIcon: widget.suffix,
                  borderSide: widget.borderSide,
                ),
              ),
            ],
          ),
        if ((!widget.isPhoneNumber && !showText) || widget.obscureText)
          DisabledAppInput(
            initalValue: widget.initialValue,
            hintText: !widget.isFilePicker
                ? widget.hint
                : 'Click to open file picker',
            maxLines: widget.isTextArea ? 5 : 1,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.obscureText,
            autovalidateMode: widget.autovalidateMode,
            borderSide: widget.borderSide,
            readOnly: widget.readOnly || widget.isFilePicker,
            prefexIcon: !widget.isFilePicker
                ? widget.prefix
                : InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path.toString());
                        if (widget.controller != null) {
                          widget.controller!.text = file.path.split('/').last;
                        }
                        if (widget.onFilePicked != null) {
                          widget.onFilePicked!(file);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        width: Get.width * 0.25,
                        child: Center(
                          child: Text(
                            'Choose file',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodyText2.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            suffixIcon: widget.suffix,
          ),
        const SizedBox(
          height: 5,
        ),
        if (showText && widget.showInfo)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffEAF3FB),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xffEAF3FB)),
            ),
            child: Padding(
              padding: EdgeInsets.all(Get.width * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/info.png',
                    width: Get.width * 0.04,
                    height: Get.width * 0.04,
                    color: Colors.black,
                  ),
                  SizedBox(width: Get.width * 0.02),
                  Expanded(
                    child: Text(
                      widget.isReferral
                          ? 'Please, only enter the referral. Leave empty if you don\'t have a referral code.'
                          : 'The password must contain minimum of 8 characters, uppercase character and a unique character',
                      style: AppTextStyle.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: Get.width > 600
                            ? Get.width * 0.025
                            : Get.width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
