import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/components/size_config.dart';

class SettingsScreen extends StatelessWidget{

  ButtonStyle btnStyle(BuildContext context){
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: BottomNavBar(),
      body: _buildContent(context),
    );
  }
  Widget _buildContent(BuildContext context){
    SizeConfig size = SizeConfig(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: size.safeBlockVertical*10,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/bluetooth');
                },
              style: btnStyle(context),
              child: Text("Bluetooth",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
                  ),
                ),
            ),
          SizedBox(height: size.safeBlockVertical*1,),
          SizedBox(
            height: size.safeBlockVertical*10,
            child: ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/settings/color');
                },
              style: btnStyle(context),
                child: Text("Colorblind Mode",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
            ),
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/test');
              },
            style: btnStyle(context),
              child: Text("Test Screen"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/chart');
            },
            style: btnStyle(context),
            child: Text("VELO CHART"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/settings/multi');
            },
            style: btnStyle(context),
            child: Text("Battery Chart"),
          ),
        ],
      ),
    );
}
}