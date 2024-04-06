import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/SearchResponse.dart';
import '../model/popularresponce.dart';

abstract class ApiManager {
  static const String apiKey = "a8a1b517e6f2636023e25cbb55c8f4af";

  static Future<popularresponce> popularFilm() async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        popularresponce popular = popularresponce.fromJson(jsonResponse);
        return popular;
      } else {
        throw "Something went wrong. Please try again later.";
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<SearchResponse> search() async {
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=$apiKey");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        SearchResponse searchResponse = SearchResponse.fromJson(jsonResponse);
        return searchResponse;
      } else {
        throw "Something went wrong. Please try again later.";
      }
    } catch (e) {
      rethrow;
    }
  }
}
