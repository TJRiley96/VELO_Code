import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/components/theme_mode.dart';
import "package:provider/provider.dart";
import 'package:velo_debug/globals.dart';



class ColorSetScreen extends StatefulWidget {
  ColorSetScreen({Key? key}) : super(key: key);

  @override
  State<ColorSetScreen> createState() => _ColorSetScreenState();
}

class _ColorSetScreenState extends State<ColorSetScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Color Blindness Mode"), backgroundColor: Theme.of(context).accentColor,),
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: BottomNavBar(),
        body: Center(
        child: _button(context)));
  }

  Widget _button(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Column(children: <Widget>[

      RadioListTile<ThemeData>(
        tileColor: Theme.of(context).primaryColor,
        title: const Text('Default'),
        value: ThemeModeSet.standard,
        groupValue: theme.current,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context,listen: false);
          provider.toggleTheme(value!);

        }),
      RadioListTile<ThemeData>(
          tileColor: Theme.of(context).primaryColor,
          title: const Text('Pastel'),
          value: ThemeModeSet.pastel,
          groupValue: theme.current,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context,listen: false);
            provider.toggleTheme(value!);

          }),
      RadioListTile<ThemeData>(
          tileColor: Theme.of(context).primaryColor,
          title: const Text('Pretty in pink'),
          value: ThemeModeSet.pip,
          groupValue: theme.current,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context,listen: false);
            provider.toggleTheme(value!);

          }),
      RadioListTile<ThemeData>(
        tileColor: Theme.of(context).primaryColor,
        title: const Text("Protanopia"),
        value: ThemeModeSet.protanopia,
        groupValue: theme.current,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context,listen: false);
          provider.toggleTheme(value!);
        }
        ),
      RadioListTile<ThemeData>(
          tileColor: Theme.of(context).primaryColor,
          title: const Text("Deuteranopia"),
          value: ThemeModeSet.deuteranopia,
          groupValue: theme.current,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context,listen: false);
            provider.toggleTheme(value!);
          }
      ),
      RadioListTile<ThemeData>(
          tileColor: Theme.of(context).primaryColor,
          title: const Text("Tritopia"),
          value: ThemeModeSet.tritopia,
          groupValue: theme.current,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context,listen: false);
            provider.toggleTheme(value!);
          }
      ),
      RadioListTile<ThemeData>(
        tileColor: Theme.of(context).primaryColor,
        title: const Text('Proanomaly'),
        value: ThemeModeSet.proanomaly,
        groupValue: theme.current,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context,listen: false);
          provider.toggleTheme(value!);
        }
        ),
    ]);

  }
}
