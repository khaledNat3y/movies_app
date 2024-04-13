import 'package:flutter/material.dart';
import 'package:movies/model/model.dart';
import '../../../utils/app-color.dart';

class Filmwidget extends StatefulWidget {
  final Film film;

  // Constructor takes a Film object as a required parameter
  const Filmwidget({super.key, required this.film});

  @override
  State<Filmwidget> createState() => _FilmwidgetState();
}

class _FilmwidgetState extends State<Filmwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Film image on the left side
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              widget.film.path, // URL of the film's image
              width: 140,
              height: MediaQuery.of(context).size.height * 0.13, // Relative height
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 5, // Space between the image and text
          ),
          // Film information on the right side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Film title
                Text(
                  widget.film.title,
                  style: const TextStyle(color: Colors.white),
                ),
                // Film date
                Text(
                  widget.film.date,
                  style: const TextStyle(color: Colors.white),
                ),
                // Film overview, truncated to one line
                Expanded(
                  child: Text(
                    widget.film.overview,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white),
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
