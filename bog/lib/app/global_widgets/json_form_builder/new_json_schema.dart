import 'dart:convert';
import 'dart:io';

import 'package:bog/app/global_widgets/json_form_builder/simple_file.dart';
import 'package:bog/app/global_widgets/json_form_builder/simple_forms/simple_header.dart';
import 'package:flutter/material.dart';

// import '../app_button.dart';
import '../../data/providers/api.dart';
import './simple_forms/simple_text.dart';
// import './simple_forms/simple_checkbox.dart';
import './simple_forms/simple_radios.dart';
// import './simple_forms/simple_select.dart';
import './simple_forms/simple_date.dart';
import 'simple_forms/simple_checkbox.dart';
import 'simple_forms/simple_select.dart';
import 'package:dio/dio.dart' as dio;

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
  List<File> fileValues = [];
  List<int> filePosition = [];
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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ));
    }

    for (var count = 0; count < formGeneral['formData'].length; count++) {
      Map item = formGeneral['formData'][count];
      Map answer = formAnswer['form'][count];

      // print(widget.formResponse);
      // print(formAnswer);
      // print('akos');

      if (item['inputType'] == "header") {
        listWidget.add(SimpleHeader(
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
        print(answer);
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleRadio(
            item: item,
            answer: answer,
            onChange: onChange,
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
            onChange: onChangeFile,
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
              print('object');
              print('working');
              if (_formKey.currentState!.validate()) {
                // if (fileValues.isNotEmpty) {
                //   print('objecdsfrt');
                //   for (int i = 0; i < fileValues.length; i++) {
                //     final pickedFile = fileValues[i];
                //     final image = pickedFile;
                //     var body = {
                //       "image": [
                //         await dio.MultipartFile.fromFile(pickedFile.path,
                //             filename: pickedFile.path.split('/').last),
                //       ],
                //     };

                //     final formData = dio.FormData.fromMap(body);

                //     print('balablu');
                //     final response = await Api()
                //         .uploadData('/upload', body: formData, hasHeader: true);
                //     print('dj');
                //     if (response.isSuccessful) {
                //       // formAnswer['form'][filePosition[i]]['value'] =
                //       //     response.data[0];
                //     } else {
                //       print(response.message);
                //     }
                //   }
                // }
                widget.actionSave(formAnswer);
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

  void onChange(int position, dynamic value) {
    setState(() {
      formAnswer['form'][position]['value'] = value;
      // print(value);
      _handleChanged();
    });
  }

  void onChangeFile(int position, File value) {
    setState(() {
      formAnswer['form'][position]['value'] = value;
      fileValues.add(value);
      filePosition.add(position);
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