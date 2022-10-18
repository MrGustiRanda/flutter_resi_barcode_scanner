import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:si_resi/providers/settings.dart';
import 'package:si_resi/screens/create_user_screen.dart';
import '../widgets/app_drawer.dart';

import 'package:intl/intl.dart';
import '../providers/transaction.dart';

class CheckerScreen extends StatefulWidget {
  static const routeName = '/checker';

  @override
  State<CheckerScreen> createState() => _CheckerScreenState();
}

class _CheckerScreenState extends State<CheckerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Settings>(context).getChecker().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _showDeleteDialog(String userName, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi!'),
        content: Text('Apakah Anda ingin menghapus username $userName ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Batal'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Theme.of(context).primaryTextTheme.button?.color,
            ),
            onPressed: () {
              Provider.of<Settings>(context, listen: false).deleteChecker(
                id.toString(),
              );

              Navigator.of(context).pushNamed(CheckerScreen.routeName);
              setState(() {
                _isInit = true;
              });
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkers = Provider.of<Settings>(context).checker;

    Widget getTextWidgets(List<dynamic> strings) {
      return Column(
        children: strings.map((item) {
          if (item['created_at'] == '') return Container();

          return (Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Text(
                              'ID:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            item['id'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('hh:mm, dd/MM/yyyy').format(
                          DateTime.parse(item['created_at']),
                        ),
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
                  subtitle: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text('Username:'),
                            ),
                            Expanded(
                              child: Text(
                                item['username'],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text('Email :'),
                            ),
                            Expanded(
                              child: Text(
                                item['email'],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text('Nomor Hp:'),
                            ),
                            Expanded(
                              child: Text(
                                item['nomor_hp'],
                              ),
                            ),
                          ],
                        ),
                        if (item['id'] != 4)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () => _showDeleteDialog(
                                    item['name'], item['id'].toString()),
                                icon: const Icon(Icons.delete),
                                label: const Text('Hapus'),
                                style: TextButton.styleFrom(
                                  primary: Colors.red,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    CreateUserScreen.routeName,
                                    arguments: {
                                      'type': 'Checker',
                                      'id': item['id'],
                                      'name': item['name'],
                                      'username': item['username'],
                                      'email': item['email'],
                                      'phoneNumber': item['nomor_hp'],
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Ubah'),
                                style: TextButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'USERS CHECKER',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  CreateUserScreen.routeName,
                                  arguments: {
                                    'type': 'Checker',
                                  },
                                );
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    getTextWidgets(
                      checkers != null
                          ? (checkers as Map)['users']
                          : [
                              {
                                'id': 0,
                                'name': '',
                                'username': '',
                                'email': '',
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
