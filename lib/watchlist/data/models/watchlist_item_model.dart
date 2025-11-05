import 'package:hive/hive.dart';
import 'package:movies_app/core/domain/entities/media.dart';
part 'watchlist_item_model.g.dart';


@HiveType(typeId: 1)
class WatchlistItemModel {
  @HiveField(0)
  final int tmdbID;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterUrl;

  @HiveField(3)
  final String backdropUrl;

  @HiveField(4)
  final double voteAverage;

  @HiveField(5)
  final String releaseDate;

  @HiveField(6)
  final String overview;

 

  const WatchlistItemModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  factory WatchlistItemModel.fromEntity(Media media) {
    return WatchlistItemModel(
      tmdbID: media.tmdbID,
      title: media.title,
      posterUrl: media.posterUrl,
      backdropUrl: media.backdropUrl,
      voteAverage: media.voteAverage,
      releaseDate: media.releaseDate,
      overview: media.overview,
    );
  }

  Media toEntity() {
    return Media(
      tmdbID: tmdbID,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      overview: overview,
    );
  }

  @override
  String toString() {
    return 'WatchlistItemModel(tmdbID: $tmdbID, title: $title)';
  }
}
