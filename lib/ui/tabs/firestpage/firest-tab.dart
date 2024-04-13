import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/api_manger.dart';
import 'package:movies/model/data-film.dart';
import 'package:movies/prvider/listprovider.dart';
import 'package:movies/ui/commenwidget/errorviwe.dart';
import 'package:movies/utils/app-color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../commenwidget/apploader.dart';
import 'detailfilmscreen.dart';

class firesttab extends StatefulWidget {
  const firesttab({Key? key}) : super(key: key);

  @override
  State<firesttab> createState() => _firesttabState();
}

class _firesttabState extends State<firesttab> {
  late Listprovider provider;
  final String baseUrl = "https://image.tmdb.org/t/p/w500/";
  final Map<String, bool> bookmarks = {}; // Map to track bookmark state for each film

  @override
  void initState() {
    super.initState();
    loadBookmarks(); // Load bookmarks from shared preferences
  }

  void loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    // Load all saved bookmarks
    final bookmarkKeys = prefs.getKeys();
    setState(() {
      bookmarks.clear();
      for (String key in bookmarkKeys) {
        bookmarks[key] = prefs.getBool(key) ?? false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<Listprovider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildFeaturedFilm(),
          const SizedBox(height: 5),
          buildFilmList(ApiManager.newRelease(), "New Releases"),
          const SizedBox(height: 25),
          buildFilmList(ApiManager.recommended(), "Recommended"),
        ],
      ),
    );
  }

  Widget buildFeaturedFilm() {
    return FutureBuilder(
      future: ApiManager.popularFilm(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorviwe(error: 'Something went wrong');
        } else if (snapshot.hasData) {
          var film = snapshot.data!.results!.first;
          // Initialize bookmarks map if not already present
          if (!bookmarks.containsKey(film.title)) {
            bookmarks[film.title!] = false;
          }

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Detailfilmscreen.routeName,
                  arguments: datafilm(
                    titel: film.title ?? " ",
                    path: "$baseUrl${film.backdropPath}",
                    content: film.overview ?? " ",
                    date: film.releaseDate ?? " ",
                    issave: false,
                    rate: film.voteAverage.toString(),
                  )
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        "$baseUrl${film.backdropPath}",
                        height: 217,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        film.originalTitle ?? " ",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        film.releaseDate ?? " ",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  const Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_circle,
                          size: 60,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: filmWidget(film, film.title ?? " "),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const apploader();
        }
      },
    );
  }

  Widget buildFilmList(Future<dynamic> future, String title) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorviwe(error: 'Something went wrong');
        } else if (snapshot.hasData) {
          return Container(
            height: 200,
            color: AppColors.containerColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (context, index) {
                      var film = snapshot.data!.results![index];

                      // Initialize bookmark state for the film
                      if (!bookmarks.containsKey(film.title)) {
                        bookmarks[film.title] = false;
                      }

                      if (title == "Recommended") {
                        return detailsFilm(
                            "$baseUrl${film.backdropPath}",
                            film.originalTitle ?? " ",
                            film.voteAverage.toString(),
                            film.releaseDate ?? " ",
                            film.overview ?? " ");
                      } else if (title == "New Releases") {
                        return filmWidget(film, film.title ?? " ");
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const apploader();
        }
      },
    );
  }

  Widget filmWidget(dynamic film, String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Detailfilmscreen.routeName,
                    arguments: datafilm(
                        titel: film.title ?? " ",
                        path: "$baseUrl${film.backdropPath}",
                        content: film.overview ?? " ",
                        date: film.releaseDate ?? " ",
                        issave: false,
                        rate: film.voteAverage.toString()
                    )
                );
              },
              child: Image.network(
                "$baseUrl${film.backdropPath}",
                width: 120,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Bookmark icon at the top left corner
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                handleBookmarkToggle(film.title ?? " ", "$baseUrl${film.backdropPath}", film.overview ?? " ", film.releaseDate ?? " ");
              },
              child: Image.asset(
                bookmarks[title]! ? "assets/bookmarktrue.png" : "assets/bookmark.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsFilm(String path, String name, String rate, String date, String overView) {
    return Container(
      width: 100,
      height: 170,
      color: AppColors.gray,
      margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Detailfilmscreen.routeName,
                      arguments: datafilm(
                          titel: name,
                          path: path,
                          content: overView ?? " ",
                          date: date,
                          issave: false,
                          rate: rate
                      )
                  );
                },
                child: Image.network(
                  path,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Image.asset("assets/star-2.png", height: 16, width: 16),
                  Text(
                    rate,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          // Bookmark icon
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                handleBookmarkToggle(name, path, overView, date);
              },
              child: Image.asset(
                bookmarks[name]! ? "assets/bookmarktrue.png" : "assets/bookmark.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleBookmarkToggle(String filmTitle, String path, String overview, String date) async {
    final prefs = await SharedPreferences.getInstance();
    final CollectionReference filmCollection = FirebaseFirestore.instance.collection('bookmarked_films');

    // Toggle bookmark state
    setState(() {
      bookmarks[filmTitle] = !bookmarks[filmTitle]!;
    });

    // Save the new state in shared preferences
    await prefs.setBool(filmTitle, bookmarks[filmTitle]!);

    if (bookmarks[filmTitle]!) {
      // Add film to Firestore
      filmCollection.add({
        'title': filmTitle,
        'path': path,
        'overview': overview,
        'date': date,
      });
    } else {
      // Delete film from Firestore
      QuerySnapshot querySnapshot = await filmCollection
          .where('title', isEqualTo: filmTitle)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    }
  }
}
