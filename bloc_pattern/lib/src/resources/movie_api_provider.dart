import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/item_model.dart';


class MovieApiProvider {
  Client http = Client();
  final apiKey = dotenv.env['API_KEY'];

  Future<ItemModel> fetchMovieList() async {
    final response = await http
        .get(Uri.parse("http://api.themoviedb.org/3/movie/popular?api_key=$apiKey"));
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
