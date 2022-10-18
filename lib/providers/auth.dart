import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exeption.dart';
import '../constants.dart';

class Auth extends ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  Object? _me;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        (_expiryDate as DateTime).isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  String? get userId {
    return _userId;
  }

  Object? get me {
    return _me;
  }

  Future<void> getMe() async {
    final url = Uri.parse(serverUrl + '/auth/me');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);

      if (responseData == null) {
        return;
      }

      _me = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _authenticate(String username, String password) async {
    final url = Uri.parse(serverUrl + '/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'username': username,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpExeption(responseData['error']);
      }

      _token = responseData['access_token'];
      _userId = responseData['access_token'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expires_in'],
        ),
      );

      _autoLogout();
      notifyListeners();

      final _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      final userData = json.encode(
        {
          'token': _token,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );

      prefs.setString('token', _token as String);
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String username, String password) async {
    return _authenticate(username, password);
  }

  Future<bool> tryAutoLogin() async {
    final _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (!prefs.containsKey('token')) {
      return false;
    }

    var extractedUserData = json.decode(prefs.getString('userData')!);

    var expiryDate = DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
