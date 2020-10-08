import 'package:hive/hive.dart';

part 'series.g.dart';

@HiveType()
class Series{
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int ratings;

  Series(this.name, this.ratings);
}