import 'package:http/http.dart' as http;
import 'dart:convert';
import './secret.dart';


Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$auth0Domain/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

