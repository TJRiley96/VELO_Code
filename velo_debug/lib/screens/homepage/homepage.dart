import 'package:flutter/material.dart';
import 'package:velo_debug/components/navbar.dart';

class HomePage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
    );
  }
}