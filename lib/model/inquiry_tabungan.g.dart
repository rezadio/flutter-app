// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquiry_tabungan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquiryTabungan _$InquiryTabunganFromJson(Map<String, dynamic> json) {
  return InquiryTabungan(
    rc: json['rc'] as String,
    ack: json['ACK'] as String,
    hargaJual: json['hargaJual'] as int,
    hargaBeli: json['hargaBeli'] as int,
    dataListCategory: DataListCategory.fromJson(
        json['dataListCategory'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InquiryTabunganToJson(InquiryTabungan instance) =>
    <String, dynamic>{
      'rc': instance.rc,
      'ACK': instance.ack,
      'hargaJual': instance.hargaJual,
      'hargaBeli': instance.hargaBeli,
      'dataListCategory': instance.dataListCategory,
    };

DataListCategory _$DataListCategoryFromJson(Map<String, dynamic> json) {
  return DataListCategory(
    merchantPhone: json['merchantPhone'] as String,
    kelas: json['kelas'] as String,
    payerName: json['payerName'] as String,
    payerNumber: json['payerNumber'] as String,
    customerNumber: json['customerNumber'] as String,
    customerName: json['customerName'] as String,
    reffNum: json['reffNum'] as String,
    merchantName: json['merchantName'] as String,
  );
}

Map<String, dynamic> _$DataListCategoryToJson(DataListCategory instance) =>
    <String, dynamic>{
      'merchantPhone': instance.merchantPhone,
      'kelas': instance.kelas,
      'payerName': instance.payerName,
      'payerNumber': instance.payerNumber,
      'customerNumber': instance.customerNumber,
      'customerName': instance.customerName,
      'reffNum': instance.reffNum,
      'merchantName': instance.merchantName,
    };
