import 'package:flutter/material.dart';

import '../../../data/api_manger.dart';
import '../../../utils/app-color.dart';
import '../../commenwidget/apploader.dart';
import '../../commenwidget/errorviwe.dart';

class Detailfilmscreen extends StatefulWidget {
  static const String routeName = "detailfilmscreen";

  const Detailfilmscreen({super.key});

  @override
  State<Detailfilmscreen> createState() => _DetailfilmscreenState();
}

class _DetailfilmscreenState extends State<Detailfilmscreen> {
  String baseUrl = "https://image.tmdb.org/t/p/w500/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          "the dora film",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/Image (1).png",
                        height: 217,
                      ),
                      const Text(
                        "Dora and the lost city of gold",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.end,
                      ),
                      const Text(
                        "2019  PG-13  2h 7m",
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
                ])),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
                      child: Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "assets/Image.png",
                              width: 120,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: Image.asset("assets/bookmark.png"))
                        ],
                      ),
                    ),
                    Text(
                      "Having spent most of her life\n exploring the jungle,\n nothing could prepare Dora\n for her most dangerous \nadventure yet — high school. "
                      ,style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: ApiManager.Recommended(),
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
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return detailsfilm(
                                    "$baseUrl${snapshot.data!.results![index].backdropPath}",
                                    snapshot.data!.results![0].originalTitle ??
                                        " ",
                                    snapshot.data!.results![0].voteAverage
                                        .toString() ??
                                        " ",
                                    snapshot.data!.results![0].releaseDate ??
                                        " ");
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
          ],
        ),
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
          Container(
              margin: const EdgeInsets.fromLTRB(3, 0, 0, 0),
              child: Image.asset("assets/bookmark.png"))
        ],
      ),
    );
  }
}