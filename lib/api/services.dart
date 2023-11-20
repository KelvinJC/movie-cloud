import 'dart:convert';
import 'dart:async';
import 'package:flutter_mdb/api/config.dart';
import 'package:http/http.dart' as http;


Future<MovieData> fetchMovieData(String? searchTerm, page) async {
  final endpoint = searchTerm == null
  ? "${Config.popular_base_url}&page=$page"
  : "${Config.search_base_url}$searchTerm&page=$page";

  http.Response response = await http.get(Uri.parse(endpoint));
  if (response.statusCode == 200) {
    print("MOvie Resu;lts first appear here ${jsonDecode(response.body)}");
      return MovieData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get Movies');
  }
}

class MovieData {
  final int page;
  final List<dynamic> results;
  final int totalPages;
  final int totalResults;

  const MovieData({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      page: json['page'],
      results: json['results'],
      totalPages: json['total_pages'],
      totalResults: json['total_results']
    );
  }
}