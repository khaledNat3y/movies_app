import 'package:flutter/material.dart';
import 'package:movies/ui/home.dart';
import 'package:movies/ui/tabs/firestpage/detailfilmscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Homescreen.routeName: (_) => const Homescreen(),
        Detailfilmscreen.routeName: (_) => const Detailfilmscreen(),
      },
      initialRoute: Homescreen.routeName,
    );
  }
}
