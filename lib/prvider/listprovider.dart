import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/data-film.dart';

import '../model/model.dart';



class Listprovider extends ChangeNotifier {
  List<Film> films = [];
  DateTime selecteddate = DateTime.now();

  void onchangedate(DateTime newdate) {
    selecteddate = newdate;
    gettaskinfiarbase();
    notifyListeners();
  }

  void gettaskinfiarbase() async {
    films.clear();
    CollectionReference filmcollection =
        FirebaseFirestore.instance.collection("movies");
    QuerySnapshot querySnapshot = await filmcollection.get();
    var documents = querySnapshot.docs;
    for (var doc in documents) {
      Map json = doc.data() as Map;
      Film film = Film(
          titel: json["titel"],
          overView: json["overView"],
          data: json["data"],
          path: json["path"]);
    }
    notifyListeners();
  }

}