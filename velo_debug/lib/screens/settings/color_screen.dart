import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/globals.dart';

class ColorSetScreen extends StatefulWidget {
  ColorSetScreen({Key? key}) : super(key: key);

  @override
  State<ColorSetScreen> createState() => _ColorSetScreenState();
}

class _ColorSetScreenState extends State<ColorSetScreen> {
  int _color = 0;

  Future<void> setup() async {
    var i = await getColor();
    _color = i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Color Blindness Mode")),
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: BottomNavBar(),
        body: Center(
        child: _button()));
  }

  Widget _button() {
    setup();
    return Column(children: <Widget>[
      ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: const Text('Default'),
        leading: Radio(
            value: 0,
            groupValue: _color,
            onChanged: (int) {
              _color = 0;
              writeColor(0);
            }),
      ),
      ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: const Text('www.javatpoint.com'),
        leading: Radio(
            value: 1,
            groupValue: _color,
            onChanged: (int) {
              _color = 1;
              writeColor(1);
            }),
      ),
      ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: const Text('www.javatpoint.com'),
        leading: Radio(
            value: 2,
            groupValue: _color,
            onChanged: (int) {
              _color = 2;
              writeColor(2);
            }),
      ),
    ]);
  }
}
