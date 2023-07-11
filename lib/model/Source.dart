import 'package:hive/hive.dart';

part 'Source.g.dart';

@HiveType(typeId: 1)
class Source {
  @HiveField(0)
  dynamic id;
  @HiveField(2)
  String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }
}
