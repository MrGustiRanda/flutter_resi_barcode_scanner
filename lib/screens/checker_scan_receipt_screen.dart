import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/http_exeption.dart';
import '../providers/transaction.dart';
import '../widgets/app_drawer.dart';

class CheckerScanReceiptScreen extends StatefulWidget {
  static const routeName = '/checker-scan-receipt';

  @override
  State<CheckerScanReceiptScreen> createState() =>
      _CheckerScanReceiptScreenState();
}

class _CheckerScanReceiptScreenState extends State<CheckerScanReceiptScreen> {
  String _scanBarcode = '';
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!'),
          content: const Text('Berhasil menyimpan resi.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(CheckerScanReceiptScreen.routeName);
              },
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error!'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Transaction>(context, listen: false)
          .searchChecker(_scanBarcode);
      setState(() {
        _scanBarcode = '';
      });
    } on HttpExeption catch (error) {
      var errorMessage = error.toString();

      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    _submit();
  }

  Future<void> _storeReceipt(String receiptId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Transaction>(context, listen: false)
          .saveCheckerReceipt(receiptId);

      setState(() {
        _scanBarcode = '';
      });
      Provider.of<Transaction>(context, listen: false).searchChecker('');
      _showSuccessDialog();
    } on HttpExeption catch (error) {
      var errorMessage = error.toString();

      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget getTextWidgets(strings) {
    if (strings == null) return Container();

    return Column(
      children: (strings as List<dynamic>).map((item) {
        if (item['id'] == '') return Container();

        return (Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'No Resi:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            item['no_resi'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resi ID:'),
                    Text(
                      item['id'],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      right: 12,
                    ),
                    child: ElevatedButton(
                      child: const Text('Simpan'),
                      onPressed: () => _storeReceipt(item['id']),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary:
                            Theme.of(context).primaryTextTheme.button?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final checker = Provider.of<Transaction>(context).checker;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(36),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Text(
                        'SCAN RESI',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: OutlinedButton.icon(
                          onPressed: () => scanBarcodeNormal(),
                          icon: const Icon(
                            Icons.qr_code_scanner_outlined,
                          ),
                          label: const Text('Scan Resi'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                          'No Resi: ${_scanBarcode != '' ? _scanBarcode : '-'}'),
                    ),
                    // ElevatedButton(
                    //   child: const Text(
                    //     'Simpan',
                    //   ),
                    //   onPressed: _submit,
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 30.0, vertical: 8.0),
                    //     primary: Theme.of(context).primaryColor,
                    //     onPrimary:
                    //         Theme.of(context).primaryTextTheme.button?.color,
                    //     minimumSize: const Size.fromHeight(50),
                    //   ),
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    getTextWidgets(
                      checker != null
                          ? (checker as Map)['daftar_resi']
                          : [
                              {
                                'id': '',
                                'name': '',
                                'no_resi': '',
                              }
                            ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
