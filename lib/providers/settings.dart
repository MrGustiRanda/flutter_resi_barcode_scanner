import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exeption.dart';
import '../constants.dart';

class Settings extends ChangeNotifier {
  final String? authToken;
  Object? _picker;
  Object? _checker;
  Object? _handoffer;

  Settings(this.authToken);

  Object? get picker {
    return _picker;
  }

  Object? get checker {
    return _checker;
  }

  Object? get handoffer {
    return _handoffer;
  }

  Future<void> getPicker() async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/picker');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData == null) {
        return;
      }

      _picker = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createPicker(
      name, username, email, phoneNumber, password) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/picker/store');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {
            'name': name,
            'username': username,
            'email': email,
            'nomor_hp': phoneNumber,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['username'] != null) {
        throw HttpExeption(responseData['username']?[0]);
      }
      if (responseData['email'] != null) {
        throw HttpExeption(responseData['email']?[0]);
      }
      if (responseData['nomor_hp'] != null) {
        throw HttpExeption(responseData['nomor_hp']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updatePicker(
      id, name, username, email, phoneNumber, password) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/picker/' + id);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {
            'name': name,
            'username': username,
            'email': email,
            'nomor_hp': phoneNumber,
            'password': password,
            '_method': "PUT",
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['username'] != null) {
        throw HttpExeption(responseData['username']?[0]);
      }
      if (responseData['email'] != null) {
        throw HttpExeption(responseData['email']?[0]);
      }
      if (responseData['nomor_hp'] != null) {
        throw HttpExeption(responseData['nomor_hp']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deletePicker(id) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/picker/' + id);

    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {'_method': "DELETE"},
        ),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getChecker() async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/checker');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData == null) {
        return;
      }

      _checker = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createChecker(
      name, username, email, phoneNumber, password) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/checker/store');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {
            'name': name,
            'username': username,
            'email': email,
            'nomor_hp': phoneNumber,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['username'] != null) {
        throw HttpExeption(responseData['username']?[0]);
      }
      if (responseData['email'] != null) {
        throw HttpExeption(responseData['email']?[0]);
      }
      if (responseData['nomor_hp'] != null) {
        throw HttpExeption(responseData['nomor_hp']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateChecker(
      id, name, username, email, phoneNumber, password) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/checker/' + id);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {
            'name': name,
            'username': username,
            'email': email,
            'nomor_hp': phoneNumber,
            'password': password,
            '_method': "PUT",
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['username'] != null) {
        throw HttpExeption(responseData['username']?[0]);
      }
      if (responseData['email'] != null) {
        throw HttpExeption(responseData['email']?[0]);
      }
      if (responseData['nomor_hp'] != null) {
        throw HttpExeption(responseData['nomor_hp']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteChecker(id) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/checker/' + id);

    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {'_method': "DELETE"},
        ),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getHandoffer() async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/handoffer');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData == null) {
        return;
      }

      _handoffer = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createHandoffer(
      name, username, email, phoneNumber, password) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/handoffer/store');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {
            'name': name,
            'username': username,
            'email': email,
            'nomor_hp': phoneNumber,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['username'] != null) {
        throw HttpExeption(responseData['username']?[0]);
      }
      if (responseData['email'] != null) {
        throw HttpExeption(responseData['email']?[0]);
      }
      if (responseData['nomor_hp'] != null) {
        throw HttpExeption(responseData['nomor_hp']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateHandoffer(
      id, name, username, email, phoneNumber, password) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/handoffer/' + id);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {
            'name': name,
            'username': username,
            'email': email,
            'nomor_hp': phoneNumber,
            'password': password,
            '_method': "PUT",
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['username'] != null) {
        throw HttpExeption(responseData['username']?[0]);
      }
      if (responseData['email'] != null) {
        throw HttpExeption(responseData['email']?[0]);
      }
      if (responseData['nomor_hp'] != null) {
        throw HttpExeption(responseData['nomor_hp']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteHandoffer(id) async {
    final url = Uri.parse(serverUrl + '/setting/pengguna/handoffer/' + id);

    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {'_method': "DELETE"},
        ),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
