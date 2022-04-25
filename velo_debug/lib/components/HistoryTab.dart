import 'package:flutter/material.dart';
import 'package:velo_debug/components/size_config.dart';

class HistoryTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: _buildContent(context),
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
