import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/data-film.dart';
import 'package:movies/model/model.dart';



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
        FirebaseFirestore.instance.collection(datafilm.collectionname);
    QuerySnapshot querySnapshot = await filmcollection.get();
    var documents = querySnapshot.docs;
    for (var doc in documents) {
      Map jeson = doc.data() as Map;
      Film todo = Film(

          titel: jeson["titel"],
          overView: jeson["overView"],
          data: jeson["data"],
          path: jeson["path"]);
    }
    notifyListeners();
  }

}