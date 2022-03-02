import 'package:flutter/material.dart';
import 'package:velo_debug/components/route_generator.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/screens/sign_in/sign_in_screen.dart';
import 'package:velo_debug/screens/test_screen.dart';
import 'package:velo_debug/test.dart';

void main() {
  runApp(MyApp());
  //ErrorWidget.builder = (FlutterErrorDetails details) => Container();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'VELO Debug',
      theme: ThemeData(
        primaryColor: Color(0xFFFFE8D6),
        backgroundColor: Color(0xFF15232B),
        accentColor: Color(0xFFFF4D19),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Color(0xFF333333),
          )
        ),
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}
