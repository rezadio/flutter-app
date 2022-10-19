// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccupationResponse _$OccupationResponseFromJson(Map<String, dynamic> json) {
  return OccupationResponse(
    json['ACK'] as String,
    json['pesan'] as String,
    (json['data'] as List<dynamic>)
        .map((e) => Occupation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OccupationResponseToJson(OccupationResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'data': instance.data,
    };

Occupation _$OccupationFromJson(Map<String, dynamic> json) {
  return Occupation(
    json['occupationCode'] as String,
    json['occupationDetail'] as String,
  );
}

Map<String, dynamic> _$OccupationToJson(Occupation instance) =>
    <String, dynamic>{
      'occupationCode': instance.occupationCode,
      'occupationDetail': instance.occupationDetail,
    };
