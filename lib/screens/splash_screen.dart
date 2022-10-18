import 'package:flutter/material.dart';
import '../screens/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        height: deviceSize.height,
        width: deviceSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 86, horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 128.0),
                  child: Text(
                    'Si Resi',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline6?.color,
                      fontSize: 50,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  child: const Text(
                    'Selanjutnya',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                    primary: Theme.of(context).primaryTextTheme.button?.color,
                    onPrimary: Theme.of(context).primaryColor,
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
