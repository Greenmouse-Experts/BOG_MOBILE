import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../global_widgets.dart';

class SimpleFile extends StatefulWidget {
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;

  const SimpleFile(
      {super.key,
      required this.item,
      required this.onChange,
      required this.position,
      this.errorMessages = const {},
      this.validations = const {},
      this.decorations = const {},
      this.keyboardTypes = const {}});

  @override
  State<SimpleFile> createState() => _SimpleFileState();
}

class _SimpleFileState extends State<SimpleFile> {
  dynamic item;
  File? pickedFile;
  TextEditingController fileController = TextEditingController();

  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return PageInput(
      hint: 'Pick a text',
      label: item['label'],
      boldLabel: true,
      isFilePicker: true,
      controller: fileController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please pick a picture to upload";
        }
        return null;
      },
      onFilePicked: (file) async {
        pickedFile = file;

        var body = {
          "image": [
            await MultipartFile.fromFile(
              pickedFile!.path,
              filename: pickedFile!.path.split('/').last,
            )
          ],
        };
        final formData = FormData.fromMap(body);

        final response = await dio.post(
            'https://bog.greenmouseproperties.com/upload',
            data: formData);

        if (response.statusCode == 200) {
          widget.onChange(widget.position, response.data[0]);
        } else {}
        pickedFile = file;
      },
    );
  }
}
