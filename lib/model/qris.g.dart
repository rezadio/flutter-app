// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qris.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Qris _$QrisFromJson(Map<String, dynamic> json) {
  return Qris(
    pesan: json['pesan'] as String,
    nama: json['nama'] as String,
    data: json['data'] as String,
    city: json['city'] as String,
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$QrisToJson(Qris instance) => <String, dynamic>{
      'pesan': instance.pesan,
      'nama': instance.nama,
      'data': instance.data,
      'city': instance.city,
      'ACK': instance.ack,
    };

QrisData _$QrisDataFromJson(Map<String, dynamic> json) {
  return QrisData(
    approvalCode: json['approvalCode'] as String,
    globallyUniqueIdentifier: json['GloballyUniqueIdentifier'] as String,
    mpan: json['MPAN'] as String,
    mpanCrc: json['MPANCRC'] as String,
    mpanJalin: json['MPANJalin'] as String,
  );
}

Map<String, dynamic> _$QrisDataToJson(QrisData instance) => <String, dynamic>{
      'approvalCode': instance.approvalCode,
      'GloballyUniqueIdentifier': instance.globallyUniqueIdentifier,
      'MPAN': instance.mpan,
      'MPANCRC': instance.mpanCrc,
      'MPANJalin': instance.mpanJalin,
    };

InquiryQris _$InquiryQrisFromJson(Map<String, dynamic> json) {
  return InquiryQris(
    merchantCode: json['merchantCode'] as String,
    merchantName: json['merchantName'] as String,
    logo: json['logo'] as String,
    fee: json['fee'] as int,
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$InquiryQrisToJson(InquiryQris instance) =>
    <String, dynamic>{
      'merchantCode': instance.merchantCode,
      'merchantName': instance.merchantName,
      'logo': instance.logo,
      'fee': instance.fee,
      'amount': instance.amount,
    };
