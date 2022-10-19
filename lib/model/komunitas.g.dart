// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komunitas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Komunitas _$KomunitasFromJson(Map<String, dynamic> json) {
  return Komunitas(
    ack: json['ACK'] as String,
    dataKomunitas: (json['dataKomunitas'] as List<dynamic>)
        .map((e) => DataKomunitas.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$KomunitasToJson(Komunitas instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataKomunitas': instance.dataKomunitas,
    };

DataKomunitas _$DataKomunitasFromJson(Map<String, dynamic> json) {
  return DataKomunitas(
    communityAddress: json['communityAddress'] as String,
    communityName: json['communityName'] as String,
    communityId: json['communityId'] as int,
    picName: json['picName'] as String,
    picPhone: json['picPhone'] as String,
    picId: json['picId'] as int,
  );
}

Map<String, dynamic> _$DataKomunitasToJson(DataKomunitas instance) =>
    <String, dynamic>{
      'communityAddress': instance.communityAddress,
      'communityName': instance.communityName,
      'communityId': instance.communityId,
      'picName': instance.picName,
      'picPhone': instance.picPhone,
      'picId': instance.picId,
    };
