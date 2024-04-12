import 'package:flutter/material.dart';
import 'package:movies/model/model.dart';

import '../../../utils/app-color.dart';

class Filmwidget extends StatefulWidget {
  final Film film;
  const Filmwidget({super.key, required this.film});

  @override
  State<Filmwidget> createState() => _FilmwidgetState();
}

class _FilmwidgetState extends State<Filmwidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        color: AppColors.transparent,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColors.white),
        ),
      ),
      width: 100,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: NetworkImage(widget.film.path),
              width: 140,
              height: MediaQuery.of(context).size.height * 0.13,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.film.titel,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  widget.film.data,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  widget.film.overView,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
