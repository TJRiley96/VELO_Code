import 'package:flutter/material.dart';
import 'package:velo_debug/components/size_config.dart';

class DisplayUsername extends StatelessWidget {
  Widget build(BuildContext context) {

    return Container(
      child: _buildContent(context),
    );
  }

  Widget _buildContent(context) {
    var sizeConfig = SizeConfig(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),

      child: SizedBox(
        height: sizeConfig.safeBlockVertical * 5,
        child: Text(
          "Hi, John!",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: sizeConfig.safeBlockVertical * 4.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
