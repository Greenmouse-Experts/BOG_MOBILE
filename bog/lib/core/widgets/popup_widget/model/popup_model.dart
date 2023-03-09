import 'package:flutter/material.dart';
import '../popup_widget.dart';

class PopupModel{

  final IconData? icon;
  final String message;
  final PopupType popupType;

  PopupModel({
    this.icon, required this.message, this.popupType=PopupType.normal
});
}