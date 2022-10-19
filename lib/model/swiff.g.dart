// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swiff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwiffInquiry _$SwiffInquiryFromJson(Map<String, dynamic> json) {
  return SwiffInquiry(
    total: json['total'] as String,
    nama: json['nama'] as String,
    ack: json['ack'] as String,
    biaya: json['biaya'] as String,
    merchantCode: json['merchantCode'] as String,
    nominalBelanja: json['nominalBelanja'] as String,
    dateTrx: DateTime.parse(json['dateTrx'] as String),
  );
}

Map<String, dynamic> _$SwiffInquiryToJson(SwiffInquiry instance) =>
    <String, dynamic>{
      'ack': instance.ack,
      'merchantCode': instance.merchantCode,
      'total': instance.total,
      'nama': instance.nama,
      'biaya': instance.biaya,
      'nominalBelanja': instance.nominalBelanja,
      'dateTrx': instance.dateTrx.toIso8601String(),
    };
