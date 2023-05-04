import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'new_app_bar.dart';

class PhotoViewPage extends StatelessWidget {
  final String url;
  const PhotoViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: newAppBarBack(context, 'View Document'),
        body: SizedBox(
          child: PhotoView(imageProvider: NetworkImage(url)),
        ));
  }
}
