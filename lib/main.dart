import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/prvider/listprovider.dart';
import 'package:movies/ui/home.dart';
import 'package:movies/ui/tabs/firestpage/detailfilmscreen.dart';
import 'package:movies/ui/tabs/tab_moves/Moviecaroctroy.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (_)=>Listprovider(),
      child: const MyApp()));
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
        Moviecatogery.routeName: (_) => const Moviecatogery(),
      },
      initialRoute: Homescreen.routeName,
    );
  }
}
