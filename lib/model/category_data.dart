import 'package:json_annotation/json_annotation.dart';

part 'category_data.g.dart';

@JsonSerializable()
class DataCategory {
  final String edukasiName;
  final String? logo;
  final String id;
  final int? categoryId;

  DataCategory(
      {required this.edukasiName,
      this.logo,
      required this.id,
      this.categoryId});
  factory DataCategory.fromJson(Map<String, dynamic> json) =>
      _$DataCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$DataCategoryToJson(this);
}
