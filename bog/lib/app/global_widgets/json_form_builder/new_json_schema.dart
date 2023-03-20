import 'dart:convert';
import 'package:bog/app/global_widgets/json_form_builder/simple_file.dart';
import 'package:flutter/material.dart';

import '../app_button.dart';
import './simple_forms/simple_text.dart';
// import './simple_forms/simple_checkbox.dart';
import './simple_forms/simple_radios.dart';
// import './simple_forms/simple_select.dart';
import './simple_forms/simple_date.dart';
import 'simple_forms/simple_checkbox.dart';
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
    this.buttonSave,
    this.actionSave,
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
  final Widget? buttonSave;
  final Function? actionSave;
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
  _CoreFormState(this.formGeneral);

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
    // if (formGeneral['serviceType'] != null) {
    //   listWidget.add(Text(
    //     formGeneral['serviceType']['title'],
    //     style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    //   ));
    // }

    for (var count = 0; count < formGeneral['formData'].length; count++) {
      Map item = formGeneral['formData'][count];
      final answer = formAnswer['form'][count];

      // print(widget.formResponse);
      // print(formAnswer);
      // print('akos');
      if (item['inputType'] == "text" ||
          item['inputType'] == "button" ||
          item['inputType'] == "number" ||
          item['inputType'] == "paragraph" ||
          item['inputType'] == 'textarea' ||
          item['inputType'] == "header") {
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

      // if (item['inputType'] == "textarea") {
      //   listWidget.add(Padding(
      //     padding: const EdgeInsets.all(4),
      //     child:
      //         SimpleTextArea(item: item, onChange: onChange, position: count),
      //   ));
      // }

      if (item['inputType'] == "radio-group") {
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
            onChange: onChange,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }

      // if (item['type'] == "Switch") {
      //   listWidget.add(SimpleSwitch(
      //     item: item,
      //     onChange: onChange,
      //     position: count,
      //     decorations: widget.decorations,
      //     errorMessages: widget.errorMessages,
      //     validations: widget.validations,
      //     keyboardTypes: widget.keyboardTypes,
      //   ));
      // }

      if (item['inputType'] == "checkbox-group") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleListCheckbox(
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

      if (item['inputType'] == "select") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleSelects(
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

      if (item['inputType'] == "date") {
        listWidget.add(Padding(
          padding: const EdgeInsets.all(4),
          child: SimpleDate(
            item: item,
            onChange: onChangeDate,
            position: count,
            decorations: widget.decorations,
            errorMessages: widget.errorMessages,
            validations: widget.validations,
            keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }
    }

    if (widget.buttonSave != null && widget.actionSave != null) {
      listWidget.add(Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              widget.actionSave!(formGeneral);
            }
          },
          child: widget.buttonSave,
        ),
      ));
    }

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

  // void onChangeRadio(int position, dynamic value) {
  //   setState(() {
  //     formAnswer['form'][position]['value'] = value;
  //     _handleChanged();
  //   });
  // }

  void onChangeDate(int position, dynamic value) {
    setState(() {
      formGeneral['formData'][position]['value'] = value;
      _handleChanged();
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode:
          formGeneral['autoValidated'] ?? AutovalidateMode.disabled,
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(widget.padding ?? 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: jsonToForm(),
            ),
            const AppButton(
              title: 'Submit',
            )
          ],
        ),
      ),
    );
  }
}
