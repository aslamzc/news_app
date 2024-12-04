class News {
  final String author;

  News({required this.author});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? "",
    );
  }
}
