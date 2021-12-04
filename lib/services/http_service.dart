import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get_x_project/constants/app_constants.dart';
import 'package:get_x_project/models/news_model.dart';
import "package:http/http.dart" as http;

class HttpService {
  static Future<List<Article>> getNewsList({required String category}) async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=$category" +
            AppConstants.apiUrl));
    if (response.statusCode == 200) {
      // print(response.body);
      var art = json.decode(response.body);
      // ignore: avoid_print
      print(art['articles']);
      return newsModalFromJson(json.encode(art['articles']));
    } else {
      return <Article>[];
    }
  }

  // https://newsapi.org/v2/everything?q=bitcoin
  static Future<List<Article>> getSearchList({required String search}) async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$search" + AppConstants.apiUrl));
    if (response.statusCode == 200) {
      // print(response.body);
      var art = json.decode(response.body);
      // ignore: avoid_print
      print(art['articles']);
      return newsModalFromJson(json.encode(art['articles']));
    } else {
      return <Article>[];
    }
  }
}
