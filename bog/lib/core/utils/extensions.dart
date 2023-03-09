// This file defines helper methods by using extension on specific dart/flutter classes eg:

import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get gif => "assets/images/$this.gif";
  String get png => "assets/images/$this.png";
  String get svg => "assets/images/$this.svg";
  String get jpg => "assets/images/$this.jpg";
  String get json => "assets/images/$this.json";
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : this;
  String get allInCaps => toUpperCase();
  String get titleCase => split(' ').map((str) => str.capitalize).join(' ');
  int get toHexColor =>
      int.parse("FF" + this.toUpperCase().replaceAll("#", ""), radix: 16);

  // Text asText(bool bold, num fontSize, Color color,{FontWeight? weight}) {
  //   return Text(
  //     this,
  //     style: TextStyle(
  //       fontSize: fontSize.toDouble(),
  //       fontWeight: weight ?? (bold ? FontWeight.bold : FontWeight.normal),
  //       color: color,
  //     ),
  //   );
  }

  // TextSpan asTextSpan(bool bold, num fontSize, Color color,{FontWeight? weight}) {
  //   return TextSpan(
  //     text: this,
  //     style: TextStyle(
  //       fontSize: fontSize.toDouble(),
  //       fontWeight: weight ?? (bold ? FontWeight.bold : FontWeight.normal),
  //       color: color,
  //     ),
  //   );
  // }

  // RichText asRichText(bool bold, num fontSize, Color color, {FontWeight? weight}) {
  //   return RichText(
  //       text: TextSpan(
  //     text: this,
  //     style: TextStyle(
  //       fontSize: fontSize.toDouble(),
  //       fontWeight: weight ?? (bold ? FontWeight.bold : FontWeight.normal),
  //       color: color,
  //     ),
  //   ));
  // }


extension InkWellExtensions on InkWell {
  InkWell get noShadow => InkWell(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: child,
      );
}
