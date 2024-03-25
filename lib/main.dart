import 'package:flutter/material.dart';
import 'package:movies/ui/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Homescreen.routeName: (_) => Homescreen(),
      },
      initialRoute: Homescreen.routeName,
    );
  }
}

