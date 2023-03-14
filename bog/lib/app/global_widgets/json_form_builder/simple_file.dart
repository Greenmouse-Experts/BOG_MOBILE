import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:flutter/material.dart';

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
    return const PageInput(
      hint: 'Pick a text',
      label: 'Choose a file',
      isFilePicker: true,
    );
  }
}
