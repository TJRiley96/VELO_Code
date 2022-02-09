import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class SettingsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: _buildContent(context),
    );
  }
  Widget _buildContent(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/bluetooth');
              },
              child: SizedBox(
                height: 75.0,
                child: Text("Bluetooth",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
                ),
              ),
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/stream');
              },
              child: Text("Colorblind Mode"),
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/test');
              },
              child: Text("Test Screen"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/chart');
            },
            child: Text("Chart Screen"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/chart2');
            },
            child: Text("Chart Screen 2"),
          ),
        ],
      ),
    );
}
}