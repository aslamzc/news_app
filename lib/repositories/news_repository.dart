import 'package:news/models/news.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsRepository {
  static Database? _db;
  static final NewsRepository instance = NewsRepository._constructor();

  final String _newsTableName = 'news';
  final String _newsIdColumnName = 'id';
  final String _newsTitleColumnName = 'title';
  final String _newsDescriptionColumnName = 'description';
  final String _newsContentColumnName = 'content';
  final String _newsAuthorColumnName = 'author';
  final String _newsPublishedAtColumnName = 'publishedAt';
  final String _newsUrlToImageColumnName = 'urlToImage';
  final String _newsCreatedDateColumnName = 'created_at';
  final String _newsUpdatedDateColumnName = 'updated_at';

  NewsRepository._constructor();

  Future<Database> get database async => _db ??= await getDatabase();

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'simple_news.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_newsTableName(
            $_newsIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_newsTitleColumnName TEXT,
            $_newsDescriptionColumnName TEXT,
            $_newsContentColumnName TEXT,
            $_newsAuthorColumnName TEXT,
            $_newsPublishedAtColumnName TEXT,
            $_newsUrlToImageColumnName TEXT,
            $_newsCreatedDateColumnName TEXT DEFAULT CURRENT_TIMESTAMP,
            $_newsUpdatedDateColumnName TEXT
          )
        ''');
      },
    );
    return database;
  }

  Future<int> addNews(Map<String, dynamic> news) async {
    final db = await database;
    final id = await db.insert(_newsTableName, {
      _newsTitleColumnName: news[_newsTitleColumnName],
      _newsDescriptionColumnName: news[_newsDescriptionColumnName],
      _newsContentColumnName: news[_newsContentColumnName],
      _newsAuthorColumnName: news[_newsAuthorColumnName],
      _newsPublishedAtColumnName: news[_newsPublishedAtColumnName],
      _newsUrlToImageColumnName: news[_newsUrlToImageColumnName],
      _newsUpdatedDateColumnName: DateTime.now().toString(),
    });
    return id;
  }

  Future<int> deleteNews(int id) async {
    final db = await database;
    return await db.delete(_newsTableName,
        where: '$_newsIdColumnName = ?', whereArgs: [id]);
  }

  Future<List<News>> getSavedNews({String order = 'DESC'}) async {
    final db = await database;
    final data = await db.query(_newsTableName,
        orderBy: '$_newsCreatedDateColumnName $order');
    List<News> news = data
        .map((val) => News(
            id: val["id"] as int,
            title: val["title"] as String,
            description: val["description"] as String,
            content: val["content"] as String,
            author: val["author"] as String,
            publishedAt: DateTime.parse(
                (val["publishedAt"] ?? DateTime.now().toString()) as String),
            urlToImage: val["urlToImage"] as String))
        .toList();
    return news;
  }
}
