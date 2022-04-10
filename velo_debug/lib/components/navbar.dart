import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                tooltip: 'Profile',
                onPressed: (){},
                icon: const Image(image: AssetImage('assets/icons/icon_profile.png'),)),
            IconButton(
                tooltip: 'Timer',
                onPressed: (){},
                icon: Image.asset('assets/icons/icon_timer.png', scale: 1.5,)
            ),
            IconButton(
              tooltip: 'VELO Icon',
              onPressed: (){
                Navigator.of(context).pushNamed('home');
              },
              //icon: const Icon(Icons.circle)),
              icon: const Image(image: AssetImage('assets/icons/icon_velo_dark.png'),)),
            IconButton(
                tooltip: 'Setting Menu',
                onPressed: (){
                  Navigator.of(context).pushNamed('/settings');
                },
                icon: const Image(image: AssetImage('assets/icons/icon_settings.png'),)),
            IconButton(
                tooltip: 'Notes',
                onPressed: (){},
                icon: const Image(image: AssetImage('assets/icons/icon_notes.png'),))

          ],
        ),
      )
    );
  }
}