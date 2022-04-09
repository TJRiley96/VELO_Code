import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("VELO Debug"),
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavBar(),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
          Container(
            color: Colors.orange,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            color: Colors.amberAccent,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          Text(
            "or",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed('home');
          }, child: Text("Skip for now")),
        ],
      ),
    );
  }
}
