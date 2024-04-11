import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movies/data/api_manger.dart';
import 'package:movies/model/data-film.dart';
import 'package:movies/ui/commenwidget/errorviwe.dart';
import 'package:movies/utils/app-color.dart';
import '../../commenwidget/apploader.dart';
import 'detailfilmscreen.dart';

class firesttab extends StatefulWidget {
  const firesttab({Key? key}) : super(key: key);

  @override
  State<firesttab> createState() => _firesttabState();
}

class _firesttabState extends State<firesttab> {
  final String baseUrl = "https://image.tmdb.org/t/p/w500/";
  final Random random = Random();
  final Map<String, bool> bookmarks = {}; // Map to track bookmark state for each film

  @override
  Widget build(BuildContext context) {
    int index = random.nextInt(11);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
              future: ApiManager.popularFilm(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return errorviwe(error: 'Something went wrong');
                } else if (snapshot.hasData) {
                  // Initialize bookmarks map
                  var film = snapshot.data!.results![index];
                  if (!bookmarks.containsKey(film.title)) {
                    bookmarks[film.title!] = false;
                  }

                  return GestureDetector(
                    onTap: () {
                      // Navigate to Detailfilmscreen.routeName
                      Navigator.pushNamed(context, Detailfilmscreen.routeName,
                          arguments: datafilm(
                              titel: film.title ?? " ",
                              path: "$baseUrl${film.backdropPath}",
                              content: film.originalTitle ?? " ",
                              date: film.releaseDate ?? " ",
                              issave: false
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
          buildFilmList(ApiManager.NewRealeases(), "New Releases"),
          const SizedBox(height: 25),
          buildFilmList(ApiManager.Recommended(), "Recommended"),
        ],
      ),
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
                      if (!bookmarks.containsKey(film.title)) {
                        bookmarks[film.title] = false;
                      }
                      if (title == "Recommended") {
                        return InkWell(
                          onTap: (){
                            var film = snapshot.data!.results![index];
                            Navigator.pushNamed(context, Detailfilmscreen.routeName,
                                arguments: datafilm(
                                    titel: film.title ?? " ",
                                    path: "$baseUrl${film.backdropPath}",
                                    content: film.originalTitle ?? " ",
                                    date: film.releaseDate ?? " ",
                                    issave: false
                                )
                            );
                          },
                          child: detailsFilm(
                              "$baseUrl${film.backdropPath}",
                              film.originalTitle ?? " ",
                              film.voteAverage.toString(),
                              film.releaseDate ?? " "
                          ),
                        );
                      } else if (title == "New Releases") {
                        return InkWell(
                            onTap: (){
                              var film = snapshot.data!.results![index];
                              Navigator.pushNamed(context, Detailfilmscreen.routeName,
                                  arguments: datafilm(
                                      titel: film.title ?? " ",
                                      path: "$baseUrl${film.backdropPath}",
                                      content: film.originalTitle ?? " ",
                                      date: film.releaseDate ?? " ",
                                      issave: false
                                  )
                              );
                            },
                            child: filmWidget(film, film.title ?? " "));
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
    return GestureDetector(
      onTap: () {
        // Toggle bookmark state
        setState(() {
          bookmarks[title] = !bookmarks[title]!;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                "$baseUrl${film.backdropPath}",
                width: 120,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    bookmarks[title] = !bookmarks[title]!;
                  });
                },
                child: Image.asset(
                  bookmarks[title]! ? "assets/bookmarktrue.png" : "assets/bookmark.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsFilm(String path, String name, String rate, String date) {
    return GestureDetector(
      onTap: () {
        // Navigate to Detailfilmscreen.routeName
        Navigator.pushNamed(context, Detailfilmscreen.routeName,
            arguments: datafilm(
                titel: name,
                path: path,
                content: name,
                date: date,
                issave: bookmarks[name] == true)); // Pass bookmark state in `issave`
      },
      child: Container(
        color: AppColors.gray,
        margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Column(
              children: [
                Image.network(
                  path,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Text(
                  rate,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white),
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
                  setState(() {
                    bookmarks[name] = !bookmarks[name]!;
                  });
                },
                child: Image.asset(
                    bookmarks[name]! ? "assets/bookmarktrue.png" : "assets/bookmark.png"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
