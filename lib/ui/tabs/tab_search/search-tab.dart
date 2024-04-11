import 'package:flutter/material.dart';
import 'package:movies/data/api_manger.dart';
import 'package:movies/utils/app-color.dart';
import '../../../model/popularresponce.dart';

class Search extends StatefulWidget {
  static const String routeName = "search";

  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Results?> filmsList = [];
  late List<Results> allFilms = [];
  final String errorMessage = "not found";
  String baseUrl = "https://image.tmdb.org/t/p/w500/";
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data from the API and store it in the list when the widget initializes
    fetchData();
  }

  // Function to fetch data from the API
  void fetchData() async {
    try {
      // Fetch popular films from the API
      var popularFilms = await ApiManager.popularFilm();

      setState(() {
        // Store the fetched films in the filmsList
        filmsList = popularFilms.results!.cast<Results>();
        // Assign filmsList to allFilms initially
        allFilms = filmsList.cast<Results>();
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (text) {
                    addSearchedItemsToSearchedList(text);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: AppColors.gray),
                    filled: true,
                    fillColor: AppColors.lightGray,
                    prefixIcon: const Icon(Icons.search, color: AppColors.white,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: AppColors.white),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: AppColors.white),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusColor: AppColors.white,
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: AppColors.white),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.white,fontSize: 15),
                  cursorColor: AppColors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8 - 42,
                  color: AppColors.black,
                  child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? filmsList.length
                        : filmsList
                        .where((film) => film!.originalTitle!
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      if (searchController.text.isEmpty) {
                        return filmDetails(
                          "$baseUrl${filmsList[index]!.backdropPath}",
                          filmsList[index]!.originalTitle ?? " ",
                          filmsList[index]!.overview ?? " ",
                          filmsList[index]!.releaseDate ?? " ",
                        );
                      } else {
                        var filteredFilms = filmsList
                            .where((film) => film!.originalTitle!
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()))
                            .toList();
                        return filmDetails(
                          "$baseUrl${filteredFilms[index]!.backdropPath}",
                          filteredFilms[index]!.originalTitle ?? " ",
                          filteredFilms[index]!.overview ?? " ",
                          filteredFilms[index]!.releaseDate ?? " ",
                        );
                      }
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

  Widget filmDetails(String path, String name, String overView, String date) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: NetworkImage(path),
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
          )
        ],
      ),
    );
  }

  void addSearchedItemsToSearchedList(String searchedCharacter) {
    setState(() {
      // Filter filmsList based on search query
      filmsList = allFilms
          .where((film) => film.originalTitle!
          .toLowerCase()
          .contains(searchedCharacter.toLowerCase()))
          .toList();
    });
  }
}
