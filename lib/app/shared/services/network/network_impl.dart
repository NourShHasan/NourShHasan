import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:gymmat/app/shared/services/network/api_response_model.dart';
import 'package:gymmat/app/shared/services/network/error/exceptions.dart';
import 'package:gymmat/app/shared/services/network/network_links.dart';
import 'package:gymmat/app/shared/utils/enums/enums.dart';

import '../../core.export.dart';

/// Used to Handle Network if the
enum NetworkLinks {
  ABWAAB_BASE_URL,
}

abstract class NetworkInterface {
  /// [NetworkLinks] field that swap between base url when [get] url.
  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  });

  /// [NetworkLinks] field that swap between base url when [post] link to
  /// [GYMMAT_URL_PRODUCTION].
  Future<ApiResponse<T>> post<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  });

  /// [NetworkLinks] field that swap between base url when [delete] link to
  /// [GYMMAT_URL_PRODUCTION].
  Future<ApiResponse<T>> delete<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  });

  Future<ApiResponse<T>> put<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  });

  Future<ApiResponse<T>> patch<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  });
}

class NetworkImpl implements NetworkInterface {
  final Dio _dio;
  final AppEnvironment _appEnvironment;
  final bool enableLog;

  final Map<String, dynamic> _headers = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
    'platform': 'android-app', // TODO(): Handle it on iOS.
  };

  ///
  NetworkImpl(this._dio, this._appEnvironment, {this.enableLog = false}) {
    switch (this._appEnvironment) {
      case AppEnvironment.PRODUCTION:
        _dio.options.baseUrl = GYMMAT_URL_PRODUCTION;
        _dio.options.headers = _headers;
        break;
      case AppEnvironment.STAGING:
        _dio.options.baseUrl = GYMMAT_URL_STAGING;
        _dio.options.headers = _headers;
        break;
      case AppEnvironment.DEV:
        _dio.options.baseUrl = GYMMAT_URL_STAGING;
        _dio.options.headers = _headers;
        break;
    }
  }

  /// [get] Method of Network.
  ///
  /// The data and status code returned from Response saved to [ApiResponse].
  ///
  /// [get] method have 2 status:
  ///
  /// 1.Successful State:
  /// If the response is returned successfully, the [get] method will return
  /// [ApiResponse] model with needed data, statusCode of response.
  ///
  /// 2.Error State:
  /// If the response have a Network Error, the [get] method will return [ApiResponse]
  /// with (Null) data and statusCode of Response, And will throw an [Exception] also.
  ///
  @override
  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  }) async {
    ApiResponse<T> _apiResponse = ApiResponse<T>();
    try {
      _handleBaseUrl(networkLinks!);
      _requestHandler(headers, queryParameters, userToken);

      final Future<Response> getMethod = _dio.get(
        url,
        options: Options(headers: _headers),
        queryParameters: queryParameters,
      );

      _apiResponse = await _networkMethods(method: getMethod);
      return _apiResponse;
    } on DioError catch (e) {
      _apiResponse.statusCode = e.response!.statusCode;
      _apiResponse.data = e.response!.data;
      _apiResponse = await _responseHandler(_apiResponse);
      throw _apiResponse;
    }
  }

  /// [post] Method of Network.
  ///
  /// The data and status code returned from Response saved to [ApiResponse].
  ///
  /// [post] method have 2 status:
  ///
  /// 1.Successful State:
  /// If the response is returned successfully, the [get] method will return
  /// [ApiResponse] model with needed data, statusCode of response.
  ///
  /// 2.Error State:
  /// If the response have a Network Error, the [get] method will return [ApiResponse]
  /// with (Null) data and statusCode of Response, And will throw an [Exception] also.
  ///
  @override
  Future<ApiResponse<T>> post<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  }) async {
    ApiResponse<T> _apiResponse = ApiResponse<T>();
    try {
      _handleBaseUrl(networkLinks!);
      _requestHandler(headers, queryParameters, userToken, data: data);

      final Future<Response> postMethod = _dio.post(
        url,
        data: data,
        options: Options(headers: _headers),
        queryParameters: queryParameters,
      );

      _apiResponse = await _networkMethods(method: postMethod);
      return _apiResponse;
    } on DioError catch (e) {
      _apiResponse.statusCode = e.response!.statusCode;
      _apiResponse.data = e.response!.data;
      _apiResponse = await _responseHandler(_apiResponse);
      throw _apiResponse;
    }
  }

  /// [delete] Method of Network.
  ///
  /// The data and status code returned from Response saved to [ApiResponse].
  ///
  /// [delete] method have 2 status:
  ///
  /// 1.Successful State:
  /// If the response is returned successfully, the [delete] method will return
  /// [ApiResponse] model with needed data, statusCode of response.
  ///
  /// 2.Error State:
  /// If the response have a Network Error, the [delete] method will return [ApiResponse]
  /// with (Null) data and statusCode of Response, And will throw an [Exception] also.
  ///
  @override
  Future<ApiResponse<T>> delete<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  }) async {
    ApiResponse<T> _apiResponse = ApiResponse<T>();
    try {
      _handleBaseUrl(networkLinks!);
      _requestHandler(headers, queryParameters, userToken, data: data);

      final Future<Response> postMethod = _dio.delete(
        url,
        data: data,
        options: Options(headers: _headers),
        queryParameters: queryParameters,
      );

      _apiResponse = await _networkMethods(method: postMethod);
      return _apiResponse;
    } on DioError catch (e) {
      _apiResponse.statusCode = e.response!.statusCode;
      _apiResponse.data = e.response!.data;
      _apiResponse = await _responseHandler(_apiResponse);
      throw _apiResponse;
    }
  }

  /// [put] Method of Network.
  ///
  /// The data and status code returned from Response saved to [ApiResponse].
  ///
  /// [put] method have 2 status:
  ///
  /// 1.Successful State:
  /// If the response is returned successfully, the [put] method will return
  /// [ApiResponse] model with needed data, statusCode of response.
  ///
  /// 2.Error State:
  /// If the response have a Network Error, the [put] method will return [ApiResponse]
  /// with (Null) data and statusCode of Response, And will throw an [Exception] also.
  ///
  @override
  Future<ApiResponse<T>> put<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  }) async {
    ApiResponse<T> _apiResponse = ApiResponse<T>();
    try {
      _handleBaseUrl(networkLinks!);
      _requestHandler(headers, queryParameters, userToken, data: data);
      final Future<Response> putMethod = _dio.put(
        url,
        data: data,
        options: Options(headers: _headers),
        queryParameters: queryParameters,
      );

      _apiResponse = await _networkMethods(method: putMethod);
      return _apiResponse;
    } on DioError catch (e) {
      _apiResponse.statusCode = e.response!.statusCode;
      _apiResponse.data = e.response!.data;
      _apiResponse = await _responseHandler(_apiResponse);
      throw _apiResponse;
    }
  }

  /// [patch] Method of Network.
  ///
  /// The data and status code returned from Response saved to [ApiResponse].
  ///
  /// [patch] method have 2 status:
  ///
  /// 1.Successful State:
  /// If the response is returned successfully, the [patch] method will return
  /// [ApiResponse] model with needed data, statusCode of response.
  ///
  /// 2.Error State:
  /// If the response have a Network Error, the [patch] method will return [ApiResponse]
  /// with (Null) data and statusCode of Response, And will throw an [Exception] also.
  ///
  @override
  Future<ApiResponse<T>> patch<T>(
    String url, {
    String? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String? userToken,
    NetworkLinks? networkLinks = NetworkLinks.ABWAAB_BASE_URL,
  }) async {
    ApiResponse<T> _apiResponse = ApiResponse<T>();
    try {
      _handleBaseUrl(networkLinks!);
      _requestHandler(headers, queryParameters, userToken, data: data);
      final Future<Response> patchMethod = _dio.patch(
        url,
        data: data,
        options: Options(headers: _headers),
        queryParameters: queryParameters,
      );

      _apiResponse = await _networkMethods(method: patchMethod);
      return _apiResponse;
    } on DioError catch (e) {
      _apiResponse.statusCode = e.response!.statusCode;
      _apiResponse.data = e.response!.data;
      _apiResponse = await _responseHandler(_apiResponse);
      throw _apiResponse;
    }
  }

  /// Generic Method of Network used for [get, post, put, delete, patch] Methods
  ///
  /// The data and status code returned from Response saved to [ApiResponse].
  ///
  /// [_networkMethods] method have 2 status:
  ///
  /// 1.Successful State:
  /// If the response is returned successfully, the [get] method will return
  /// [ApiResponse] model with needed data, statusCode of response.
  ///
  /// 2.Error State:
  /// If the response have a Network Error, the [get] method will return [ApiResponse]
  /// with (Null) data and statusCode of Response, And will throw an [Exception] also.
  ///
  Future<ApiResponse<T>> _networkMethods<T>({
    required Future<Response> method,
  }) async {
    ApiResponse<T> _apiResponse = ApiResponse<T>();
    try {
      // set the response of method [get, post, put, patch, delete] to response.
      final response = await method;
      _apiResponse.statusCode = response.statusCode;
      _apiResponse.data = response.data;
      _apiResponse = await _responseHandler(_apiResponse);

      if (enableLog) _networkLog(response);

      return _apiResponse;
    } on DioError catch (e) {
      _traceError(e);
      _apiResponse.statusCode = e.response!.statusCode;
      _apiResponse.data = e.response!.data;
      _apiResponse = await _responseHandler(_apiResponse);
      developer.log('NETWORK :: DioError :: $e');
      developer.log('NETWORK :: DioError :: ${e.type}');
      throw _apiResponse;
    }
  }

  /// That responsible for handling the exceptions and error that thrown from api.
  Future<ApiResponse<T>> _responseHandler<T>(ApiResponse<T> response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return response;
      case 400:
        final String _errorHandler = response.data == null
            ? 'BadRequestException'
            : await _errorMessageHandler(response);
        throw BadRequestException(
          message: _errorHandler,
          messageKey: response.data['message_key'],
          daysLeft: response.data['message_key'] == "cannot_update_username_now"
              ? response.data['data']["days_left_username_update"]
              : 0,
        );
      case 404:
        final String _error = response.data == null
            ? 'NotFoundException'
            : response.data['message_key'] == null
                ? 'NotFoundException'
                : await _errorMessageHandler(response);
        throw NotFoundException(
          message: _error,
          messageKey: response.data['message_key'],
        );
      case 406:
        final String _error = response.data == null
            ? 'NotFoundException'
            : await _errorMessageHandler(response);
        throw NotFoundException(
          message: _error,
          messageKey: response.data['message_key'],
        );
      case 422:
        String _error = '';

        if (response.data is String || response.data == null) {
          _error = 'BadRequestException';
          throw BadRequestException(
            message: _error,
            messageKey: _error,
          );
        } else {
          _error = await _errorMessageHandler(response);
          throw BadRequestException(
            message: _error,
            messageKey: response.data['message_key'],
          );
        }

      case 401:
        throw NotFoundException();
      case 403:
        final String _error = response.data == null
            ? 'UnAuthorizationException'
            : await _errorMessageHandler(response);
        throw UnAuthorizationException(message: _error);
      case 500:
        throw ServerException(
            message: 'There is an server exception, try again!');
      case 502:
        throw ServerException(
            message: 'There is an server exception, try again!');
      default:
        final String _error = response.data == null
            ? 'SocketException'
            : await _errorMessageHandler(response);
        throw const SocketException('There is no Internet!');
    }
  }

  /// [_requestHandler] handle request [data, params, headers] that sent to Servers via Network.
  void _requestHandler(
    Map<String, dynamic>? headers,
    Map? params,
    String? userToken, {
    String? data,
  }) {
    if (data == null) data = "";
    if (headers != null) _headers.addAll(headers);
    if (params == null) params = {"": ""};
    if (userToken != null) _headers.addAll({"x-access-token": userToken});
  }

  /// handle error message that passed to exceptions.
  Future<String> _errorMessageHandler(ApiResponse response) async {
    const String currentLang = 'EN ';
    final errorMessages =
        await rootBundle.loadString('assets/json/api_messages.json');
    final data = json.decode(errorMessages) as Map<String, dynamic>;
    final messageKey = response.data['message_key'];
    final message = data[messageKey][currentLang];
    return message!;
  }

  /// [_handleBaseUrl] handle the [NetworkLinks]  to change the BASE_URL
  /// to choose the {  networkLinks } URLs whether it be [AppEnvironment.PRODUCTION] or [AppEnvironment.STAGING]
  void _handleBaseUrl(NetworkLinks networkLinks) {
    /// if Abwaab Base URL Paths
    switch (networkLinks) {
      case NetworkLinks.ABWAAB_BASE_URL:
        switch (this._appEnvironment) {
          case AppEnvironment.PRODUCTION:
            _dio.options.baseUrl = GYMMAT_URL_PRODUCTION;
            _headers.remove("Authorization");
            break;
          case AppEnvironment.STAGING:
            _dio.options.baseUrl = GYMMAT_URL_STAGING;
            _headers.remove("Authorization");
            break;
          case AppEnvironment.DEV:
            _dio.options.baseUrl = GYMMAT_URL_STAGING;
            break;
        }
        break;
    }
  }

  void _traceError(DioError e) =>
      developer.log('════════════════════════════════════════ \n'
          '╔╣ Dio [ERROR] info ==> \n'
          '╟ ENVIROMENT: ${_appEnvironment.name}\n'
          '╟ BASE_URL: ${e.requestOptions.baseUrl}\n'
          '╟ PATH: ${e.requestOptions.path}\n'
          '╟ Method: ${e.requestOptions.method}\n'
          '╟ Params: ${e.requestOptions.queryParameters}\n'
          '╟ Body: ${e.requestOptions.data}\n'
          '╟ Header: ${e.requestOptions.headers}\n'
          '╟ statusCode: ${e.response!.statusCode}\n'
          '╟ RESPONSE: ${e.response!.data} \n'
          '╟ stackTrace: ${e.stackTrace} \n'
          '╚ [END] ════════════════════════════════════════╝');

  void _networkLog(Response response) =>
      developer.log('════════════════════════════════════════ \n'
          '╔╣ Dio [RESPONSE] info ==> \n'
          '╟ ENVIROMENT: ${_appEnvironment.name}\n'
          '╟ BASE_URL: ${response.requestOptions.baseUrl}\n'
          '╟ PATH: ${response.requestOptions.path}\n'
          '╟ Method: ${response.requestOptions.method}\n'
          '╟ Params: ${response.requestOptions.queryParameters}\n'
          '╟ Body: ${response.requestOptions.data}\n'
          '╟ Header: ${response.requestOptions.headers}\n'
          '╟ statusCode: ${response.statusCode}\n'
          '╟ RESPONSE: ${response.data} \n'
          '╚ [END] ════════════════════════════════════════╝');
}
