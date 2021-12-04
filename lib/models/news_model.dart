// To parse this JSON data, do
//
//     final newsModal = newsModalFromJson(jsonString);

import 'dart:convert';

// NewsModal newsModalFromJson(String str) => NewsModal.fromJson(json.decode(str));

// String newsModalToJson(NewsModal data) => json.encode(data.toJson());

List<Article> newsModalFromJson(String str) =>
    List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String newsModalToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModal {
  NewsModal({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory NewsModal.fromJson(Map<String, dynamic> json) => NewsModal(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"] ?? "",
        title: json["title"],
        description: json["description"] ?? "",
        url: json["url"],
        urlToImage: json["urlToImage"] ?? "",
        content: json["content"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "content": content,
      };
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
