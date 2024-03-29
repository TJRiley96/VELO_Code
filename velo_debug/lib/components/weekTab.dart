import 'package:flutter/material.dart';
import 'package:velo_debug/components/size_config.dart';

class WeekTab extends StatelessWidget {
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
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        height: sizeConfig.safeBlockVertical * 13.0,
        child: Column(
          children: <Widget>[
            Text(
              "November 29, 2021",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Futura',
                fontSize: sizeConfig.safeBlockVertical * 4.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    tooltip: 'Sunday',
                    onPressed: (){},
                    icon: const Icon(Icons.check_box_outlined)),
                IconButton(
                    tooltip: 'Monday',
                    onPressed: (){},
                    icon: const Icon(Icons.check_box_outline_blank),
                ),
                IconButton(
                  tooltip: 'Tuesday',
                  onPressed: (){},
                  icon: const Icon(Icons.check_box_outline_blank,),
                ),
                IconButton(
                  tooltip: 'Wednesday',
                  onPressed: (){},
                  icon: const Icon(Icons.check_box_outline_blank,),
                ),
                IconButton(
                  tooltip: 'Thursday',
                  onPressed: (){},
                  icon: const Icon(Icons.check_box_outline_blank,),
                ),
                IconButton(
                  tooltip: 'Friday',
                  onPressed: (){},
                  icon: const Icon(Icons.check_box_outline_blank,),
                ),
                IconButton(
                  tooltip: 'Saturday',
                  onPressed: (){},
                  icon: const Icon(Icons.check_box_outline_blank,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
