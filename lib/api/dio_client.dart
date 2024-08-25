import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:weather/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioClient {
// dio instance
  final Dio _dio;
  final Logger _logger = Logger(
      printer:
          PrettyPrinter(colors: true, printEmojis: true, printTime: false));

  DioClient(this._dio) {
    _dio.interceptors.clear();
    _dio.interceptors.add(ApiKeyInterceptor());
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: Endpoints.receiveTimeout)
      ..options.responseType = ResponseType.json;
  }

  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.i(
          "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Quarry Param =>\x1B[0m ${response.requestOptions.queryParameters}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
      return response;
    } catch (e) {
      _logger.e("Error => $e");
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.i(
          "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
      return response;
    } catch (e) {
      _logger.e("Error => $e");
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.i(
          "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
      return response;
    } catch (e) {
      _logger.e("Error => $e");
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      _logger.i(
          "\x1B[36m URL =>\x1B[0m ${response.requestOptions.path}\n\x1B[36m Request =>\x1B[0m ${response.requestOptions.data}\n\x1B[36m Response =>\x1B[0m ${response.data}");
      return response.data;
    } catch (e) {
      _logger.e("Error => $e");
      rethrow;
    }
  }
}

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({"appid": "37ea9939152496e5de6ca532f93817fd"});
    options.headers.addAll({
      "Content-Type": "application/json",
    });

    return super.onRequest(options, handler);
  }
}


Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    if (kDebugMode) {
      print('not connected');
    }
  }
  return false;
}