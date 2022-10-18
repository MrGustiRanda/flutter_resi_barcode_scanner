import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/http_exeption.dart';
import '../providers/transaction.dart';
import '../widgets/app_drawer.dart';

class ScanReceiptScreen extends StatefulWidget {
  static const routeName = '/scan-receipt';

  @override
  State<ScanReceiptScreen> createState() => _ScanReceiptScreenState();
}

class _ScanReceiptScreenState extends State<ScanReceiptScreen> {
  String _scanBarcode = '';

  var _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Transaction>(context).getPicker().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
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
                Navigator.of(context).pushNamed(ScanReceiptScreen.routeName);
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
          .saveReceipt(_scanBarcode);
      setState(() {
        _scanBarcode = '';
      });
      await _showSuccessDialog();
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

  @override
  Widget build(BuildContext context) {
    final picker = Provider.of<Transaction>(context).picker;

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
                    ElevatedButton(
                      child: const Text(
                        'Simpan',
                      ),
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        primary: Theme.of(context).primaryColor,
                        onPrimary:
                            Theme.of(context).primaryTextTheme.button?.color,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('Jumlah Resi Hari ini :'),
                        subtitle: Text(picker != null
                            ? (picker as Map)['jumlah_resi_hari_ini']
                                    .toString() +
                                ' resi'
                            : ''),
                      ),
                      margin: const EdgeInsets.only(bottom: 24),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('Jumlah Resi yang lalu :'),
                        subtitle: Text(picker != null
                            ? (picker as Map)['jumlah_resi_yang_lalu']
                                    .toString() +
                                ' resi'
                            : ''),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
