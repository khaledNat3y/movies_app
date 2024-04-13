import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/data-film.dart';
import '../model/model.dart';

class Listprovider extends ChangeNotifier {
  List<Film> films = [];

  // Function to fetch films from Firestore and update the `films` list
  void getFilmsFromFirestore() async {
    try {
      films.clear(); // Clear the current list of films
      CollectionReference filmCollection = FirebaseFirestore.instance.collection('movies');
      QuerySnapshot querySnapshot = await filmCollection.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

        // Ensure values are non-null and handle possible `null` values with default values
        String title = jsonData['title'] as String? ?? ''; // Provide a default empty string if `titel` is null
        String overview = jsonData['overview'] as String? ?? ''; // Default empty string if `overView` is null
        String date = jsonData['date'] as String? ?? ''; // Default empty string if `data` is null
        String path = jsonData['path'] as String? ?? ''; // Default empty string if `path` is null

        // Create a new Film object and add it to the list of films
        Film film = Film(
          title: title,
          overview: overview,
          date: date,
          path: path,
        );
        films.add(film);
      }
      // Notify listeners that the films list has been updated
      notifyListeners();
    } catch (e) {
      // Handle any errors that may occur during fetching
      print('Error fetching films from Firestore: $e');
      // Consider providing appropriate feedback to the user (e.g., using a SnackBar)
    }
  }

  Future<void> deleteFilm(String documentId) async {
    try {
      CollectionReference filmCollection = FirebaseFirestore.instance.collection('movies');

      await filmCollection.doc(documentId).delete();

      films.removeWhere((film) => film.documentId == documentId);

      notifyListeners();
    } catch (e) {
      print('Error deleting film from Firestore: $e');
    }
  }
}
