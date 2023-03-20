import 'dart:convert';

import 'package:bog/app/data/model/gen_kyc.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';

import '../data/model/log_in_model.dart';
import '../data/providers/api.dart';
import '../data/providers/api_response.dart';
import '../data/providers/my_pref.dart';

class UserRepository {
  final Api api;

  UserRepository(this.api);

  Future<ApiResponse> signup(dynamic body) async {
    final response = await api.postData('/user/signup', body: body);
    return response;
  }

  Future<ApiResponse> signIn(dynamic body) async {
    final response = await api.postData('/user/login', body: body);
    return response;
  }

  Future<ApiResponse> forgotPassword(String email) async {
    final response = await api.getData('/user/forgot-password?email=$email');
    return response;
  }

  Future<ApiResponse> verifyOTPForSignUp(String email, String token) async {
    final response =
        await api.getData('/user/verify?email=$email&token=$token');
    return response;
  }

  Future<ApiResponse> getBanks() async {
    final response = await api.getData('/bank/allbanks');
    return response;
  }

  Future<ApiResponse> postKYCData(String url, dynamic body,
      {hasHeader = true}) async {
    final response = await api.postData(url, hasHeader: hasHeader, body: body);
    return response;
  }

 

  Future<ApiResponse> postData(String url, dynamic body,
      {hasHeader = true}) async {
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    var type = logInDetails.userType;

    if (type == 'vendor' || type == 'professional') {
      var genKyc = GenKyc.fromJson(jsonDecode(MyPref.genKyc.val));
      if (genKyc.isKycCompleted == true) {
        AppOverlay.showKycDialog(
          title: 'Kyc Not Complete',
          buttonText: 'Complete KYC',
          content:
              "You haven't completed your KYC yet, Kindly Complete your KYC now",
        );
        return ApiResponse(isSuccessful: false);
        // final response =
        //     await api.postData(url, hasHeader: hasHeader, body: 'body');
        // return response;
      } else {
        final response =
            await api.postData(url, hasHeader: hasHeader, body: body);
        return response;
      }
    } else {
      final response =
          await api.postData(url, hasHeader: hasHeader, body: body);
      return response;
    }
  }

  Future<ApiResponse> getData(String url, {hasHeader = true}) async {
    final response = await api.getData(url, hasHeader: hasHeader);
    print('object');
    print(response.message);
    return response;
  }

   Future<ApiResponse> deleteData(String url,
      {hasHeader = true})async{
        final response = await api.deleteData(url, hasHeader: hasHeader);
        return response;
      }

  Future<ApiResponse> putData(String url, dynamic body,
      {hasHeader = true, sso = true}) async {
    final response = await api.putData(url, hasHeader: hasHeader, body: body);
    return response;
  }

  Future<ApiResponse> patchData(String url, dynamic body,
      {hasHeader = true, sso = true}) async {
    final response = await api.patchData(url, hasHeader: hasHeader, body: body);
    return response;
  }
}
