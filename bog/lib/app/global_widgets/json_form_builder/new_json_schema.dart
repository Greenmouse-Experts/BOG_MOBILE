import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../overlays.dart';
import './simple_forms/simple_text.dart';

import './simple_forms/simple_radios.dart';

import './simple_forms/simple_date.dart';
import 'simple_file.dart';
import 'simple_forms/simple_checkbox.dart';
import 'simple_forms/simple_header.dart';
import 'simple_forms/simple_select.dart';

class NewJsonSchema extends StatefulWidget {
  const NewJsonSchema({
    super.key,
    this.form,
    required this.onChanged,
    this.padding,
    this.formMap,
    this.autovalidateMode,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
    required this.buttonSave,
    required this.actionSave,
    required this.formResponse,
  });

  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;
  final String? form;
  final Map? formMap;
  final Map formResponse;
  final double? padding;
  final Widget buttonSave;
  final Function actionSave;
  final ValueChanged<dynamic> onChanged;
  final AutovalidateMode? autovalidateMode;

  @override
  State<NewJsonSchema> createState() =>
      _CoreFormState(formMap ?? json.decode(form!));
}

class _CoreFormState extends State<NewJsonSchema> {
  final dynamic formGeneral;
  late dynamic formAnswer;
  late int radioValue;

  List<int> headerInts = [];

  _CoreFormState(this.formGeneral);
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    formAnswer = widget.formResponse;
    super.initState();
  }

  List<Widget> jsonToForm() {
    List<Widget> listWidget = [];
    if (formGeneral['formTitle'] != null) {
      listWidget.add(Text(
        formGeneral['formTitle'],
        style: AppTextStyle.bodyText2.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ));
    }

    for (var count = 0; count < formGeneral['formData'].length; count++) {
      Map item = formGeneral['formData'][count];
      Map answer = formAnswer['form'][count];

      if (item['inputType'] == "header") {
        //formAnswer['form'].remove([count]);
        headerInts.add(count);
        listWidget.add(SimpleHeader(
          position: count,
          onChange: onChange,
          item: item,
        ));
      }
      if (item['inputType'] == "text" ||
          item['inputType'] == "button" ||
          item['inputType'] == "number" ||
          item['inputType'] == "paragraph" ||
          item['inputType'] == 'textarea') {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleTexts(
            answer: answer,
            item: item,
            onChange: onChange,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }

      if (item['inputType'] == "radio-group") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleRadio(
            item: item,
            answer: answer,
            onChange: onChangeOthers,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }

      if (item['inputType'] == "file") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleFile(
            item: item,
            onChange: onChange,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }

      if (item['inputType'] == "checkbox-group") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleListCheckbox(
            answer: answer,
            item: item,
            onChange: onChangeOthers,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }

      if (item['inputType'] == "select") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleSelects(
            answer: answer,
            item: item,
            onChange: onChangeOthers,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }

      if (item['inputType'] == "date") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleDate(
            item: item,
            onChange: onChange,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }
    }

    listWidget.add(Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final controller = Get.find<HomeController>();
              final userType = controller.currentType == 'Client'
                  ? 'private_client'
                  : 'corporate_client';

              widget.actionSave(formAnswer);

              if (_formKey.currentState!.validate()) {
                AppOverlay.loadingOverlay(asyncFunction: () async {
                  await Future.delayed(const Duration(seconds: 3));
                  final controller = Get.find<HomeController>();

                  final jsonString = jsonEncode(formAnswer);
                  final jsonMap = jsonDecode(jsonString);
                  List<dynamic> filteredForm =
                      jsonMap["form"].where((formValue) {
                    return formValue["_id"] != 0 && formValue["value"] != "val";
                  }).toList();
                  Map<String, dynamic> newJsonMap = {
                    "form": filteredForm,
                    "userType": userType
                  };
                  final response = await controller.userRepo
                      .postData('/projects/request', newJsonMap);

                  if (response.isSuccessful) {
                    Get.back();
                    Get.snackbar('Form Posted Successfully', '',
                        backgroundColor: Colors.green,
                        colorText: AppColors.background);
                  } else {
                    Get.snackbar('Error occured', 'An error occurred',
                        backgroundColor: Colors.red,
                        colorText: AppColors.background);
                  }
                });
              } else {
                Get.snackbar(
                    'Incomplete Form', 'Complete form before submitiing',
                    backgroundColor: Colors.red,
                    colorText: AppColors.background);
              }
            },
            child: widget.buttonSave,
          ),
        ],
      ),
    ));

    return listWidget;
  }

  void _handleChanged() {
    widget.onChanged(formAnswer);
  }

  void onChange(int position, dynamic value) async {
    setState(() {
      formAnswer['form'][position]['value'] = value;
      // print(value);
      _handleChanged();
    });
  }

  void onChangeOthers(int position, dynamic value, dynamic id) {
    setState(() {
      formAnswer['form'][position]['value'] = value;
      formAnswer['form'][position]['_id'] = id;
      //   print(formAnswer);
      _handleChanged();
    });
  }

  void onChangeDate(int position, dynamic value) {
    setState(() {
      formGeneral['formData'][position]['value'] = value;
      _handleChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: widget.autovalidateMode,
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(widget.padding ?? 8.0),
        child: Column(
          children: jsonToForm(),
        ),
      ),
    );
  }
}
 // final newForm = {
                    //   image: [
                    //     await dio.MultipartFile.fromFile(pickedFile.path,
                    //         filename: pickedFile.path.split('/').last),
                    //   ],
                    // };
                    //  final omoo = dio.FormData(

                    // );
                    // final newFile = dio.FormData({
                    //   MapEntry(pickedFile,
                    //       dio.MultipartFile.fromFileSync(pickedFile.path)),
                    // } );
                    //  print(formData.toString());