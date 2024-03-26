import 'package:flutter/material.dart';
import 'package:movies/utils/app-color.dart';

class firesttab extends StatelessWidget {
  const firesttab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Image.asset("assets/Image (1).png", height: 217),
                    const Text("Dora and the lost city of gold",
                        style: TextStyle(color: Colors.white),textAlign: TextAlign.end,),
                    const Text("2019  PG-13  2h 7m",
                        style: TextStyle(color: Colors.white),textAlign: TextAlign.end,),
                  ],
                ),
                const Positioned.fill(
                  // Position play button to fill the Stack
                  child: Align(
                      // Align play button to center
                      alignment: Alignment.center,
                      child: InkWell(
                          child: Icon(
                        Icons.play_circle,
                        size: 60,
                        color: Colors.white,
                      )) // Your play button image
                      ),
                ),
                const Positioned.fill(
                  // Position play button to fill the Stack
                  child: Align(
                      // Align play button to center
                      alignment: Alignment.bottomLeft,
                      child: Image(
                        image: AssetImage("assets/Image.png"),
                        width: 100,
                        height: 180,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 200, // Adjusted height
            color: AppColors.contanercolor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Text("New Releases",
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  // Use Expanded to ensure ListView takes available space
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return films("assets/facebookStory.jpg");
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            height: 220, // Adjusted height
            color: AppColors.contanercolor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Text("Recommended",
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  // Use Expanded to ensure ListView takes available space
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return detailsfilm();
                    },
                  ),
                ),
              ],
            ),
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
        const Image(
          image: AssetImage("assets/facebookStory.jpg"),
          width: 80,
          height: 120,
          fit: BoxFit.cover,
        ),
        Container(
            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Image.asset("assets/bookmark.png"))
      ],
    ),
  );
}

Widget detailsfilm() {
  return Container(
    color: AppColors.gray,
    margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        const Column(
          children: [
            Image(
              image: AssetImage("assets/facebookStory.jpg"),
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            Text(
              "7.7",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "dedbils",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "7.7",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Container(
            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Image.asset("assets/bookmark.png"))
      ],
    ),
  );
}
