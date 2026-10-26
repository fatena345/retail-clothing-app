import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:geeta/core/class/status_class.dart';
import 'package:geeta/core/services/storage_manager.dart';

import '../constants/app_keys.dart';
import '../helpful_functions/check_internet_connection.dart';
import '../class/api_helper.dart';


class Crud extends GetxService {

  // general Request

  static Future<Either<StatusClass, dynamic>> _request({
    required Future<http.Response> Function() request,
  }) async
  {
    try {
      final isConnected = await checkInternetConnection();

      if (!isConnected) {
        return const Left(StatusClass.noInternet);
      }

      final response = await request();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return const Right(null);
        }

        final data = jsonDecode(response.body);

        return Right(data);
      }

      String? errorMessage;

      try {
        final body = jsonDecode(response.body);

        if (body is Map) {
          errorMessage =
              body['message']?.toString() ??
                  body['error']?.toString();
        }
      } catch (_) {}

      return Left(
        StatusClass.serverError(
          statusCode: response.statusCode,
          message: errorMessage,
        ),
      );
    } catch (error) {
      return Left(
        StatusClass.anotherError(
          message: error.toString(),
        ),
      );
    }
  }



  // Get method

  static Future<Either<StatusClass, dynamic>> getData({
    required String url,
    Map<String, String>? headers,
    String? token,
  }) {
    return _request(
      request: () {
        return http.get(
          Uri.parse(url),
          headers: headers ??
              ApiHelper.getHeaders(
                requiredToken: token != null,
                token: token,
              ),
        );
      },
    );
  }



  // Post method

  static Future<Either<StatusClass, dynamic>> postData({
    required String url,
    Map<String, String>? headers,
    String? token,
    required Map<String, dynamic> body,
    bool returnOnlyMessage = false,
    bool saveTokenAfterSuccess = false,
  }) async
  {
    final result = await _request(
      request: () {
        return http.post(
          Uri.parse(url),
          headers: headers ??
              ApiHelper.getHeaders(
                requiredToken: token != null,
                token: token,
              ),
          body: jsonEncode(body),
        );
      },
    );

    if (result.isLeft()) {
      return result;
    }

    final data = result.getOrElse(() => null);

    // Save token after successful login/register
    if (saveTokenAfterSuccess && data is Map) {
      final accessToken = data['accessToken'];

      if (accessToken != null) {
        final storage = Get.find<StorageManager>();

        await storage.saveData(
          key: AppKeys.accessToken,
          value: accessToken,
        );
      }
    }

    if (returnOnlyMessage && data is Map) {
      return Right(data['message']);
    }

    return Right(data);
  }



  // Put method

  static Future<Either<StatusClass, dynamic>> putData({
    required String url,
    Map<String, String>? headers,
    String? token,
    required Map<String, dynamic> body,
  })
  {
    return _request(
      request: () {
        return http.put(
          Uri.parse(url),
          headers: headers ??
              ApiHelper.getHeaders(
                requiredToken: token != null,
                token: token,
              ),
          body: jsonEncode(body),
        );
      },
    );
  }



  // Patch method

  static Future<Either<StatusClass, dynamic>> patchData({
    required String url,
    Map<String, String>? headers,
    String? token,
    required Map<String, dynamic> body,
  })
  {
    return _request(
      request: () {
        return http.patch(
          Uri.parse(url),
          headers: headers ??
              ApiHelper.getHeaders(
                requiredToken: token != null,
                token: token,
              ),
          body: jsonEncode(body),
        );
      },
    );
  }



  // Delete method
  
  static Future<Either<StatusClass, dynamic>> deleteData({
    required String url,
    Map<String, String>? headers,
    String? token,
    Map<String, dynamic>? body,
  })
  {
    return _request(
      request: () {
        return http.delete(
          Uri.parse(url),
          headers: headers ??
              ApiHelper.getHeaders(
                requiredToken: token != null,
                token: token,
              ),
          body: body != null ? jsonEncode(body) : null,
        );
      },
    );
  }
}