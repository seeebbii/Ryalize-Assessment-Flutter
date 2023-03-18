import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/meta/utils/base_helper.dart';
import 'package:ryalize_assessment/meta/utils/hive_database.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'api_config.dart';
import 'api_paths.dart';

/// custom enum to define the request methods
/// [POST] is used to send data to the server
/// [GET] is used to get data from the server
/// [PUT] is used to update data on the server
/// [PATCH] is used to update data on the server
/// [DELETE] is used to delete data from the server
enum RequestMethod {
  POST,
  GET,
  PUT,
  PATCH,
  DELETE,
}

class ApiService {
  static late dio.CancelToken cancelToken;

  /// Main generic function that uses dio library to send requests to the server
  /// [path] is the path of the api
  /// [method] is the request method
  /// [data] is the data to be sent to the server
  /// [queryParameters] is the query parameters to be sent to the server
  /// [onSendProgress] is the callback function that is called when the request is being sent
  /// [onReceiveProgress] is the callback function that is called when the response is being received
  /// [cancelToken] is the token that is used to cancel the request
  /// [options] is the options that are used to send the request
  /// [onDownloadProgress] is the callback function that is called when the download is being received
  /// [onUploadProgress] is the callback function that is called when the upload is being sent
  static Future<Map<String, dynamic>?> request(String path,
      {required RequestMethod method, data, queryParameters}) async {
    log('Path: $path');
    log('method: ${describeEnum(method)}');
    log('queryParameters: $queryParameters');
    log('data: $data');
    try {
      // Add the auth token to the headers
      ApiConfig().dio.options.headers[HttpHeaders.authorizationHeader] = HiveDatabase.getValue(HiveDatabase.authToken);
      ApiConfig().dio.options.method = describeEnum(method);
      cancelToken = dio.CancelToken();
      // Dio request method
      dio.Response response = await ApiConfig().dio.request(
            path,
            data: data,
            queryParameters: queryParameters,
            onSendProgress: (int sent, int total) =>
                debugPrint("SENT: $sent TOTAL: $total"),
            cancelToken: cancelToken,
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                },
                headers: {
                  HttpHeaders.acceptHeader: "json/application/json",
                  HttpHeaders.contentTypeHeader:
                      "application/x-www-form-urlencoded"
                }),
          );

      // log(response.data.toString());
      if (response.statusCode == 200) {
        return response.data;
      }
      if (response.statusCode == 401) {
        /// Remove the remember me check and move to login screen
        HiveDatabase.storeValue(HiveDatabase.loginCheck, false);
        navigationController.getOffAll(RouteGenerator.loginScreen);
        BaseHelper.showSnackBar("Token Expired");
      } else {
        return response.data;
      }
    } on dio.DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        BaseHelper.showSnackBar("Connection Timed Out");
      }

      log("$path >>>>> ${e.response}");
      if (e.response?.statusCode != 500) {
        return e.response?.data;
      }
    }

    return null;
  }
}
