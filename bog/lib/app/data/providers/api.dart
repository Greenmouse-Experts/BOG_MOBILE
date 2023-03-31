import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'api_response.dart';
import 'my_pref.dart';

class Api {
  static const publicKey = 'pk_test_0c79398dba746ce329d163885dd3fe5bc7e1f243';
  static const String baseUrl = 'https://bog.greenmouseproperties.com/api';
  static const String uploadUrl = 'https://bog.greenmouseproperties.com';

  static const String imgUrl = 'http://imgURl';
  CancelToken token = CancelToken();

  final Dio _client = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    receiveTimeout: 10000,
  ));

  final Dio _uploadClient = Dio(BaseOptions(
    baseUrl: uploadUrl,
    headers: {
      'Content-Type': 'multipart/form-data',
    },
    receiveTimeout: 10000,
  ));

  Future<ApiResponse> postData(
    String url, {
    bool hasHeader = false,
    body,
  }) async {
    token = CancelToken();
    try {
      var head = {
        'Authorization': MyPref.authToken.val,
      };
      var request = await _client.request(
        url,
        data: body,
        cancelToken: token,
        options: Options(method: 'POST', headers: hasHeader ? head : null),
      );

      return ApiResponse.response(request);
    } on DioError catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> uploadData(
    String url, {
   
    body,
  }) async {
    token = CancelToken();
    try {
      // var head = {
      //   'Authorization': MyPref.authToken.val,
      // };
      var request = await _uploadClient.request(
        url,
        data: body,
        cancelToken: token,
        options: Options(method: 'POST', headers:  null),
      );

      return ApiResponse.response(request);
    } on DioError catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> deleteData(
    String url, {
    bool hasHeader = false,
  }) async {
    token = CancelToken();
    var head = {
      'Authorization': MyPref.authToken.val,
    };
    try {
      var request = await _client.request(
        url,
        cancelToken: token,
        options: Options(method: 'DELETE', headers: hasHeader ? head : null),
      );
      return ApiResponse.response(request);
    } on DioError catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> putData(
    String url, {
    bool hasHeader = false,
    body,
  }) async {
    token = CancelToken();
    var head = {
      'Authorization': MyPref.authToken.val,
    };
    try {
      var request = await _client.request(
        url,
        data: body,
        cancelToken: token,
        options: Options(method: 'PUT', headers: hasHeader ? head : null),
      );

      return ApiResponse.response(request);
    } on DioError catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResponse> patchData(
    String url, {
    bool hasHeader = false,
    body,
  }) async {
    token = CancelToken();
    var head = {
      'Authorization': MyPref.authToken.val,
    };
   
    try {
      var request = await _client.request(
        url,
        data: body,
        cancelToken: token,
        options: Options(method: 'PATCH', headers: hasHeader ? head : null),
      );

      return ApiResponse.response(request);
    } on DioError catch (e) {
      return e.toApiError(cancelToken: token);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on Exception catch (e) {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }

  /* Future<ApiResponse> _sendRequest(request, bool hasHeader,
      {Map<String, String>? body,
      Iterable<Future<MultipartFile>>? files}) async {
    if (body != null) {
      request.fields.addAll(body);
    }
    if (files != null) {
      for (var element in files) {
        request.files.add(await element);
      }
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send().timeout(
          const Duration(seconds: 15),
        );

    return await _response(response);
  } */

  Future<ApiResponse> getData(String url, {bool hasHeader = false}) async {
    token = CancelToken();
    try {
      /*var request = await _client.request(
        url,
        cancelToken: token,
        options: Options(method: 'GET', headers: hasHeader ? headers : null),
      );*/

      var head = {
        'Authorization': MyPref.authToken.val,
      };
      var response = await http.get(Uri.parse(baseUrl + url),
          headers: hasHeader ? head : null);
      return ApiResponse.responseFromBody(response.body, response.statusCode);
      //return ApiResponse.response(request);
    } on DioError catch (e) {
    
      return e.toApiError(cancelToken: token);
    } on SocketException {
 
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on Exception catch (e) {
   
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: e.toString(),
      );
    }
  }
}

abstract class AppRepo {
  final Api helper = Api();
}
