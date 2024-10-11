import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'from_json.dart';

typedef Create<T> = T Function();

abstract class GenericObject<T> {
  Create<FromJson> create;

  GenericObject({required this.create});

  T genericObject(dynamic data) {
    final item = create();
    return item.fromJson(data);
  }
}

class ResponseWrapper<T> extends GenericObject<T> {
  late T response;

  ResponseWrapper({required Create<FromJson> create}) : super(create: create);

  factory ResponseWrapper.init({
    required Create<FromJson> create,
    required dynamic data
  }) {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(data);
    return wrapper;
  }
}

class BaseResponse<T> extends GenericObject<T> implements FromJson<BaseResponse<T>> {
  int? status;
  String? message;
  dynamic nMeta;
  dynamic nLinks;
  T? data;

  BaseResponse({required Create<FromJson> create}) : super(create: create);

  @override
  BaseResponse<T> fromJson(dynamic json) {
    try {
      if (json is String) {
        message = json;
        status = 200; // You may set an arbitrary status code to indicate success
      } else {
        status = json['status'] ?? json['code'];
        message = json['message'] ?? json['error'];
        if (message != null && message!.isNotEmpty && message!.contains("exception")) {
          message = "An error occurred, please try again later.";
        }
        nMeta = json['_meta'] ?? "";
        nLinks = json['_links'] ?? "";
        if (json['data'] != null) {
          data = genericObject(json['data']);
        } else {
          data = genericObject(json);
        }
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      debugPrint("mobile app parsing_error");
    }
    return this;
  }
}

class BaseAPIListResponse<T> extends GenericObject<T> implements FromJson<BaseAPIListResponse<T>> {
  int? status;
  String? message;
  dynamic nMeta;
  dynamic nLinks;
  List<T>? data;

  bool directList;

  BaseAPIListResponse({required Create<FromJson> create, this.directList = false}) : super(create: create);

  @override
  BaseAPIListResponse<T> fromJson(dynamic json) {
    status = json['status'] ?? json['code'];
    message = json['message'] ?? json['error'];
    nMeta = json['_meta'];
    nLinks = json['_links'];
    data = [];
    Logger().i(json);
    if (directList) {
      data = json['data'].cast<String>();
    } else if (json['data'] != null) {
      json['data'].forEach((item) {
        data?.add(genericObject(item));
      });
    }

    return this;
  }
}

class BaseAPIListPaginationResponse<T> extends BaseAPIListResponse<T> {
  int? currentPage;
  int? totalItems;
  int? totalPages;

  BaseAPIListPaginationResponse({required Create<FromJson> create, bool directList = false})
      : super(create: create, directList: directList);

  @override
  BaseAPIListPaginationResponse<T> fromJson(dynamic json) {
    status = json['status'] ?? json['code'];
    message = json['message'] ?? json['error'];
    nMeta = json['_meta'];
    nLinks = json['_links'];
    data = [];

    if (directList) {
      data = json['items'].cast<T>();
    } else if (json['items'] != null) {
      for (dynamic item in json['items']) {
        data?.add(genericObject(item));
      }
    }

    currentPage = json['currentPage'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];


    return this;
  }
}


class ErrorResponse implements Exception {
  String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message'] ?? 'Something went wrong.');
  }

  @override
  String toString() {
    return message ?? 'Failed to convert message to string.';
  }
}