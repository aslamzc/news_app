class News {
  final String title;
  final String description;
  final String author;
  final DateTime publishedAt;

  News(
      {required this.author,
      required this.description,
      required this.title,
      required this.publishedAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? "",
      description: json['description'] ?? "",
      title: json['title'] ?? "",
      publishedAt: DateTime.parse(json['publishedAt'] ?? ''),
    );
  }
}
