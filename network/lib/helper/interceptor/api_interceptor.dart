part of '../../network.dart';

class ApiInterceptor extends Interceptor {
  // Lock to prevent multiple simultaneous refresh token calls
  bool _isRefreshing = false;
  final _pendingRequests = <({RequestOptions options, ErrorInterceptorHandler handler})>[];

  // ── onRequest ────────────────────────────────────────────────────────────────

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token =  NetworkPrefs.getToken();
    if (token != null) {
      options.headers[ApiKeys.authorization] = '${ApiKeys.bearer} $token';
    }
    handler.next(options);
  }

  // ── onResponse ───────────────────────────────────────────────────────────────

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  // ── onError ──────────────────────────────────────────────────────────────────

  @override
  // Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
  //   // Handle timeouts
  //   if (err.type == DioExceptionType.connectionTimeout ||
  //       err.type == DioExceptionType.receiveTimeout ||
  //       err.type == DioExceptionType.sendTimeout) {
  //     return handler.reject(DioException(requestOptions: err.requestOptions, error: const TimeoutException(), type: err.type));
  //   }
  //
  //   // Handle 401
  //   if (err.response?.statusCode == 401) {
  //     // If the 401 came from the refresh token API itself → force logout
  //     if (err.requestOptions.path == ApiUrl.refreshToken) {
  //       await NetworkPrefs.clearTokens();
  //       return handler.reject(
  //         DioException(requestOptions: err.requestOptions, error: const UnAuthenticated(), response: err.response),
  //       );
  //     }
  //
  //     // Queue this request if a refresh is already in progress
  //     if (_isRefreshing) {
  //       _pendingRequests.add((options: err.requestOptions, handler: handler));
  //       return;
  //     }
  //
  //     _isRefreshing = true;
  //
  //     try {
  //       final refreshed = await AuthRepository().refreshToken();
  //
  //       if (refreshed) {
  //         // Retry the original failed request
  //         final response = await _retry(err.requestOptions);
  //         handler.resolve(response);
  //
  //         // Retry all queued requests
  //         for (final pending in _pendingRequests) {
  //           try {
  //             final res = await _retry(pending.options);
  //             pending.handler.resolve(res);
  //           } catch (e) {
  //             pending.handler.reject(DioException(requestOptions: pending.options, error: e));
  //           }
  //         }
  //       } else {
  //         // Refresh failed → force logout
  //         _rejectAll(err);
  //         handler.reject(
  //           DioException(requestOptions: err.requestOptions, error: const UnAuthenticated(), response: err.response),
  //         );
  //       }
  //     } catch (_) {
  //       _rejectAll(err);
  //       handler.reject(DioException(requestOptions: err.requestOptions, error: const UnAuthenticated(), response: err.response));
  //     } finally {
  //       _pendingRequests.clear();
  //       _isRefreshing = false;
  //     }
  //
  //     return;
  //   }
  //
  //   // Handle other errors
  //   String? message;
  //   final data = err.response?.data;
  //   if (data is Map && data.containsKey(ApiKeys.message)) {
  //     message = data[ApiKeys.message]?.toString();
  //   }
  //
  //   handler.reject(
  //     DioException(
  //       requestOptions: err.requestOptions,
  //       error: DefaultException(message: message ?? 'Something went wrong!'),
  //       response: err.response,
  //       type: err.type,
  //       stackTrace: err.stackTrace,
  //       message: err.message,
  //     ),
  //   );
  // }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Future<Response> _retry(RequestOptions options) async {
    final token = NetworkPrefs.getToken();
    options.headers[ApiKeys.authorization] = '${ApiKeys.bearer} $token';
    return DioClient.instance.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(method: options.method, headers: options.headers),
    );
  }

  void _rejectAll(DioException err) {
    for (final pending in _pendingRequests) {
      pending.handler.reject(DioException(requestOptions: pending.options, error: const UnAuthenticated()));
    }
  }
}
