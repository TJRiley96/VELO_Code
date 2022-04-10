import 'package:flutter/material.dart';

import 'package:velo_debug/main.dart';
import 'package:velo_debug/screens/bluetooth/ble_build.dart';
import 'package:velo_debug/screens/settings/color_screen.dart';
import 'package:velo_debug/screens/settings/settings_screen.dart';
import 'package:velo_debug/screens/sign_in/sign_in_screen.dart';
import 'package:velo_debug/screens/homepage/homepage.dart';
import 'package:velo_debug/screens/splash_screen.dart';
import 'package:velo_debug/screens/stream_chart.dart';
import 'package:velo_debug/screens/stream_chart2.dart';
import 'package:velo_debug/screens/stream_screen.dart';
import 'package:velo_debug/screens/test_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/settings/color':
        return MaterialPageRoute(builder: (_) => ColorSetScreen());
      case '/bluetooth':
        return MaterialPageRoute(builder: (_) => BluetoothScreen());
      case '/test':
        return MaterialPageRoute(builder: (_) => TestScreen());
      case '/stream':
        return MaterialPageRoute(builder: (_) => StreamScreen());
      case '/chart':
        return MaterialPageRoute(builder: (_) => StreamChart());
      case '/chart2':
        return MaterialPageRoute(builder: (_) => StreamChartAgain());
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