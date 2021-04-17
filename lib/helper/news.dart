import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {

  List<Articlemodel> news = [];
  Future<void> getnews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=4d4de247914f4b219af6ae9969771ae1");
    var response = await http.get(url);
    var jsondata = jsonDecode(response.body);
    if (jsondata["status"] == "ok") {
      jsondata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Articlemodel articlemodel = Articlemodel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            content: element["content"],
            url: element["url"],
            urltoimage: element["urlToImage"],
            // publishedAt: element["publishedAt"],
          );
          news.add(articlemodel);
        }
      });
    }
  }
}

class CategoriNews {

  List<Articlemodel> news = [];
  Future<void> getnews(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=$category&country=in&category=business&apiKey=4d4de247914f4b219af6ae9969771ae1");
    var response = await http.get(url);
    var jsondata = jsonDecode(response.body);
    if (jsondata["status"] == "ok") {
      jsondata["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Articlemodel articlemodel = Articlemodel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            content: element["content"],
            url: element["url"],
            urltoimage: element["urlToImage"],
            // publishedAt: element["publishedAt"],
          );
          news.add(articlemodel);
        }
      });
    }
  }
}
