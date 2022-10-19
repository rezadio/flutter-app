// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultModel _$DefaultModelFromJson(Map<String, dynamic> json) {
  return DefaultModel(
    pesan: json['pesan'] as String,
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$DefaultModelToJson(DefaultModel instance) =>
    <String, dynamic>{
      'pesan': instance.pesan,
      'ACK': instance.ack,
    };
