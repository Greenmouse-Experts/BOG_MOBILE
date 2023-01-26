import 'dart:convert';
import 'package:bog/app/data/providers/my_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/network_utils.dart';
import 'package:bog/app/base/base.dart';



Future<LoadingResult> performApiCall(BuildContext context, String path,
    Function(dynamic response, String? error) onComplete,
    {Map<String, dynamic>? data,
    bool getMethod = false,
    String progressMessage = "",
    bool silently = false,
    bool handleError = true}) async {

  printOut("Ready..");
  if (!silently) {
    showLoading(message: progressMessage);
  }

  // if (!(await isConnected())) {
  //   if (!silently) {
  //     hideLoading();
  //   }
  //   await Future.delayed(const Duration(milliseconds: 600));
  //   onComplete(null, NO_INTERNET);
  //   return LoadingResult(null, NO_INTERNET);
  // }

  String url = "$baseUrl$path";
  printOut("Url: $url");

  String? payload;
  if (data != null) {
    payload = jsonEncode(data);
  }
  if (getMethod && payload != null) {
    url = "$url?payload=$payload";
  }


  Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": 'Bearer ${MyPref.authToken.val}',
  };

  printOut("Requesting >> $url $payload");
  try {
    var response = !getMethod
        ? (await http.post(
            Uri.parse(url),
            body: payload,
            headers: header,
          ))
        : await (http.get(
            Uri.parse(url),
            headers: header,
          ));

    if (!silently) {
      hideLoading();
      await Future.delayed(const Duration(milliseconds: 600));
    }

    printOut("response>>: ${response.body} <<");

    // {"status":false,"message":"Validation Error","error":
    // {"username":["The username has already been taken."],"phone":["The phone has already been taken."]}}

    Map res = jsonDecode(response.body);
    bool success = res["status"] ?? false;

    String errorMessage = "";
    Map errorMap = res["error"]??{};
    for(var items in errorMap.entries){
      dynamic values = items.value;
      if(values is String)errorMessage=values;
      if(values is List)errorMessage = values[0];
      break;
    }
    String message = errorMessage.isNotEmpty?errorMessage: res["message"] ??"";

    // if (message.contains("Token Expired")) {
    //   PushScreenUtils.popToMain();
    //   await Future.delayed(const Duration(milliseconds: 600));
    //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
    //   //   return PushScreenUtils.pushScreen();
    //   // }));
    // }

    if (!success) {
      if(handleError) {
        showErrorDialog(context, message);
      }else{
        onComplete(null, message);
      }
      return LoadingResult(null, message);
    } else {
      var result = res; //['data'];
      onComplete(result, null);
      return LoadingResult(result, null);
    }
  } catch (e) {
    printOut("Got error: $e");
    if (!silently) hideLoading();
    if(handleError){
      showErrorDialog(context, e.toString());
    }else{
      onComplete(null, e.toString());
    }
    return LoadingResult(null, e.toString());
  }
}

class LoadingResult {
  dynamic response;
  String? error;

  LoadingResult(this.response, this.error);
}
