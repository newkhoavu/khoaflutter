// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_localdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieLocalDBAdapter extends TypeAdapter<MovieLocalDB> {
  @override
  final int typeId = 0;

  @override
  MovieLocalDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieLocalDB(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieLocalDB obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.isTag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieLocalDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
