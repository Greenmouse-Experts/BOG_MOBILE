import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Please make sure you add this to your get_it instance

class TriggerModeController {

  static TriggerModeController get instance => Get.find();//getIt<TriggerModeController>();

  final StreamController<bool> _streamController = StreamController.broadcast();

  Stream<bool> get stream => _streamController.stream;

  void trigger(){
     _streamController.add(true);
  }
 }