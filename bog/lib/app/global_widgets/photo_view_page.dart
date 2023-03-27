

import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String url;
  const PhotoViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBarBack(context, 'View Document'),
      body: SizedBox(
        child: PhotoView(imageProvider: NetworkImage(url)),
      )
    );
  }
}