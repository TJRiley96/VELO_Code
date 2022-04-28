import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_debug/components/route_generator.dart';
import 'package:velo_debug/components/theme_mode.dart';
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
  int _color = 0;

  @override
  void initState() {
    super.initState();
    setup();
  }

  Future<void> setup() async {
    var i = await globals.getColor();
    _color = i;
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'VELO Debug',
              theme: Provider
                  .of<ThemeProvider>(context)
                  .current,
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,

            );
          }
      );
}
