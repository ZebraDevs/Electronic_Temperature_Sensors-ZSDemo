import 'package:dio/dio.dart';

mixin ZsDioMixin {
  final Dio dio = Dio()
    ..options.baseUrl = 'https://api.zebra.com/v2'
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          //TODO local builds add --dart-define=AUTH=[your API key] to run configuration
          options.headers['apiKey'] = const String.fromEnvironment('AUTH');
          options.headers.addAll(defaultHeaders);
          return handler.next(options);
        },
        onError: (err, handler) {
          handler.next(err);
        },
      ),
    );
}

const Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json; charset=UTF-8',
};
