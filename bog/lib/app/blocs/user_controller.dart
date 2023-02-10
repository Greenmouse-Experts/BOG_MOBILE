import 'dart:async';
import 'dart:convert';
import 'package:bog/app/data/model/log_in_model.dart';
import 'package:bog/app/data/providers/my_pref.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Please make sure you add this to your get_it instance

class UserController {

  static UserController get instance => Get.find();//getIt<UserController>();

  final StreamController<bool> _streamController = StreamController.broadcast();

  Stream<bool> get stream => _streamController.stream;

  LogInModel get currentUser => LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
  Map get currentUserMap => LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val)).toJson();
  Map get currentUserProfile => currentUserMap==null?{}:currentUserMap["profile"];

  void refreshUser(BuildContext context,){
    performApiCall(context, "/user/me", (response, error){
      if(error!=null){
        return;
      }
      Map user = response["user"]??{};
      MyPref.logInDetail.val = jsonEncode(user);
      _streamController.add(true);
    },silently: true,getMethod: true,handleError: false);
  }


 }