import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: _buildContent(context),
    );
  }

  Widget _buildContent(context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.orangeAccent,
      ),

      child: SizedBox(
        height: 40.0,
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
