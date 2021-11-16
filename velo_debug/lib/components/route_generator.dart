import 'package:flutter/material.dart';

import 'package:velo_debug/main.dart';
import 'package:velo_debug/screens/bluetooth/ble_build.dart';
import 'package:velo_debug/screens/settings/settings_screen.dart';
import 'package:velo_debug/screens/sign_in/sign_in_screen.dart';
import 'package:velo_debug/screens/homepage/homepage.dart';
import 'package:velo_debug/screens/test_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/bluetooth':
        return MaterialPageRoute(builder: (_) => BluetoothScreen());
      case '/test':
        return MaterialPageRoute(builder: (_) => TestScreen());
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}