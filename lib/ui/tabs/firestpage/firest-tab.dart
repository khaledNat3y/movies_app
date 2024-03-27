import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/data/api_manger.dart';
import 'package:movies/ui/commenwidget/errorviwe.dart';
import 'package:movies/utils/app-color.dart';

import '../../commenwidget/apploader.dart';


class firesttab extends StatefulWidget {
  const firesttab({Key? key}) : super(key: key);

  @override
  State<firesttab> createState() => _firesttabState();
}

class _firesttabState extends State<firesttab> {
  String baseUrl = "https://image.tmdb.org/t/p/w500/";
  Random random = Random();


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
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              "$baseUrl${snapshot.data!.results![index]
                                  .backdropPath}",
                              height: 217,
                            ),
                            Text(
                              snapshot.data!.results![index].originalTitle ?? " ",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              snapshot.data!.results![index].releaseDate ?? " ",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.end,
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
                                  ))),
                        ),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
                                child: Stack(
                                  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        "$baseUrl${snapshot.data!.results![index]
                                            .backdropPath}",
                                        width: 120,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                        child: Image.asset("assets/bookmark.png"))
                                  ],
                                ),
                              ),
                              )
                        ),

                      ],
                    ),
                  );
                } else {
                  return const apploader();
                }
              }),
          const SizedBox(height: 5),
          FutureBuilder(
              future: ApiManager.NewRealeases(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return errorviwe(error: 'Something went wrong');
                } else if (snapshot.hasData) {
                  return Container(
                    height: 200,
                    color: AppColors.contanercolor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                          child: Text("New Releases",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.results!.length,
                            itemBuilder: (context, index) {
                              return films(
                                  "$baseUrl${snapshot.data!.results![index].backdropPath}");
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const apploader();
                }
              }),
          const SizedBox(height: 25),
          FutureBuilder(
              future: ApiManager.Recommended(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return errorviwe(error: 'Something went wrong');
                }
                else if (snapshot.hasData) {
                  return Container(
                    height: 220,
                    color: AppColors.contanercolor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                          child: Text("Recommended",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return detailsfilm(
                                  "$baseUrl${snapshot.data!.results![index]
                                      .backdropPath}",
                                  snapshot.data!.results![0].originalTitle ??
                                      " ",
                                  snapshot.data!.results![0].voteAverage
                                      .toString() ?? " ",
                                  snapshot.data!.results![0].releaseDate ?? " "


                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else {
                  return const apploader();
                }
              }
          ),
        ],
      ),
    );
  }
}

Widget films(String path) {
  return Container(
    margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            path,
            width: 120,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Image.asset("assets/bookmark.png"))
      ],
    ),
  );
}

Widget detailsfilm(String path, String name, String rate, String date) {
  return Container(
    color: AppColors.gray,
    margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Column(
          children: [
            Image(
              image: NetworkImage(path),
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            Text(
              "$rate",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              date,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Image.asset("assets/bookmark.png"))
      ],
    ),
  );
}
