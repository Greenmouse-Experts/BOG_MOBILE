import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Please make sure you add this to your get_it instance

class ModeController {

  bool darkMode = false;

  static ModeController get instance => Get.find();//getIt<ModeController>();

  final StreamController<bool> _streamController = StreamController.broadcast();

  Stream<bool> get stream => _streamController.stream;

  void switchMode(){
     darkMode = !darkMode;
     _streamController.add(darkMode);
  }
 }