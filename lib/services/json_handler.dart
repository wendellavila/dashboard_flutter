import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<Map> getFromUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url), headers: {'Accept': "application/json"});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load JSON from url "$url". Response Code: ${response.statusCode}.');
    }
  } on Exception catch (e) {
    print(e);
    return {};
  }
}

Future<Map> postFromUrl({required String url, Map body = const {}}) async {
  try {
    final response = await http.post(Uri.parse(url), headers: {'Accept': "application/json"}, body: json.encode(body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load JSON from url "$url". Response Code: ${response.statusCode}.');
    }
  } on Exception catch (e) {
    print(e);
    return {};
  }
}

Future<Map> readFromAssets(String filename) async {
  String jsonData = await rootBundle.loadString(filename);
  return jsonDecode(jsonData);
}
