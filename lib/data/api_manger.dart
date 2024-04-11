
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/recomendresponse.dart';

import '../model/Catogory.dart';
import '../model/SearchResponse.dart';
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
  static Future<UpcomingResponse> newRelease() async {
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
  static Future<RecommendedResponse> recommended() async {
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

  static Future<SearchResponse> search() async {
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/search/movie?apikey=a8a1b517e6f2636023e25cbb55c8f4af&q=");
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
  static Future<CategoryResponse> Category() async {
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/genre/movie/list?api_key=a8a1b517e6f2636023e25cbb55c8f4af");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        CategoryResponse categoryResponse=CategoryResponse.fromJson(jsonResponse);
        return categoryResponse;
      } else {
        throw "Something went wrong. Please try again later.";
      }
    } catch (e) {
      rethrow;
    }
  }

}
