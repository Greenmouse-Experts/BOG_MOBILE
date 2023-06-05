import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

enum ApiStatus {
  success,
  failure,
}

class HttpApiResponse {
  final int? code;
  dynamic data;
  dynamic projects;
  dynamic order;
  dynamic accounts;
  dynamic user;
  dynamic status;
  final bool isSuccessful;
  String? message;
  String? token;

  HttpApiResponse(
      {this.code,
      this.message,
      this.data,
      this.order,
      this.accounts,
      this.projects,
      this.status,
      required this.isSuccessful,
      this.token,
      this.user});

  static HttpApiResponse response(http.Response response) {
    var json = jsonDecode(response.body);

    return HttpApiResponse(
        message: json['message'],
        isSuccessful: json['success'] ?? false,
        data: json['data'],
        projects: json['projects'],
        user: json['user'],
        token: json['token'],
        status: json['status'],
        accounts: json['accounts'],
        order: json['order']);
  }

  static HttpApiResponse responseFromBody(String json, int isSuccessful) {
    var jsonD = jsonDecode(json);

    return HttpApiResponse(
        message: jsonD['message'],
        isSuccessful: jsonD['success'] ?? false,
        data: jsonD['data'],
        projects: jsonD['projects'],
        user: jsonD['user'],
        status: jsonD['status'],
        token: jsonD['token'],
        accounts: jsonD['accounts'],
        order: jsonD['order']);
  }

  factory HttpApiResponse.timout(Response response) {
    return HttpApiResponse(
      data: null,
      isSuccessful: false,
      message: 'An Error occurred. Please try again',
    );
  }
}

class ApiResponse {
  final int? code;
  dynamic data;
  dynamic projects;
  dynamic order;
  dynamic accounts;
  dynamic user;
  dynamic status;
  dynamic reviews;
  final bool isSuccessful;
  String? message;
  String? token;

  ApiResponse(
      {this.code,
      this.message,
      this.data,
      this.order,
      this.accounts,
      this.projects,
      this.status,
      this.reviews,
      required this.isSuccessful,
      this.token,
      this.user});

  static ApiResponse response(Response response) {
    var json = response.data;

    return ApiResponse(
        message: json['message'],
        reviews: json['reviews'],
        isSuccessful: json['success'] ?? false,
        data: json['data'],
        projects: json['projects'],
        user: json['user'],
        token: json['token'],
        status: json['status'],
        accounts: json['accounts'],
        order: json['order']);
  }

  static ApiResponse responseFromBody(String json, int isSuccessful) {
    var jsonD = jsonDecode(json);
    //print(jsonD['status']);
    return ApiResponse(
        message: jsonD['message'],
        isSuccessful: jsonD['success'] ?? false,
        data: jsonD['data'],
        reviews: jsonD['reviews'],
        projects: jsonD['projects'],
        user: jsonD['user'],
        status: jsonD['status'],
        token: jsonD['token'],
        accounts: jsonD['accounts'],
        order: jsonD['order']);
  }

  factory ApiResponse.timout(Response response) {
    return ApiResponse(
      data: null,
      isSuccessful: false,
      message: 'An Error occurred. Please try again',
    );
  }
}

extension ApiError on DioError {
  ApiResponse toApiError({CancelToken? cancelToken}) {
    ApiResponse apiResponse = ApiResponse(isSuccessful: false);
    switch (type) {
      case DioErrorType.connectionTimeout:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          data: null,
          message: "Please check your internet connection or try again later",
        );

      case DioErrorType.receiveTimeout:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          data: null,
          message: "Please check your internet connection or try again later",
        );

      case DioErrorType.sendTimeout:
        if (cancelToken != null) {
          cancelToken.cancel();
        }
        return ApiResponse(
          isSuccessful: false,
          data: null,
          message: "Please check your internet connection or try again later",
        );

      case DioErrorType.unknown:
        return ApiResponse(
          isSuccessful: false,
          data: null,
          message: "Please help report this error to BOG support",
        );

      case DioErrorType.badResponse:
        if (response!.data is Map<String, dynamic>) {
          var val = response!.data;
          return ApiResponse(
            isSuccessful: false,
            message: val['message'] ?? val['error'].values.first[0],
          );
        } else {
          ApiResponse(
            isSuccessful: false,
            data: null,
            message: response!.data.toString(),
          );
        }
        if (response!.statusCode! >= 300 && response!.statusCode! <= 399) {
          apiResponse.message = error.toString();
        }

        if (response!.statusCode! >= 400 && response!.statusCode! <= 499) {
          apiResponse.message = error.toString();
        }
        if (response!.statusCode! >= 500 && response!.statusCode! <= 599) {
          apiResponse.message = error.toString();
        }
        break;
      default:
        apiResponse = response != null
            ? ApiResponse.response(response!)
            : ApiResponse(
                isSuccessful: false,
                data: null,
                message: error.toString(),
              );
        break;
    }
    return apiResponse;
  }
}
