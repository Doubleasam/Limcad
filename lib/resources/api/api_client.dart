import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:limcad/resources/api/route.dart';
import 'package:logger/logger.dart';
import 'base_response.dart';
import 'from_json.dart';
import 'package:flutter/foundation.dart';

abstract class BaseAPIClient {
  Future<ResponseWrapper<T>> request<T extends FromJson>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
  });
}

class APIClient implements BaseAPIClient {
  final BaseOptions options;
  late Dio instance;

  APIClient(this.options) {
    instance = Dio(options);

    instance.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    });
  }

  @override
  Future<ResponseWrapper<T>> request<T extends FromJson>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
  }) async {
    final config = route.getConfig();
    if (config == null) {
      throw ErrorResponse(message: 'Failed to load request options.');
    }
    config.baseUrl = options.baseUrl;
    config.connectTimeout = options.connectTimeout;
    config.receiveTimeout = options.receiveTimeout;
    if (data != null) {
      if (config.method == ApiMethod.get) {
        config.queryParameters = data;
      } else {
        config.data = data;
      }
    }
    try {
      final response = await instance.fetch(config);
      final dataFinal = {
      "status": response.statusCode,
      "message": response.statusMessage,
      "data": response.data,
      };

      return ResponseWrapper.init(create: create, data: dataFinal);
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return ResponseWrapper.init(create: create, data: {
          "status": 500,
          "message": "Connection error! Please check your internet.",
        });
      } else {
        return ResponseWrapper.init(create: create, data: {
          "status": e.response?.statusCode ?? 500,
          "message": e.response?.statusMessage ?? "An error occurred, please try again later",
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      return ResponseWrapper.init(create: create, data: {
        "status": 500,
        "message": "An error occurred, please try again later",
      });
    }
  }
}
