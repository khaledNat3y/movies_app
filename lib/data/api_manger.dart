import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/popularresponce.dart';

abstract class ApiManager {
  static Future<popularresponce> popularFilm() async {
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=a8a1b517e6f2636023e25cbb55c8f4af");
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
}
