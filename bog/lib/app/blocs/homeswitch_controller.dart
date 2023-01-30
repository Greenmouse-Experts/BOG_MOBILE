import 'dart:async';
import 'package:bog/core/utils/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Please make sure you add this to your get_it instance

class HomeSwitchController {

  static HomeSwitchController get instance => Get.find();//getIt<HomeSwitchController>();

  final StreamController<bool> _streamController = StreamController.broadcast();

  Stream<bool> get stream => _streamController.stream;

  void clickSwitch(BuildContext context){
    if(accountTypes.isEmpty) {
      loadTypes(context);
    }else{
      _streamController.add(true);
    }
  }

  List accountTypes = [];

  void loadTypes(BuildContext context){
    performApiCall(context, "/user/get-accounts", (response, error){
      if(error!=null){
        return;
      }
      accountTypes = response["accounts"]??[];
      if(accountTypes.isNotEmpty)clickSwitch(context);
    },silently: false,getMethod: true);
  }
 }