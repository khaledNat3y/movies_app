import 'package:flutter/material.dart';
import 'package:movies/prvider/listprovider.dart';
import 'package:movies/ui/tabs/tab_favourit/filmwidget.dart';
import 'package:provider/provider.dart';

import '../../../model/model.dart';
import '../../../utils/app-color.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late Listprovider provider;

  @override
  void initState() {
    super.initState();
    // Fetch films from Firestore once the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getFilmsFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the provider instance from the context
    provider = Provider.of<Listprovider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title of the "Watchlist" section
        Container(
          padding: EdgeInsets.all(10),
          child: const Text(
            "Watchlist",
            style: TextStyle(color: Colors.white, fontSize: 35),
            textAlign: TextAlign.left,
          ),
        ),
        // Expanded widget to take the rest of the available space
        Expanded(
          child: ListView.builder(
            // Use the length of the films list as item count
            itemCount: provider.films.length,
            // Create a Filmwidget for each film in the list
            itemBuilder: (context, index) {
              return Filmwidget(film: provider.films[index]);
            },
          ),
        ),
      ],
    );
  }
}
