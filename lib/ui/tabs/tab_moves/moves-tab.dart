import 'package:flutter/material.dart';
import 'package:movies/ui/commenwidget/apploader.dart';
import 'package:movies/ui/commenwidget/errorviwe.dart';
import 'package:movies/ui/tabs/tab_moves/Moviecaroctroy.dart';
import '../../../data/api_manger.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Browse Category",
          style: TextStyle(color: Colors.white),textAlign: TextAlign.left,
        ),
        Expanded(
          child: FutureBuilder(
            future: ApiManager.Category(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const errorviwe(error: 'Something went wrong');
              } else if (snapshot.hasData) {
                // Ensure you return the GridView.builder widget
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: snapshot.data?.genres?.length ?? 0, // Handle null safety
                  itemBuilder: (context, index) {
                    final genreName = snapshot.data?.genres?[index].name ?? '';
                    return CategoryWidget(genreName,snapshot.data!.genres![index].id??0);
                  },
                );
              } else {
                // Return the loader as a widget
                return apploader();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget CategoryWidget(String name,int id) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Moviecatogery.routeName,arguments: id);

      },
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(

                child:Align(
                    alignment: Alignment.center,

                    child: Image.asset("assets/0e34a5e080e8c915030603ddcdb4eeba.png"))),
            Center(
              child: Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
