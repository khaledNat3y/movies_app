
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/recomendresponse.dart';

import '../model/popularresponce.dart';
import '../model/uncmpingresponse.dart';

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
  static Future<UpcomingResponse> NewRealeases() async {
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=a8a1b517e6f2636023e25cbb55c8f4af");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        UpcomingResponse upcomingResponse = UpcomingResponse.fromJson(jsonResponse);
        return upcomingResponse;
      } else {
        throw "Something went wrong. Please try again later.";
      }
    } catch (e) {
      rethrow;
    }
  }
  static Future<RecommendedResponse> Recommended() async {
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=a8a1b517e6f2636023e25cbb55c8f4af");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        RecommendedResponse recommendedResponse = RecommendedResponse.fromJson(jsonResponse);
        return recommendedResponse;
      } else {
        throw "Something went wrong. Please try again later.";
      }
    } catch (e) {
      rethrow;
    }
  }

}
