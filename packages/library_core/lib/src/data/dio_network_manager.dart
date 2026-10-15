import 'package:dio/dio.dart';
import 'package:library_core/src/data/app_request.dart';
import 'package:library_core/src/data/network_exception.dart';
import 'package:library_core/src/data/network_manager.dart';

class DioNetworkManager({
  required this._dio,
  this.enableLogging = true,
}) implements NetworkManager {
  this {
    _dio.interceptors.addAll(
      [
        if (enableLogging) ...[
          LogInterceptor(
            request: true,
            responseBody: true,
            requestBody: true,
            error: true,
          ),
        ],
      ],
    );
  }

  final Dio _dio;
  final bool enableLogging;

  @override
  Future<T> makeRequest<T>({required AppRequest<T> request}) async {
    final pathParams = request.pathParams;
    final path = request.requestName.getPath(pathParameters: pathParams);

    final Object? data;

    try {
      final response = await switch (request.requestType) {
        .get => _dio.get(path, queryParameters: request.queryParams),
      };
      data = response.data;
    } on DioException catch (e, st) {
      final exception = switch (e.type) {
        .connectionError ||
        .sendTimeout ||
        .receiveTimeout ||
        .connectionTimeout => NoConnection(),
        .badResponse => HttpError(e.response?.statusCode),
        .unknown when e.error is FormatException => DecodingError(e),
        .cancel => CancelledRequest(),
        _ => UnknownNetworkError(e),
      };

      Error.throwWithStackTrace(exception, st);
    }
    try {
      return request.responseFactory(data);
    } catch (e, st) {
      Error.throwWithStackTrace(DecodingError(e), st);
    }
  }
}
