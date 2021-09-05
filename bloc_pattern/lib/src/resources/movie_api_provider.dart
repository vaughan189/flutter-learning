import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/src/models/trailer_model.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/item_model.dart';

class MovieApiProvider {
  Client http = Client();
  final _baseUrl = dotenv.env['BASE_URL'];
  final apiKey = dotenv.env['API_KEY'];

  Future<ItemModel> fetchMovieList() async {
    final response =
        await http.get(Uri.parse("$_baseUrl/popular?api_key=$apiKey"));
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/$movieId/videos?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
