import 'package:flutter/material.dart';
import 'package:velo_debug/components/HistoryTab.dart';
import 'package:velo_debug/components/displayUsername.dart';
import 'package:velo_debug/components/graphContainer.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/components/weekTab.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildContent(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO: User Name Display
            DisplayUsername(),
            SizedBox(height: 20.0,),
            //TODO: History Tab
            HistoryTab(),
            SizedBox(height: 20.0,),
            //TODO: Day of the Week
            WeekTab(),
            SizedBox(height: 10.0,),

            //TODO: Graph Container
            GraphContainer(),


          ],
        ),
      ),
    );
  }
}
