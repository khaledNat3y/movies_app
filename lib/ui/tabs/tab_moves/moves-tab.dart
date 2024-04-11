import 'package:flutter/material.dart';
import 'package:movies/ui/commenwidget/apploader.dart';
import 'package:movies/ui/commenwidget/errorviwe.dart';
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
                    // Ensure data is not null
                    final genreName = snapshot.data?.genres?[index].name ?? '';
                    return CategoryWidget(genreName);
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

  Widget CategoryWidget(String name) {
    return Container(
      child: Stack(
        children: [
          Image.asset("assets/0e34a5e080e8c915030603ddcdb4eeba.png"),
          Positioned(
            bottom: 8, // Positioning the text
            left: 8,
            child: Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
