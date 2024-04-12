import 'package:flutter/material.dart';
import 'package:movies/prvider/listprovider.dart';
import 'package:movies/ui/tabs/tab_favourit/filmwidget.dart';
import 'package:provider/provider.dart';

import '../../../model/model.dart';
import '../../../utils/app-color.dart';

class Favorite extends StatefulWidget {

  const Favorite({super.key, });

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late Listprovider provider;
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getFilmsFromFirestore();

    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: const Text(
            "Watchlist",
            style: TextStyle(color: Colors.white, fontSize: 35),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: provider.films.length,
                itemBuilder: (context, index) {
                  return Filmwidget(film: provider.films[index]);

                }))
      ],
    );
  }

}
