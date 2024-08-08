import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper<T> {
  NetworkHelper(this.url);

  final String url;

  Future<http.Response> fetchData() async {
    return http.get(Uri.parse(url));
  }

  Future<Map<String, dynamic>> getDecodedData() async {
    return jsonDecode((await fetchData()).body) as Map<String, dynamic>;
  }
}
