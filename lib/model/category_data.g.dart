// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCategory _$DataCategoryFromJson(Map<String, dynamic> json) {
  return DataCategory(
    edukasiName: json['edukasiName'] as String,
    logo: json['logo'] as String?,
    id: json['id'] as String,
    categoryId: json['categoryId'] as int?,
  );
}

Map<String, dynamic> _$DataCategoryToJson(DataCategory instance) =>
    <String, dynamic>{
      'edukasiName': instance.edukasiName,
      'logo': instance.logo,
      'id': instance.id,
      'categoryId': instance.categoryId,
    };
