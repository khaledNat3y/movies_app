import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/prvider/listprovider.dart';
import 'package:movies/ui/home.dart';
import 'package:movies/ui/tabs/firestpage/detailfilmscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase before using any Firebase services
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyAHFvRvS-C3M09zE2YmrIzjDnKZjq-JlAQ",
      appId: "movies-app-9917c",
      messagingSenderId: "movies-app-9917c",
      projectId: "movies-app-9917c"));

  runApp(
    ChangeNotifierProvider(
      create: (_) => Listprovider(),
      child: const MyApp(),
    ),
  );
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
