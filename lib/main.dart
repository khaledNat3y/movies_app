import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/ui/home.dart';
import 'package:movies/ui/tabs/firestpage/detailfilmscreen.dart';

import 'firebase_options.dart';
void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Homescreen.routeName: (_) => Homescreen(),
        Detailfilmscreen.routeName: (_) => Detailfilmscreen(),
      },
      initialRoute: Homescreen.routeName,
    );
  }
}
