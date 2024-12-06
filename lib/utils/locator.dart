import 'package:get_it/get_it.dart';
import 'package:news/providers/saved_news_provider.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => SavedNewsProvider());
}