import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healr/core/errors/failure.dart';
import 'package:healr/core/utils/shared_pref_cache.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final String baseUrl = 'https://healer-theta.vercel.app/api/v1/';
  final Dio dio;

  ApiService(this.dio) {
    dio.options.validateStatus = (status) => true;
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    String token = '',
    Map<String, dynamic>? body,
  }) async {
    try {
      // Get the latest token from SharedPreferences
      String currentToken = SharedPrefCache.getCache(key: 'token');

      // Debug prints

      var response = await dio.post(
        '$baseUrl$endPoint',
        data: body,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $currentToken",
        }),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }

  Future<Map<String, dynamic>> postt({
    required String endPoint,
    String token = '',
    Map<String, dynamic>? body,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl$endPoint',
        data: body,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        }),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final token = SharedPrefCache.getCache(key: 'token');
      var response = await dio.get(
        '$baseUrl$endPoint',
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }

  Future<Map<String, dynamic>> patchFormData({
    required String endPoint,
    required FormData formData,
  }) async {
    try {
      String? token = SharedPrefCache.getCache(key: 'token');
      final response = await dio.patch(
        '$baseUrl$endPoint',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    String token = '',
    Map<String, dynamic>? body,
  }) async {
    try {
      var response = await dio.put(
        '$baseUrl$endPoint',
        data: body,
        options: Options(
          headers: {"Content-Type": "application/json", 'Authorization': token},
        ),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }

  Future<Map<String, dynamic>> deletee({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final token = SharedPrefCache.getCache(key: 'token');
      final response = await dio.delete(
        '$baseUrl$endPoint',
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    String token = '',
    Map<String, dynamic>? body,
  }) async {
    try {
      var response = await dio.delete(
        '$baseUrl$endPoint',
        data: body,
        options: Options(
          headers: {"Content-Type": "application/json", 'Authorization': token},
        ),
      );

      if (response.data is Map<String, dynamic>) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return response.data;
        } else {
          throw ServerFailure.fromResponse(response.statusCode!, response.data);
        }
      } else {
        throw ServerFailure('⚠️ Invalid response format from the server.');
      }
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(' $e');
    }
  }
}
