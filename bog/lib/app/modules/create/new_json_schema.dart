library json_to_form;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_to_form/components/index.dart';

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
  _CoreFormState createState() => _CoreFormState(formMap ?? json.decode(form!));
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
    // if (formGeneral['description'] != null) {
    //   listWidget.add(Text(
    //     formGeneral['description'],
    //     style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    //   ));
    // }
    if (formGeneral['serviceType'] != null) {
      listWidget.add(Text(
        formGeneral['serviceType']['title'],
        style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      ));
    }

    final formData = formGeneral['formData'] as List<dynamic>;

    for (var count = 0; count < formData.length; count++) {
      Map item = formGeneral['formData'][count];

      if (item['inputType'] == "text" ||
          //  item['inputType'] == "autocomplete" ||
          // item['inputType'] == "checkbox-group" ||
          // item['inputType'] == "date" ||
          item['inputType'] == "number" ||
          item['inputType'] == "button") {
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

      if (item['inputType'] == "radio-group") {
        listWidget.add(SimpleRadios(
          item: item,
          onChange: onChange,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      if (item['inputType'] == "Switch") {
        listWidget.add(SimpleSwitch(
          item: item,
          onChange: onChange,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

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

      if (item['inputType'] == "Select") {
        listWidget.add(SimpleSelect(
          item: item,
          onChange: onChange,
          position: count,
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          // validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      if (item['inputType'] == "date") {
        listWidget.add(SimpleDate(
          item: item,
          onChange: onChange,
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
