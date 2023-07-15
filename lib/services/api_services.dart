import 'dart:convert';

import 'package:http/http.dart' as http;

Future<News> fetchTNews() async {
  const String baseUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a60957d8c92a4fbaa675850e76e6cb16';
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Something went wrong while getting news!');
  }
}

Future<News> fetchWSNews() async {
  String baseUrl =
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=a60957d8c92a4fbaa675850e76e6cb16';
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Something went wrong while getting news!');
  }
}

Future<News> fetchUSNews() async {
  String baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a60957d8c92a4fbaa675850e76e6cb16';
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Something went wrong while getting news!');
  }
}

Future<News> fetchSPNews() async {
  String baseUrl =
      'https://newsapi.org/v2/everything?q=tesla&from=2023-06-14&sortBy=publishedAt&apiKey=a60957d8c92a4fbaa675850e76e6cb16';
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Something went wrong while getting news!');
  }
}

Future<News> fetchDCNews() async {
  String baseUrl =
      'https://newsapi.org/v2/everything?q=apple&from=2023-07-10&to=2023-07-10&sortBy=popularity&apiKey=a60957d8c92a4fbaa675850e76e6cb16';
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    return News.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Something went wrong while getting news!');
  }
}

class News {
  final int? userId;
  final int? id;
  final String? name;
  final String? author;
  final String? title;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? description;

  News({
    required this.userId,
    required this.id,
    required this.name,
    required this.author,
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.description,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      userId: json['userId'],
      id: json['id'],
      name: json['name'],
      author: json['author'],
      title: json['title'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      description: json['description'],
    );
  }
}
