import 'dart:convert';

import 'package:basic_tuts/udemy/shop_app/api/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthData {
  final String email;
  final String password;

  const AuthData({required this.email, required this.password});

  AuthData copyWith({String? email, String? password}) {
    return AuthData(
        email: email ?? this.email, password: password ?? this.password);
  }

  Map<String, dynamic> get authenticateData {
    return {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
  }
}

class AuthProvider extends ChangeNotifier {
  static const apiKey = 'AIzaSyB8gIgp8-FjIF4oehZkItdesca2ZXeexvo';
  static String getUrl(method) {
    var uri =
        'https://identitytoolkit.googleapis.com/v1/accounts:__method__?key=$apiKey';
    return uri.replaceFirst('__method__', method);
  }

  String _userId = '';
  String _idToken = '';
  DateTime? _expired;

  String get idToken => _idToken;

  bool get isLoggedIn =>
      _idToken.isNotEmpty &&
      _userId.isNotEmpty &&
      _expired != null &&
      _expired!.isAfter(DateTime.now());

  Future<void> signup(AuthData authData) {
    return http
        .post(Uri.parse(getUrl('signUp')),
            body: HttpService.parseBody(authData.authenticateData))
        .then((value) {
      HttpService.handleSuccess(value, (body) {
        _userId = body!['localId'];
        _idToken = body['idToken'];
        _expired =
            DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
        notifyListeners();
      });
    });
  }

  Future<void> singin(AuthData authData) {
    return http
        .post(Uri.parse(getUrl('signInWithPassword')),
            body: HttpService.parseBody(authData.authenticateData))
        .then((value) {
      HttpService.handleSuccess(value, (body) {
        _userId = body!['localId'];
        _idToken = body['idToken'];
        _expired =
            DateTime.now().add(Duration(seconds: int.parse(body['expiresIn'])));
        notifyListeners();
      });
    });
  }
}
