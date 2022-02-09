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
                icon: const Icon(Icons.account_circle)),
            IconButton(
                tooltip: 'Timer',
                onPressed: (){},
                icon: const Icon(Icons.timer_outlined)),
            IconButton(
              tooltip: 'VELO Icon',
              onPressed: (){
                Navigator.of(context).pushNamed('home');
              },
              icon: const Icon(Icons.circle)),
            IconButton(
                tooltip: 'Setting Menu',
                onPressed: (){
                  Navigator.of(context).pushNamed('/settings');
                },
                icon: const Icon(Icons.settings)),
            IconButton(
                tooltip: 'Notes',
                onPressed: (){},
                icon: const Icon(Icons.description_outlined))

          ],
        ),
      )
    );
    throw UnimplementedError();
  }
}