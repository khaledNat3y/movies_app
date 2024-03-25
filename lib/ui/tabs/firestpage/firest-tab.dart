import 'package:flutter/material.dart';

class firesttab extends StatelessWidget {

  const firesttab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Story(),
          Story(),
          Story(),
          Story(),
          Story(),
          Story(),
        ],
      ),
    );
  }
}
class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 7, 5, 6),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: const Image(
              image: AssetImage("assets/facebookStory.jpg"),
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Image.asset("asstes/bookmark.png")
          )

        ],
      ),
    );
  }
}