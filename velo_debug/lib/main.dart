import 'package:flutter/material.dart';
import 'package:velo_debug/components/route_generator.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/screens/sign_in/sign_in_screen.dart';
import 'package:velo_debug/screens/test_screen.dart';
import 'package:velo_debug/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VELO Debug',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}
