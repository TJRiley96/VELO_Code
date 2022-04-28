import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';
import 'package:velo_debug/components/size_config.dart';

class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    SizeConfig size = SizeConfig(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.safeBlockVertical*10,
            ),
            Image(image: AssetImage("assets/icons/icon_velo.png", ), width: size.safeBlockHorizontal*25, height: size.safeBlockVertical*25,),
            Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            // Container(
            //   color: Colors.orange,
            //   child: SizedBox(
            //     height: 100.0,
            //   ),
            // ),
            TextFormField(
              decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      )
                  ),
                  hintText: "Username or Email",
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),

              ),
            ),
            SizedBox(
              height: size.safeBlockVertical*2,
            ),
            // // Container(
            // //   color: Colors.amberAccent,
            // //   child: SizedBox(
            // //     height: 100.0,
            // //   ),
            // // ),
            TextFormField(
              decoration: InputDecoration(
                focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                    )
                ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      )
                  ),
                  hintText: "Password",
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
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
      ),
    );
  }
}
