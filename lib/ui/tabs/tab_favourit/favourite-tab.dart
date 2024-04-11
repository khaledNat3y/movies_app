import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../prvider/listprovider.dart';
import '../../../utils/app-color.dart';

class Favorite extends StatefulWidget {

  const Favorite({super.key});


  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index){
            return filmDetails("assets/Image.png", "name", "overView", "date");
          }
      ),
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
            child: Image.asset(
              path,
              width: 100, // Reduce width to 100
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
