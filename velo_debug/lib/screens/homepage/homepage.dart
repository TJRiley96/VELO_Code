import 'package:flutter/material.dart';
import 'package:velo_debug/components/HistoryTab.dart';
import 'package:velo_debug/components/displayUsername.dart';
import 'package:velo_debug/components/graphContainer.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/components/size_config.dart';
import 'package:velo_debug/components/weekTab.dart';
import 'package:velo_debug/globals.dart' as globals;

class HomePage extends StatelessWidget {
  String screen = "/home";

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildContent(context),
      bottomNavigationBar: globals.getConnected()? BottomNavBar(screen: "/chart",) : BottomNavBar(),
    );
  }

  Widget _buildContent(BuildContext context) {
    var sizeConfig = SizeConfig(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO: User Name Display
            DisplayUsername(),
            SizedBox(height: sizeConfig.safeBlockVertical * 2.0,),
            //TODO: History Tab
            HistoryTab(),
            SizedBox(height: sizeConfig.safeBlockVertical * 2.0,),
            //TODO: Day of the Week
            WeekTab(),
            SizedBox(height: sizeConfig.safeBlockVertical * 1.0,),

            //TODO: Graph Container
            GraphContainer(),


          ],
        ),
      ),
    );
  }
}
