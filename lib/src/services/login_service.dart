import 'dart:convert';

import 'package:cosbiome_envios/src/models/login_data_model.dart';
import 'package:cosbiome_envios/src/utils/http_utils.dart';
import 'package:cosbiome_envios/src/utils/preferences_utils.dart';
import 'package:flutter/material.dart';

class LoginService extends ChangeNotifier {
  bool _isLoading = false;
  String _email = '';
  String _password = '';

  bool get isLoading => _isLoading;
  String get email => _email;
  String get password => _password;

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> handleLogin(BuildContext context, [bool mounted = true]) async {
    try {
      updateIsLoading(true);

      final loginResponse = await Http.login(
        'auth/local',
        jsonEncode({
          'identifier': _email,
          'password': _password,
        }),
      );

      final loginData = LoginDataModel.fromJson(loginResponse.data);

      PreferencesUtils.putString('jwt', loginData.jwt!);
      PreferencesUtils.putString('user', jsonEncode(loginData.user!));
      PreferencesUtils.putBool('isLogged', true);

      updateIsLoading(false);

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      updateIsLoading(false);
    }
  }
}
