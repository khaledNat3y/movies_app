import 'dart:async';
import 'package:flutter/services.dart';
import 'package:movies/ui/home.dart';

import 'package:flutter/material.dart';
class SplashView extends StatefulWidget {
  static const String routeName = "Splash";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, Homescreen.routeName);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset(
        "assets/splash.png",
        height: mediaQuery.height,
        width: mediaQuery.width,
        fit: BoxFit.cover,
      ),
    );
  }
}