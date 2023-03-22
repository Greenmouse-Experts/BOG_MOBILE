import 'dart:io';

import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

import '../../data/providers/api.dart';

// import 'helpers/function.dart';

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
  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    // Widget label = const SizedBox.shrink();
    // if (Fun.labelHidden(item)) {
    //   label = SizedBox(
    //     child: Text(
    //       item['label'],
    //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
    //     ),
    //   );
    // }
    return PageInput(
      hint: 'Pick a text',
      label: item['label'],
      isFilePicker: true,
      controller: fileController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please pick a picture to upload";
        }
        return null;
      },
      onFilePicked: (file) async {
        var body = {
          "image": await dio.MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last),
        };
        final formData = dio.FormData.fromMap(body);
        final response =
            await Api().uploadData('/upload', body: formData, hasHeader: true);
        if (response.isSuccessful) {
          widget.onChange(widget.position, response.data[0]);
        }
        pickedFile = file;
      },
    );
  }
}
