import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../popup_widget.dart';

//TODO: Please make sure you add this to your get_it instance

class PopupController {

  static PopupController get instance => Get.find();//getIt<PopupController>();

  final StreamController<PopupModel> _streamController = StreamController.broadcast();

  Stream<PopupModel> get stream => _streamController.stream;

  void showPopup({required String message,IconData? icon}){

    _streamController.add(PopupModel(message: message,icon: icon,popupType: PopupType.normal));

  }

  void showErrorPopup({required String message}){

    _streamController.add(PopupModel(message: message,icon: Icons.info_outline,popupType: PopupType.error));

  }


 }