import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../screens/checker_scan_receipt_screen.dart';
import '../screens/checker_screen.dart';
import '../screens/choose_picker_screen.dart';
import '../screens/handoffer_scan_receipt_screen.dart';
import '../screens/handoffer_screen.dart';
import '../screens/picker_screen.dart';
import '../screens/receipt_checker_screen.dart';
import '../screens/receipt_handoffer_screen.dart';
import '../screens/receipt_picker_screen.dart';
import '../screens/scan_receipt_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context).me as Map;

    Widget adminDrawer() {
      return Drawer(
        child: Column(
          children: [
            AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(auth['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(auth['default_role'],
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                ],
              ),
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Scan Resi'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ScanReceiptScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('Pilih Picker'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ChoosePickerScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Resi Picker'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ReceiptPickerScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_alt_rounded),
              title: const Text('Picker'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(PickerScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_alt_rounded),
              title: const Text('Checker'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CheckerScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people_alt_rounded),
              title: const Text('Handoffer'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HandofferScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      );
    }

    Widget pickerDrawer() {
      return Drawer(
        child: Column(
          children: [
            AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(auth['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(auth['default_role'],
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                ],
              ),
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Resi Picker'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ReceiptPickerScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      );
    }

    Widget checkerDrawer() {
      return Drawer(
        child: Column(
          children: [
            AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(auth['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(auth['default_role'],
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                ],
              ),
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Scan Resi'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CheckerScanReceiptScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Resi Checker'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ReceiptCheckerScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      );
    }

    Widget handofferDrawer() {
      return Drawer(
        child: Column(
          children: [
            AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(auth['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(auth['default_role'],
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                ],
              ),
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Scan Resi'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HandofferScanReceiptScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Resi Handoffer'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ReceiptHandofferScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      );
    }

    return auth['default_role'] == 'admin'
        ? adminDrawer()
        : auth['default_role'] == 'picker'
            ? pickerDrawer()
            : auth['default_role'] == 'checker'
                ? checkerDrawer()
                : handofferDrawer();
  }
}
