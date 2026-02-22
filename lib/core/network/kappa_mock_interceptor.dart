import 'package:dio/dio.dart';

/// A specialized interceptor to mock API responses.
/// 
/// You can define a map of [path] -> [data] to simulate server responses.
class KappaMockInterceptor extends Interceptor {
  final Map<String, dynamic> mockData;
  final Duration delay;

  KappaMockInterceptor({
    required this.mockData,
    this.delay = const Duration(milliseconds: 500),
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Check if the current path is in our mock map
    final path = options.path;
    
    if (mockData.containsKey(path)) {
      // Simulate network delay
      await Future.delayed(delay);

      // Return the mock response
      return handler.resolve(
        Response(
          requestOptions: options,
          data: mockData[path],
          statusCode: 200,
        ),
      );
    }

    // Otherwise, continue to the real server
    super.onRequest(options, handler);
  }
}
