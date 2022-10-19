// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'negara.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NegaraResponse _$NegaraResponseFromJson(Map<String, dynamic> json) {
  return NegaraResponse(
    ack: json['ACK'] as String,
    dataNegara: (json['dataNegara'] as List<dynamic>)
        .map((e) => Negara.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NegaraResponseToJson(NegaraResponse instance) =>
    <String, dynamic>{
      'dataNegara': instance.dataNegara,
      'ACK': instance.ack,
    };

Negara _$NegaraFromJson(Map<String, dynamic> json) {
  return Negara(
    countryFlagActive: json['country_flag_active'] as String,
    countryCode: json['country_code'] as String,
    countryName: json['country_name'] as String,
    countryMSISDNPrefix: json['country_msisdn_prefix'] as String,
    countryId: json['country_id'] as String,
    timeStamp: json['timeStamp'] == null
        ? null
        : DateTime.parse(json['timeStamp'] as String),
  );
}

Map<String, dynamic> _$NegaraToJson(Negara instance) => <String, dynamic>{
      'country_flag_active': instance.countryFlagActive,
      'country_code': instance.countryCode,
      'country_name': instance.countryName,
      'country_msisdn_prefix': instance.countryMSISDNPrefix,
      'country_id': instance.countryId,
      'timeStamp': instance.timeStamp?.toIso8601String(),
    };
