import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:si_resi/providers/settings.dart';
import 'package:si_resi/screens/checker_screen.dart';
import 'package:si_resi/screens/create_user_screen.dart';
import 'package:si_resi/screens/handoffer_screen.dart';
import 'package:si_resi/screens/picker_screen.dart';

import './providers/auth.dart';
import './providers/transaction.dart';

import './screens/dashboard.dart';
import './screens/auth_screen.dart';
import './screens/loading_screen.dart';
import './screens/splash_screen.dart';
import './screens/scan_receipt_screen.dart';
import './screens/choose_picker_screen.dart';
import './screens/receipt_picker_screen.dart';
import './screens/checker_scan_receipt_screen.dart';
import './screens/receipt_checker_screen.dart';
import './screens/receipt_handoffer_screen.dart';
import './screens/handoffer_scan_receipt_screen.dart';

import 'helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Settings>(
          create: (ctx) => Settings(null),
          update: (ctx, auth, _) => Settings(auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, Transaction>(
          create: (ctx) => Transaction(null),
          update: (ctx, auth, _) => Transaction(auth.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primaryColor: const Color(0xff283593),
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransactionBuilder(),
                TargetPlatform.iOS: CustomPageTransactionBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? DashboardScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? LoadingScreen()
                          : SplashScreen(),
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            CreateUserScreen.routeName: (ctx) => CreateUserScreen(),
            PickerScreen.routeName: (ctx) => PickerScreen(),
            CheckerScreen.routeName: (ctx) => CheckerScreen(),
            HandofferScreen.routeName: (ctx) => HandofferScreen(),
            ScanReceiptScreen.routeName: (ctx) => ScanReceiptScreen(),
            ChoosePickerScreen.routeName: (ctx) => ChoosePickerScreen(),
            ReceiptPickerScreen.routeName: (ctx) => ReceiptPickerScreen(),
            CheckerScanReceiptScreen.routeName: (ctx) =>
                CheckerScanReceiptScreen(),
            ReceiptCheckerScreen.routeName: (ctx) => ReceiptCheckerScreen(),
            HandofferScanReceiptScreen.routeName: (ctx) =>
                HandofferScanReceiptScreen(),
            ReceiptHandofferScreen.routeName: (ctx) => ReceiptHandofferScreen(),
          },
        ),
      ),
    );
  }
}
