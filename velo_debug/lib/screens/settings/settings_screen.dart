import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class SettingsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Setting"),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: _buildContent(context),
    );
  }
  Widget _buildContent(BuildContext context){
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
            ),
              onPressed: (){
                Navigator.of(context).pushNamed('/bluetooth');
              },
              child: SizedBox(
                height: 75.0,
                child: Text("Bluetooth",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor
                ),
                ),
              ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
            ),
              onPressed: (){
                Navigator.of(context).pushNamed('/settings/color');
              },
              child: Text("Colorblind Mode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).primaryColor
                ),
              ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
            ),
              onPressed: (){
                Navigator.of(context).pushNamed('/test');
              },
              child: Text("Test Screen",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).primaryColor
                ),
              ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
            ),
            onPressed: (){
              Navigator.of(context).pushNamed('/chart');
            },
            child: Text("Chart Screen",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
            ),
            onPressed: (){
              Navigator.of(context).pushNamed('/chart2');
            },
            child: Text("Chart Screen 2",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColor
              ),
            ),
          ),
        ],
      ),
    );
}
}