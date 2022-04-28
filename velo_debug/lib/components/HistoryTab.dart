import 'package:flutter/material.dart';
import 'package:velo_debug/components/size_config.dart';
import 'package:velo_debug/components/size_config.dart';

class HistoryTab extends StatelessWidget {
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: size.safeBlockVertical * 5.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildTab(context),
    );
  }
  
  Widget _buildTab(context){

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: TabBar(
        indicator: BoxDecoration(

          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
          tabs: <Widget> [
        Tab(
          child: Text(
            "Today",
            style: TextStyle(
              color: Theme.of(context).accentColor
            ),
          ),
        ),
        Tab(
          child: Text(
            "History",
            style: TextStyle(
                color: Theme.of(context).accentColor
            ),
          ),
        )
        ]
      ),
    );
  }
  Widget _buildContent(context) {
    var sizeConfig = SizeConfig(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
      ),

      child: SizedBox(
        height: sizeConfig.safeBlockVertical * 5.0,
        child: Text(
          "Imagine A Really Nice Box Here!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
