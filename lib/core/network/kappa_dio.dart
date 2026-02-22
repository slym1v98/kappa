import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

/// A standardized Networking Client for Kappa with Offline-First support.
class KappaDio {
  late final Dio _dio;
  final CacheOptions? cacheOptions;

  KappaDio({
    required String baseUrl,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
    bool enableCache = true,
  }) : cacheOptions = enableCache 
          ? CacheOptions(
              store: MemCacheStore(), // Default to memory, can be swapped to Hive
              policy: CachePolicy.refreshForceCache,
              hitCacheOnErrorExcept: [401, 403],
              maxStale: const Duration(days: 7),
            )
          : null {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    if (cacheOptions != null) {
      _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions!));
    }

    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }

    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  /// Perform a GET request.
  Future<Either<Failure, Response<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      return Left(BusinessFailure(e.toString(), stackTrace: stackTrace));
    }
  }

  /// Perform a POST request.
  Future<Either<Failure, Response<T>>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      return Left(BusinessFailure(e.toString(), stackTrace: stackTrace));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Connection timed out", exception: error);
      case DioExceptionType.badResponse:
        return ServerFailure(
          "Server error: ${error.response?.statusCode}",
          exception: error,
        );
      default:
        return ServerFailure("Network error occurred", exception: error);
    }
  }
}
