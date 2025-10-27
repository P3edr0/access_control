abstract class IHttpClient {
  Future<HttpResponse> get(String url, {Map<String, dynamic>? headers});
  Future<HttpResponse> post(
    String url, {
    dynamic body,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> delete(String url, {Map<String, dynamic>? headers});
}

class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({required this.data, required this.statusCode});
}
