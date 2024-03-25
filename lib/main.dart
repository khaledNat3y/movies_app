import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:movies_app/ui/home.dart';
=======
import 'package:movies/ui/Home/homescreen.dart';
>>>>>>> fbf82f54a4ceea8d0041709c2b241e64546ffaf1

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
        Home.routeName: (_) => Home(),
      },
      initialRoute: Home.routeName,
    );
  }
}

