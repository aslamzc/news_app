class News {
  final int id;
  final String title;
  final String description;
  final String content;
  final String author;
  final DateTime? publishedAt;
  final String? urlToImage;

  News(
      {this.id = 0,
      required this.author,
      required this.description,
      required this.content,
      required this.title,
      required this.publishedAt,
      this.urlToImage});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? "",
      description: json['description'] ?? "",
      content: json['content'] ?? "",
      title: json['title'] ?? "",
      publishedAt: DateTime.parse(json['publishedAt'] ?? ''),
      urlToImage: json['urlToImage'],
    );
  }
}
