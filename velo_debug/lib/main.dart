import 'package:flutter/material.dart';
import 'package:velo_debug/components/route_generator.dart';
import 'package:velo_debug/globals.dart' as globals;

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
        primaryColor: Color(globals.ColorSchemeData[0][0]),
        backgroundColor: Color(globals.ColorSchemeData[0][1]),
        accentColor: Color(globals.ColorSchemeData[0][2]),
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
