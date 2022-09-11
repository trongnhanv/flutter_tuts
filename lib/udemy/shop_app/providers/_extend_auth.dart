import 'package:basic_tuts/udemy/shop_app/providers/auth_provider.dart';

class ExtendAuth {
  late AuthProvider _authProvider;

  void update(AuthProvider authProvider) {
    _authProvider = authProvider;
  }

  String get idToken => _authProvider.idToken;
}
