import 'dart:convert';
import 'package:bog/app/global_widgets/json_form_builder/simple_file.dart';
import 'package:flutter/material.dart';

import './simple_forms/simple_text.dart';
import './simple_forms/simple_checkbox.dart';
import './simple_forms/simple_radios.dart';
// import './simple_forms/simple_select.dart';
import './simple_forms/simple_date.dart';
import 'simple_forms/simple_text_area.dart';

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
  });

  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;
  final String? form;
  final Map? formMap;
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

  late int radioValue;
  _CoreFormState(this.formGeneral);

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

      if (item['inputType'] == "text" ||
          item['inputType'] == "button" ||
          item['inputType'] == "number" ||
          item['inputType'] == "TextInput") {
        listWidget.add(SimpleText(
          item: item,
          onChange: onChange,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      if ( item['inputType'] == "textarea" ){
        listWidget.add(SimpleTextArea(item: item, onChange: onChange, position: count));
      }

      if (item['inputType'] == "radio-group") {
        listWidget.add(SimpleRadios(
          item: item,
          onChange: onChangeRadio,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      if (item['inputType'] == "file") {
        listWidget.add(SimpleFile(
          item: item,
          onChange: onChangeRadio,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
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
        listWidget.add(SimpleListCheckbox(
          item: item,
          onChange: onChange,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      // if (item['inputType'] == "select") {
      //   listWidget.add(SimpleSelect(
      //     item: item,
      //     onChange: onChange,
      //     position: count,
      //     decorations: widget.decorations,
      //     errorMessages: widget.errorMessages,
      //     validations: widget.validations,
      //     keyboardTypes: widget.keyboardTypes,
      //   ));
      // }

      if (item['inputType'] == "date") {
        listWidget.add(SimpleDate(
          item: item,
          onChange: onChangeDate,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
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
    widget.onChanged(formGeneral);
  }

  void onChange(int position, dynamic value) {
    setState(() {
      formGeneral['fields'][position]['value'] = value;
      _handleChanged();
    });
  }

  void onChangeRadio(int position, dynamic value) {
    setState(() {
      formGeneral['formData'][position]['placeholder'] = value;
      _handleChanged();
    });
  }

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
          children: jsonToForm(),
        ),
      ),
    );
  }
}
