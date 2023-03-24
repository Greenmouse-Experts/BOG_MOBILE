


import 'package:bog/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  final String path;
  const PdfViewerPage({Key? key,required this.path}) : super(key: key);

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

 
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter PDF Viewer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
       body: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary,))
          : SizedBox(
              child: Center(
                child: PDFView(
                  filePath: pFile!.path,
                ),
              ),
            ),
    );
  }
}
