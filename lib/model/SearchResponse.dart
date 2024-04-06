import 'dart:convert'; // Add this import if not already imported

class SearchResponse {
  int? page;
  List<dynamic>? results; // Change List<Null> to List<dynamic> or List<Map<String, dynamic>>
  int? totalPages;
  int? totalResults;

  SearchResponse({this.page, this.results, this.totalPages, this.totalResults});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      page: json['page'],
      results: json['results'], // Since 'results' can contain various types, you can directly assign it
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'page': page,
      'total_pages': totalPages,
      'total_results': totalResults,
    };
    if (results != null) {
      data['results'] = results;
    }
    return data;
  }
}
