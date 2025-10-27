import 'package:access_control/shared/services/http_client/http_client.dart';
import 'package:dio/dio.dart';

class DioHttpClientImpl implements IHttpClient {
  final Dio _dio;

  DioHttpClientImpl({Dio? dio})
    : _dio =
          dio ?? Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));

  @override
  Future<HttpResponse> get(String url, {Map<String, dynamic>? headers}) async {
    final response = await _dio.get(url, options: Options(headers: headers));
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
    );
  }

  @override
  Future<HttpResponse> post(
    String url, {
    body,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.post(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
    );
  }

  @override
  Future<HttpResponse> put(
    String url, {
    body,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.put(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
    );
  }

  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.delete(url, options: Options(headers: headers));
    return HttpResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
    );
  }
}
