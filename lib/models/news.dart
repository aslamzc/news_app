class News {
  final String author;
  final String description;

  News({required this.author, required this.description});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? "",
      description: json['description'] ?? "",
    );
  }
}
