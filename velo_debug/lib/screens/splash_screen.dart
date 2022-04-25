import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:velo_debug/screens/sign_in/sign_in_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      backgroundColor: Theme.of(context).backgroundColor,
      splash: 'assets/icons/logo_barbell.png',
      nextScreen: SignInScreen(),
      splashTransition: SplashTransition.fadeTransition,
      //pageTransitionType: PageTransitionsType.,
    );
  }
}
