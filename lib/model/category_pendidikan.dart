import 'package:json_annotation/json_annotation.dart';

part 'category_pendidikan.g.dart';

@JsonSerializable()
class CategoryPendidikan {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<CategoryData> dataCategory;

  CategoryPendidikan({required this.ack, required this.dataCategory});
  factory CategoryPendidikan.fromJson(Map<String, dynamic> json) =>
      _$CategoryPendidikanFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryPendidikanToJson(this);
}

@JsonSerializable()
class CategoryData {
  final int id;
  final String categoryCode;
  final String categoryName;

  CategoryData(
      {required this.id,
      required this.categoryCode,
      required this.categoryName});
  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}
