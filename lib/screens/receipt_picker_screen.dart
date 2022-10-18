import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/transaction.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  favorites,
  all,
}

class ReceiptPickerScreen extends StatefulWidget {
  static const routeName = '/receipt-picker';

  @override
  State<ReceiptPickerScreen> createState() => _ReceiptPickerScreenState();
}

class _ReceiptPickerScreenState extends State<ReceiptPickerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Transaction>(context).getReceiptPicker().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final receiptPickers = Provider.of<Transaction>(context).receiptPicker;

    Widget getTextWidgets(List<dynamic> strings) {
      return Column(
        children: strings.map((item) {
          if (item['created_at'] == '') return Container();

          return (Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(DateFormat('hh:mm, dd/MM/yyyy')
                          .format(DateTime.parse(item['created_at']))),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Text(
                              'No Resi:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
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
                  subtitle: Row(
                    children: [
                      const Text('Nomor Hp:'),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          item['nomor_hp'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        }).toList(),
      );
    }

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
                        'DAFTAR RESI PICKER',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    getTextWidgets(
                      receiptPickers != null
                          ? (receiptPickers as Map)['resi']
                          : [
                              {
                                'name': '',
                                'no_resi': '',
                                'nomor_hp': '',
                                'created_at': '',
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
