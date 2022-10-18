import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:si_resi/models/http_exeption.dart';
import 'package:si_resi/providers/settings.dart';
import 'package:si_resi/screens/checker_screen.dart';
import 'package:si_resi/screens/handoffer_screen.dart';
import 'package:si_resi/screens/picker_screen.dart';
import '../widgets/app_drawer.dart';

import 'package:intl/intl.dart';
import '../providers/transaction.dart';

class CreateUserScreen extends StatefulWidget {
  static const routeName = '/create-user';

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final Map<String, String> _userData = {
    'name': '',
    'username': '',
    'email': '',
    'phoneNumber': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

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

  Future<void> _submitCreate(String type) async {
    _formKey.currentState!.save();

    if (type == 'Picker') {
      try {
        await Provider.of<Settings>(context, listen: false).createPicker(
          _userData['name'] as String,
          _userData['username'] as String,
          _userData['email'] as String,
          _userData['phoneNumber'] as String,
          _userData['password'] as String,
        );

        await Navigator.of(context).pushNamed(PickerScreen.routeName);
      } on HttpExeption catch (error) {
        var errorMessage = 'Gagal';
        if (error.toString().contains('Unauthorized')) {
          errorMessage = 'Username atau Email atau Nomor HP telah digunakan.';
        }

        _showErrorDialog(
            error.toString() != '' ? error.toString() : errorMessage);
      } catch (error) {
        var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
        _showErrorDialog(errorMessage);
      }
    } else if (type == 'Checker') {
      try {
        await Provider.of<Settings>(context, listen: false).createChecker(
          _userData['name'] as String,
          _userData['username'] as String,
          _userData['email'] as String,
          _userData['phoneNumber'] as String,
          _userData['password'] as String,
        );

        await Navigator.of(context).pushNamed(CheckerScreen.routeName);
      } on HttpExeption catch (error) {
        var errorMessage = 'Gagal';
        if (error.toString().contains('Unauthorized')) {
          errorMessage = 'Username atau Email atau Nomor HP telah digunakan.';
        }

        _showErrorDialog(
            error.toString() != '' ? error.toString() : errorMessage);
      } catch (error) {
        var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
        _showErrorDialog(errorMessage);
      }
    } else if (type == 'Handoffer') {
      try {
        await Provider.of<Settings>(context, listen: false).createHandoffer(
          _userData['name'] as String,
          _userData['username'] as String,
          _userData['email'] as String,
          _userData['phoneNumber'] as String,
          _userData['password'] as String,
        );

        await Navigator.of(context).pushNamed(HandofferScreen.routeName);
      } on HttpExeption catch (error) {
        var errorMessage = 'Gagal';
        if (error.toString().contains('Unauthorized')) {
          errorMessage = 'Username atau Email atau Nomor HP telah digunakan.';
        }

        _showErrorDialog(
            error.toString() != '' ? error.toString() : errorMessage);
      } catch (error) {
        var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
        _showErrorDialog(errorMessage);
      }
    }
  }

  Future<void> _submitUpdate(String type, String id) async {
    _formKey.currentState!.save();

    if (type == 'Picker') {
      try {
        await Provider.of<Settings>(context, listen: false).updatePicker(
          id.toString(),
          _userData['name'] as String,
          _userData['username'] as String,
          _userData['email'] as String,
          _userData['phoneNumber'] as String,
          _userData['password'] as String,
        );

        await Navigator.of(context).pushNamed(PickerScreen.routeName);
      } on HttpExeption catch (error) {
        var errorMessage = 'Gagal';
        if (error.toString().contains('Unauthorized')) {
          errorMessage = 'Username atau Email atau Nomor HP telah digunakan.';
        }

        _showErrorDialog(
            error.toString() != '' ? error.toString() : errorMessage);
      } catch (error) {
        var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
        _showErrorDialog(errorMessage);
      }
    } else if (type == 'Checker') {
      try {
        await Provider.of<Settings>(context, listen: false).updateChecker(
          id.toString(),
          _userData['name'] as String,
          _userData['username'] as String,
          _userData['email'] as String,
          _userData['phoneNumber'] as String,
          _userData['password'] as String,
        );

        await Navigator.of(context).pushNamed(CheckerScreen.routeName);
      } on HttpExeption catch (error) {
        var errorMessage = 'Gagal';
        if (error.toString().contains('Unauthorized')) {
          errorMessage = 'Username atau Email atau Nomor HP telah digunakan.';
        }

        _showErrorDialog(
            error.toString() != '' ? error.toString() : errorMessage);
      } catch (error) {
        var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
        _showErrorDialog(errorMessage);
      }
    } else if (type == 'Handoffer') {
      try {
        await Provider.of<Settings>(context, listen: false).updateHandoffer(
          id.toString(),
          _userData['name'] as String,
          _userData['username'] as String,
          _userData['email'] as String,
          _userData['phoneNumber'] as String,
          _userData['password'] as String,
        );

        await Navigator.of(context).pushNamed(HandofferScreen.routeName);
      } on HttpExeption catch (error) {
        var errorMessage = 'Gagal';
        if (error.toString().contains('Unauthorized')) {
          errorMessage = 'Username atau Email atau Nomor HP telah digunakan.';
        }

        _showErrorDialog(
            error.toString() != '' ? error.toString() : errorMessage);
      } catch (error) {
        var errorMessage = 'Tidak bisa mengenal anda. Coba lagi lain kali.';
        _showErrorDialog(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userType =
        (ModalRoute.of(context)!.settings.arguments as Map)['type'] as String;

    final userData = ModalRoute.of(context)!.settings.arguments as Map;

    if (userData['id'] != null) {
      _userData['name'] = userData['name'];
      _userData['username'] = userData['username'];
      _userData['email'] = userData['email'];
      _userData['phoneNumber'] = userData['phoneNumber'];

      _nameController = TextEditingController(text: userData['name']);
      _usernameController = TextEditingController(text: userData['username']);
      _emailController = TextEditingController(text: userData['email']);
      _phoneNumberController =
          TextEditingController(text: userData['phoneNumber']);
    }

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
      body: Container(
        padding: const EdgeInsets.all(36),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    (userData['id'] != null ? 'UPDATE' : 'CREATE') +
                        ' USER ' +
                        userType.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 4),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid name!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userData['name'] = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid username!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userData['username'] = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userData['email'] = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nomor HP',
                    ),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid phoneNumber!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userData['phoneNumber'] = value!;
                    },
                  ),
                ),
                if (userData['id'] == null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _userData['password'] = value!;
                      },
                    ),
                  ),
                ElevatedButton(
                  child: const Text(
                    'Submit',
                  ),
                  onPressed: () => userData['id'] == null
                      ? _submitCreate(userType)
                      : _submitUpdate(userType, userData['id'].toString()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Theme.of(context).primaryTextTheme.button?.color,
                    minimumSize: const Size.fromHeight(50),
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
