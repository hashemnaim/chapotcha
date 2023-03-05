import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:capotcha/utils/shared_preferences_helpar.dart';
import 'package:capotcha/services/status_code.dart';
import 'package:dio/dio.dart' as dio;

import 'api_exceptions.dart';

class BaseClient {
  static final dio.Dio _dio = dio.Dio();
  static const int TIME_OUT_DURATION = 20;
  BaseClient._();
  static BaseClient baseClient = BaseClient._();
  get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(dio.Response response) onSuccess,
    Function? onLoading,
  }) async {
    try {
      onLoading?.call();
      var response = await _dio
          .get(
            url,
            queryParameters: queryParameters,
            options: dio.Options(
              headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
              },
            ),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      await onSuccess(response);
    } on dio.DioError catch (error) {
      BotToast.closeAllLoading();
      return handleDioError(error);
    }
  }

  post(
    String url, {
    Map<String, dynamic>? headers,
    dynamic data,
    required Function(dio.Response response) onSuccess,
    Function? onLoading,
  }) async {
    try {
      onLoading?.call();
      var response = await _dio
          .post(
            url,
            data: data,
            options: dio.Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
              },
            ),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      await onSuccess(response);
    } on dio.DioError catch (error) {
      BotToast.closeAllLoading();
      return handleDioError(error);
    }
  }

  delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required Function(dio.Response response) onSuccess,
    Function? onLoading,
  }) async {
    try {
      onLoading?.call();
      var response = await _dio
          .delete(
            url,
            data: data,
            options: dio.Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${SHelper.sHelper.getToken()}'
              },
            ),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      await onSuccess(response);
    } on dio.DioError catch (error) {
      BotToast.closeAllLoading();
      return handleDioError(error);
    }
  }

  _handleError(String msg) {
    log(msg);
  }

  dynamic handleDioError(dio.DioError dioError) {
    // switch (dioError.error) {
    // case dio.DioErrorType.connectTimeout:
    //   _handleError(dioError.message);
    //   break;
    // case dio.DioErrorType.sendTimeout:
    //   _handleError(dioError.message);
    //   break;
    // case dio.DioErrorType.cancel:
    //   _handleError(dioError.message);
    //   break;

    // case dio.DioErrorType.receiveTimeout:
    //   throw FetchDataException();

    // case dio.DioErrorType.response:
    switch (dioError.response?.statusCode) {
      case StatusCode.badRequest:
        _handleError(dioError.message);

        throw BadRequestException();

      case StatusCode.unAuthorized:
        _handleError(dioError.message);
        break;

      case StatusCode.forbidden:
        _handleError(dioError.message);

        throw UnauthorizedException();

      case StatusCode.notFound:
        _handleError(dioError.message);

        throw NotFoundException();
      case StatusCode.confilct:
        _handleError(dioError.message);

        throw ConflictException();
      case StatusCode.internalServerErorr:
        _handleError(dioError.message);

        throw InternalServerErrorException();

      default:
        throw InternalServerErrorException();
    }
  }
  // }
}
