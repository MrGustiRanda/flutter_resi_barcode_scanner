import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exeption.dart';
import '../constants.dart';

class Transaction extends ChangeNotifier {
  final String? authToken;
  Object? _picker;
  Object? _receiptPicker;
  Object? _checker;
  Object? _receiptChecker;
  Object? _handoffer;
  Object? _receiptHandoffer;

  Transaction(this.authToken);

  Object? get picker {
    return _picker;
  }

  Object? get receiptPicker {
    return _receiptPicker;
  }

  Object? get checker {
    return _checker;
  }

  Object? get receiptChecker {
    return _receiptChecker;
  }

  Object? get handoffer {
    return _handoffer;
  }

  Object? get receiptHandoffer {
    return _receiptHandoffer;
  }

  Future<void> getPicker() async {
    final url = Uri.parse(serverUrl + '/transaksi/picker');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {},
        ),
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

  Future<void> saveReceipt(String code) async {
    final url = Uri.parse(serverUrl + '/transaksi/picker/store');

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
            'no_resi': code,
            'picker_id': null,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> choosePicker(String totalReceipt, int pickerId) async {
    final url = Uri.parse(serverUrl + '/transaksi/picker/storeresipicker');

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
            'jumlah_resi': totalReceipt,
            'picker_id': pickerId,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getReceiptPicker() async {
    final url = Uri.parse(serverUrl + '/transaksi/resipicker');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      _receiptPicker = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> searchChecker(String searchValue) async {
    final url = Uri.parse(serverUrl + '/transaksi/checker/search');
    print(searchValue);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {'search': searchValue},
        ),
      );
      final responseData = json.decode(response.body);

      // if (responseData['daftar_resi']) {
      //   throw HttpExeption(responseData['no_resi']?[0]);
      // }

      _checker = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveCheckerReceipt(String receiptId) async {
    final url = Uri.parse(serverUrl + '/transaksi/checker/store');

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
            'resi_id': receiptId,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getReceiptChecker() async {
    final url = Uri.parse(serverUrl + '/transaksi/resichecker');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      _receiptChecker = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> searchHandoffer(String searchValue) async {
    final url = Uri.parse(serverUrl + '/transaksi/handoffer/search');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
          {'search': searchValue},
        ),
      );
      final responseData = json.decode(response.body);

      // if (responseData['daftar_resi']) {
      //   throw HttpExeption(responseData['no_resi']?[0]);
      // }

      _handoffer = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveHandofferReceipt(String receiptId) async {
    final url = Uri.parse(serverUrl + '/transaksi/handoffer/store');

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
            'resi_id': receiptId,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getReceiptHandoffer() async {
    final url = Uri.parse(serverUrl + '/transaksi/resihandoffer');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData['no_resi'] != null) {
        throw HttpExeption(responseData['no_resi']?[0]);
      }

      _receiptHandoffer = responseData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
