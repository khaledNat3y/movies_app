import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/listprovider.dart';
import 'filmwidget.dart';

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

    if (provider.films.isEmpty) {
      return const Center(
        child: Text(
          'No films in your watchlist.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Return the list of films
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Watchlist",
            style: TextStyle(color: Colors.white, fontSize: 35),
            textAlign: TextAlign.left,
          ),
        ),
        // Wrap the ListView.builder in an Expanded widget
        Expanded(
          child: ListView.builder(
            itemCount: provider.films.length,
            itemBuilder: (context, index) {
              final film = provider.films[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Film image on the left side
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        film.path, // URL of the film's image
                        width: 100, // Adjust the width as needed
                        height: 120, // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10, // Space between the image and text
                    ),
                    // Film information on the right side
                    Expanded( // Use Expanded to allow the text to fill the remaining width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Film title
                          Text(
                            film.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                          ),
                          // Film date
                          Text(
                            film.date,
                            style: const TextStyle(color: Colors.white),
                          ),
                          // Film overview, truncated to one line
                          Text(
                            film.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
