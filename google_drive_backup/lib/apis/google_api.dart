import 'package:http/http.dart' as http;

class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> headers;

  final http.Client _inner = http.Client();

  GoogleHttpClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request..headers.addAll(headers));
  }

  @override
  void close() {
    _inner.close();
  }
}