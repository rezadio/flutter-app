// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) {
  return CategoryList(
    ack: json['ACK'] as String,
    dataListCategory: (json['dataListCategory'] as List<dynamic>)
        .map((e) => DataCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryListToJson(CategoryList instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataListCategory': instance.dataListCategory,
    };
