
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/data/api_manger.dart';
import 'package:movies/model/data-film.dart';
import 'package:movies/ui/commenwidget/errorviwe.dart';
import 'package:movies/utils/app-color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/listprovider.dart';
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
  final Random random = Random();
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
    provider = Provider.of(context);
    int index = random.nextInt(11);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
              future: ApiManager.popularFilm(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const errorviwe(error: 'Something went wrong');
                } else if (snapshot.hasData) {
                  var film = snapshot.data!.results![index];
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
                          // Film widget at the bottom left corner
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
              }),
          const SizedBox(height: 5),
          buildFilmList(ApiManager.newRelease(), "New Releases"),
          const SizedBox(height: 25),
          buildFilmList(ApiManager.recommended(), "Recommended"),
        ],
      ),
    );
  }

  Widget buildFilmList(Future<dynamic> future, String title) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const errorviwe(error: 'Something went wrong');
        } else if (snapshot.hasData) {
          return Container(
            height: 210,
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
                      }
                      else if (title == "New Releases") {
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
    // Ensure that none of the arguments are null; if they are, use a default value.
    path ??= '';
    name ??= 'Unknown';
    rate ??= '0';
    date ??= 'Unknown';
    overView ??= '';

    // Determine whether the bookmark exists and set a default if the key is not present in the map.
    final isBookmarked = bookmarks[name] ?? false;

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
                  Navigator.pushNamed(
                    context,
                    Detailfilmscreen.routeName,
                    arguments: datafilm(
                      titel: name,
                      path: path,
                      content: overView,
                      date: date,
                      issave: false,
                      rate: rate,
                    ),
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
                isBookmarked ? "assets/bookmarktrue.png" : "assets/bookmark.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleBookmarkToggle(String filmTitle, String path, String overview, String date) async {
    final prefs = await SharedPreferences.getInstance();

    // Toggle bookmark state
    setState(() => bookmarks[filmTitle] = !bookmarks[filmTitle]!);

    // Save the new state in shared preferences
    await prefs.setBool(filmTitle, bookmarks[filmTitle]!);

    // Get the reference to the Firestore collection
    CollectionReference movieCollection = FirebaseFirestore.instance.collection('movies');

    if (bookmarks[filmTitle]!) {
      // If bookmarked (now true), add the film to Firestore
      try {
        await movieCollection.doc().set({
          'title': filmTitle,
          'overview': overview,
          'date': date,
          'path': path,
        });
        provider.getFilmsFromFirestore(); // Refresh provider data
      } catch (e) {
        print('Error adding film: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add film, please try again.')),
        );
      }
    } else {
      // If bookmark is toggled off (now false), remove the film from Firestore
      try {
        // Query the Firestore collection to find the document with the specified title
        QuerySnapshot querySnapshot = await movieCollection
            .where('title', isEqualTo: filmTitle)
            .get();

        // If the query found any matching documents, delete them
        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs) {
            await doc.reference.delete();
          }
          provider.getFilmsFromFirestore(); // Refresh provider data
        }
      } catch (e) {
        print('Error removing film: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to remove film, please try again.')),
        );
      }
    }
  }
  void Addfilm(String path, String title, String overview, String date) async {
    CollectionReference movieCollection = FirebaseFirestore.instance.collection('movies');

    try {
      await movieCollection.doc().set({
        'title': title,
        'overview': overview,
        'date': date,
        'path': path,
      });
      provider.getFilmsFromFirestore();
    } catch (e) {
      print('Error adding film: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add film, please try again.')),
      );
    }

  }
}