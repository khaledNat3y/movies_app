import 'package:flutter/material.dart';

import '../../../data/api_manger.dart';
import '../../../utils/app-color.dart';
import '../../commenwidget/apploader.dart';
import '../../commenwidget/errorviwe.dart';

class Moviecatogery extends StatefulWidget {
  static const String routeName = "Moviecatogery";
  const Moviecatogery({super.key});

  @override
  State<Moviecatogery> createState() => _MoviecatogeryState();
}

class _MoviecatogeryState extends State<Moviecatogery> {
  final String baseUrl = "https://image.tmdb.org/t/p/w500/";

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
        ),
        body: FutureBuilder(
          future: ApiManager.MovieDiscover(id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorviwe(error: 'Something went wrong');
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (context, index) {
                  var film = snapshot.data!.results![index];
                  return filmDetails(
                    "$baseUrl${film.backdropPath}",
                    film.title ?? " ",
                    film.overview ?? " ",
                    film.releaseDate ?? " ",
                  );
                },
              );
            } else {
              return apploader();
            }
          },
        )
    );
  }

  Widget filmDetails(String path, String name, String overView, String date) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.transparent,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColors.white),
        ),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              path,
              width: 100,
              height: MediaQuery.of(context).size.height * 0.1,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  overView,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
