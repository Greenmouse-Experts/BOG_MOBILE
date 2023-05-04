import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/theme/theme.dart';
import 'new_app_bar.dart';

class PdfViewerPage extends StatefulWidget {
  final String path;
  const PdfViewerPage({Key? key, required this.path}) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  File? pFile;
  bool isLoading = false;
  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url = widget.path;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      pFile = file;
    });

    await OpenFilex.open(file.path);
    setState(() {
      isLoading = false;
    });
    Get.back();
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBarBack(context, 'View Document'),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.primary,
            ))
          : const SizedBox(
              child: Center(),
            ),
    );
  }
}
