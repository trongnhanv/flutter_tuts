import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static const baseUri =
      'https://flutter-udemy-8281b-default-rtdb.firebaseio.com';

  static void handleSuccess(http.Response response,
      void Function(Map<String, dynamic>? body) callback) {
    if (response.body != 'null') {
      var body = json.decode(response.body) as Map<String, dynamic>;
      print("Body $body");
      if (response.statusCode >= 400) {
        throw Exception(body['error']['message']);
      }
      callback(body);
    } else {
      callback(null);
    }
  }

  static void handleAuthenticateSuccess(http.Response response,
      void Function(Map<String, dynamic> body) callback) {
    var body = json.decode(response.body) as Map<String, dynamic>;
    callback(body);
  }

  static Object? parseBody(Map<String, dynamic> body) {
    return json.encode(body);
  }
}
