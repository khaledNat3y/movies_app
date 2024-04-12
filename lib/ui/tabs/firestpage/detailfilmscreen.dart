import 'package:flutter/material.dart';
import 'package:movies/model/data-film.dart';

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
  bool issave=false;

  @override
  Widget build(BuildContext context) {
    datafilm data=ModalRoute.of(context)!.settings.arguments as datafilm;
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
                child: Stack(children: [
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
                            ))),
                  ),
                ])),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          child: Image.asset(
                            "assets/bookmark.png",
                          ),
                        ),
                        ],
                    ),
                  ),
                   Expanded(
                     child: Column(
                       children: [
                         Text(
                          "${data.content}\n"
                          ,style: TextStyle(color: Colors.white),
                  ),
                         Row(

                           children: [
                             Image.asset("assets/star-2.png",height: 16,width: 16,),
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
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return detailsfilm(
                                    "$baseUrl${snapshot.data!.results![index+1].backdropPath}",
                                    snapshot.data!.results![index+1].originalTitle ??
                                        " ",
                                    snapshot.data!.results![index+1].voteAverage
                                        .toString() ??
                                        " ",
                                    snapshot.data!.results![index+1].releaseDate ??
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
      width: 100,
      height: 150,

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
                height: 105,
                fit: BoxFit.cover,
              ),
              Row(
                children: [
                  Image.asset("assets/star-2.png",height: 16,width: 16,),
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
          InkWell(
            onTap: (){
              setState(() {
                issave=true;

              });
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                child: Image.asset(issave?"assets/bookmarktrue.png":"assets/bookmark.png")),
          )
        ],
      ),
    );
  }
}