import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar(
      {Key? key,
      this.imgUrl = '',
      this.selectedImg,
      this.radius = 55,
      this.backgroundColor = const Color(0xffEEF5FE),
      required this.name})
      : super(key: key);

  final String imgUrl;
  final String? selectedImg;
  final double radius;
  final String name;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius,
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius * 2),
          child: selectedImg == null
              ? CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Text(
                        name.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: radius * 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                  width: radius * 2,
                )
              : Image.file(
                  File(selectedImg!),
                  fit: BoxFit.cover,
                  height: radius * 2,
                  width: radius * 2,
                ),
        ),
      ),
    );
  }
}
