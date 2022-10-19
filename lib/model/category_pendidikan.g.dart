// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_pendidikan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPendidikan _$CategoryPendidikanFromJson(Map<String, dynamic> json) {
  return CategoryPendidikan(
    ack: json['ACK'] as String,
    dataCategory: (json['dataCategory'] as List<dynamic>)
        .map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryPendidikanToJson(CategoryPendidikan instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataCategory': instance.dataCategory,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) {
  return CategoryData(
    id: json['id'] as int,
    categoryCode: json['categoryCode'] as String,
    categoryName: json['categoryName'] as String,
  );
}

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryCode': instance.categoryCode,
      'categoryName': instance.categoryName,
    };
