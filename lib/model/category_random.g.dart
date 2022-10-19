// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_random.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRandom _$CategoryRandomFromJson(Map<String, dynamic> json) {
  return CategoryRandom(
    ack: json['ACK'] as String,
    dataRandomCategory: (json['dataRandomCategory'] as List<dynamic>)
        .map((e) => DataCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryRandomToJson(CategoryRandom instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataRandomCategory': instance.dataRandomCategory,
    };
