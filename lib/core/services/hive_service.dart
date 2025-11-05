import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/movies/data/models/db/movie_details_hive.model.dart';
import 'package:movies_app/movies/data/models/db/movie_hive_model.dart';
import 'package:movies_app/watchlist/data/models/watchlist_item_model.dart';

class HiveService {
  HiveService._privateConstructor();
  static final HiveService instance = HiveService._privateConstructor();

  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(WatchlistItemModelAdapter());
    Hive.registerAdapter(MovieHiveModelAdapter());
    Hive.registerAdapter(MovieDetailsHiveModelAdapter());

    try {
      await Hive.openBox<WatchlistItemModel>('items');
      await Hive.openBox<MovieHiveModel>('movies_box');
      await Hive.openBox<MovieDetailsHiveModel>('movies_details_box');
    } catch (e) {
      // fallback delete and reopen
      await Hive.deleteBoxFromDisk('items');
      await Hive.deleteBoxFromDisk('movies_box');
      await Hive.deleteBoxFromDisk('movies_details_box');

      await Hive.openBox<WatchlistItemModel>('items');
      await Hive.openBox<MovieHiveModel>('movies_box');
      await Hive.openBox<MovieDetailsHiveModel>('movies_details_box');
    }
  }

  Box<WatchlistItemModel> get watchlistBox =>
      Hive.box<WatchlistItemModel>('items');

  Box<MovieHiveModel> get moviesBox => Hive.box<MovieHiveModel>('movies_box');
  Box<MovieDetailsHiveModel> get moviesDetailsBox =>
      Hive.box<MovieDetailsHiveModel>('movies_details_box');
}
