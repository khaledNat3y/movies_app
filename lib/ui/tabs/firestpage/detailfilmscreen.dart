import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/data-film.dart';
import 'package:movies/data/api_manger.dart';
import 'package:movies/utils/app-color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../commenwidget/apploader.dart';
import '../../commenwidget/errorviwe.dart';

class Detailfilmscreen extends StatefulWidget {
  static const String routeName = "detailfilmscreen";

  const Detailfilmscreen({super.key});

  @override
  State<Detailfilmscreen> createState() => _DetailfilmscreenState();
}

class _DetailfilmscreenState extends State<Detailfilmscreen> {
  final String baseUrl = "https://image.tmdb.org/t/p/w500/";
  final Map<String, bool> bookmarks = {}; // Map to track bookmark state for each film

  @override
  void initState() {
    super.initState();
    loadBookmarks(); // Load bookmarks from shared preferences
  }

  // Load bookmarks from shared preferences
  void loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
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
    final datafilm? data = ModalRoute.of(context)?.settings.arguments as datafilm?;

    if (data == null) {
      return const Scaffold(
        body: Center(
          child: Text('No data found', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: AppColors.black,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          data.titel,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        data.path,
                        height: 217,
                      ),
                      Text(
                        data.titel,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        data.date,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(
                          Icons.play_circle,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.network(
                                data.path,
                                width: 120,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              toggleBookmark(data.titel, data.path, data.content, data.date);
                            },
                            child: Image.asset(
                              bookmarks[data.titel] ?? false
                                  ? "assets/bookmarktrue.png"
                                  : "assets/bookmark.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${data.content}\n",
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            Image.asset("assets/star-2.png", height: 16, width: 16),
                            Text(
                              data.rate,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: ApiManager.recommended(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const errorviwe(error: 'Something went wrong');
                } else if (snapshot.hasData) {
                  return Container(
                    height: 220,
                    color: AppColors.containerColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Text("More Like This",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.results?.length ?? 0,
                            itemBuilder: (context, index) {
                              final result = snapshot.data!.results![index];
                              return detailsFilm(
                                "$baseUrl${result.backdropPath}",
                                result.originalTitle ?? " ",
                                result.voteAverage.toString(),
                                result.releaseDate ?? " ",
                                result.overview??" ",
                              );
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
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsFilm(String path, String name, String rate, String date, String overview) {
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
                        content: overview,
                        date: date,
                        issave: false,
                        rate: rate,
                      ));
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
          // Bookmark icon at the top left corner
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                toggleBookmark(name, path, overview, date);
              },
              child: Image.asset(
                bookmarks[name] ?? false
                    ? "assets/bookmarktrue.png"
                    : "assets/bookmark.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Toggle bookmark state and save in shared preferences
  void toggleBookmark(String filmTitle, String path, String overview, String date) async {
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
        await movieCollection.doc(filmTitle).set({
          'title': filmTitle,
          'overview': overview,
          'date': date,
          'path': path,
        });
        // Optional: You might want to refresh provider data
        // provider.getFilmsFromFirestore();
      } catch (e) {
        print('Error adding film: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add film, please try again.')),
        );
      }
    } else {
      // If bookmark is toggled off (now false), remove the film from Firestore
      try {
        // Delete the film document from Firestore using its title as the document ID
        await movieCollection.doc(filmTitle).delete();
        // Optional: You might want to refresh provider data
        // provider.getFilmsFromFirestore();
      } catch (e) {
        print('Error removing film: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove film, please try again.')),
        );
      }
    }
  }
}
