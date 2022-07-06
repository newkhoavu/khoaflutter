import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'movie_localdb.g.dart';
@HiveType(typeId: 0)
class MovieLocalDB {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String overview;
  @HiveField(3)
  String posterPath;
  @HiveField(4)
  bool isTag;

  MovieLocalDB(this.id, this.title, this.overview, this.posterPath, this.isTag);
}