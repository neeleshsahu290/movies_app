// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_hive.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailsHiveModelAdapter extends TypeAdapter<MovieDetailsHiveModel> {
  @override
  final int typeId = 2;

  @override
  MovieDetailsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailsHiveModel(
      tmdbID: fields[0] as int,
      title: fields[1] as String,
      posterUrl: fields[2] as String,
      backdropUrl: fields[3] as String,
      releaseDate: fields[4] as String,
      genres: fields[5] as String,
      runtime: fields[6] as String?,
      overview: fields[7] as String,
      voteAverage: fields[8] as double,
      voteCount: fields[9] as String,
      trailerUrl: fields[10] as String,
      similar: (fields[11] as List).cast<MovieHiveModel>(),
      castJson: fields[12] as String,
      reviewsJson: fields[13] as String,
      isBookmarked: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailsHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.tmdbID)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterUrl)
      ..writeByte(3)
      ..write(obj.backdropUrl)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.runtime)
      ..writeByte(7)
      ..write(obj.overview)
      ..writeByte(8)
      ..write(obj.voteAverage)
      ..writeByte(9)
      ..write(obj.voteCount)
      ..writeByte(10)
      ..write(obj.trailerUrl)
      ..writeByte(11)
      ..write(obj.similar)
      ..writeByte(12)
      ..write(obj.castJson)
      ..writeByte(13)
      ..write(obj.reviewsJson)
      ..writeByte(14)
      ..write(obj.isBookmarked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
