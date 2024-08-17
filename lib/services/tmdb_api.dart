import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/person_model.dart';

class TMDbApi {
  static const String apiKey = '7498df51a2f5c06927536a5aa88482bd';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<dynamic>> getTrending() async {
    final response = await http.get(
      Uri.parse('$baseUrl/trending/all/week?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load trending movies and shows');
    }
  }

  static Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to search movies');
    }
  }
}



class ApiService {
  final String apiKey = '7498df51a2f5c06927536a5aa88482bd';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<PersonResponse> fetchTrendingPeople() async {
    final response = await http.get(Uri.parse('$baseUrl/trending/person/week?api_key=$apiKey&language=en-US'));

    if (response.statusCode == 200) {
      return PersonResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trending people');
    }
  }
}