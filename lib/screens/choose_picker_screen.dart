import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/http_exeption.dart';
import '../providers/transaction.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  favorites,
  all,
}

class ChoosePickerScreen extends StatefulWidget {
  static const routeName = '/choose-picker';

  @override
  State<ChoosePickerScreen> createState() => _ChoosePickerScreenState();
}

class _ChoosePickerScreenState extends State<ChoosePickerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isInit = true;
  var _isLoading = true;
  var _pickerId = '';
  var _totalReceipt = '';

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

  @override
  Widget build(BuildContext context) {
    final picker = Provider.of<Transaction>(context).picker;

    Future<void> _showSuccessDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success!'),
            content: const Text('Berhasil memilih Picker.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(ChoosePickerScreen.routeName);
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
      if (!_formKey.currentState!.validate()) {
        // Invalid!
        return;
      }

      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<Transaction>(context, listen: false)
            .choosePicker(_totalReceipt, int.parse(_pickerId));

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

    var _pickers = [
      {'id': 0, 'name': ''}
    ];
    if (picker != null) {
      (picker as Map)['picker'].forEach((value) => _pickers.add({
            'id': (value as Map)['id'],
            'name': (value as Map)['name'],
          }));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(36),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Text(
                          'PILIH PICKER',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  // labelStyle: textStyle,
                                  errorStyle: const TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'Please select expense',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              isEmpty: _pickerId == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _pickerId,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _pickerId = newValue ?? '';
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _pickers.map((Map value) {
                                    return DropdownMenuItem<String>(
                                      value: value['id'] == 0
                                          ? ''
                                          : value['id'].toString(),
                                      child: Text(value['name']),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 4),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Jumlah Resi',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Mohon untuk mengisi Jumlah Resi!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            print(value);
                            setState(() {
                              _totalReceipt = value!;
                            });
                          },
                        ),
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
            ),
    );
  }
}
