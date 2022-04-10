import 'package:flutter/material.dart';
import 'package:velo_debug/components/route_generator.dart';
import 'package:velo_debug/globals.dart' as globals;

void main() {
  globals.initializeGlobals();
  runApp(MyApp());
  //ErrorWidget.builder = (FlutterErrorDetails details) => Container();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _color =  0;
  @override
  void initState(){
    super.initState();
    setup();
  }
  Future<void> setup() async{
    var i = await globals.getColor();
    _color = i;
}
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'VELO Debug',
      theme: ThemeData(
        primaryColor: Color(globals.ColorSchemeData[_color][0]),
        backgroundColor: Color(globals.ColorSchemeData[_color][1]),
        accentColor: Color(globals.ColorSchemeData[_color][2]),
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
