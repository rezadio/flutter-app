// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationList _$EducationListFromJson(Map<String, dynamic> json) {
  return EducationList(
    ack: json['ACK'] as String,
    dataListCategory: (json['dataListCategory'] as List<dynamic>)
        .map((e) => DataListCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EducationListToJson(EducationList instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataListCategory': instance.dataListCategory,
    };

EducationRandomList _$EducationRandomListFromJson(Map<String, dynamic> json) {
  return EducationRandomList(
    ack: json['ACK'] as String,
    dataRandomCategory: (json['dataRandomCategory'] as List<dynamic>)
        .map((e) => DataListCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EducationRandomListToJson(
        EducationRandomList instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataRandomCategory': instance.dataRandomCategory,
    };

EducationCategory _$EducationCategoryFromJson(Map<String, dynamic> json) {
  return EducationCategory(
    ack: json['ACK'] as String,
    dataCategory: (json['dataCategory'] as List<dynamic>)
        .map((e) => EducationDataCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EducationCategoryToJson(EducationCategory instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataCategory': instance.dataCategory,
    };

EducationDataCategory _$EducationDataCategoryFromJson(
    Map<String, dynamic> json) {
  return EducationDataCategory(
    id: json['id'] as int,
    categoryCode: json['categoryCode'] as String,
    categoryName: json['categoryName'] as String,
  );
}

Map<String, dynamic> _$EducationDataCategoryToJson(
        EducationDataCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryCode': instance.categoryCode,
      'categoryName': instance.categoryName,
    };

DataListCategory _$DataListCategoryFromJson(Map<String, dynamic> json) {
  return DataListCategory(
    edukasiName: json['edukasiName'] as String,
    logo: json['logo'] as String?,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DataListCategoryToJson(DataListCategory instance) =>
    <String, dynamic>{
      'edukasiName': instance.edukasiName,
      'logo': instance.logo,
      'id': instance.id,
    };

EducationInquiry _$EducationInquiryFromJson(Map<String, dynamic> json) {
  return EducationInquiry(
    rc: json['rc'] as String,
    ack: json['ACK'] as String,
    inquiryListCategory: InquiryListCategory.fromJson(
        json['dataListCategory'] as Map<String, dynamic>),
    hargaJual: json['hargaJual'] as int?,
    hargaBeli: json['hargaBeli'] as int?,
  );
}

Map<String, dynamic> _$EducationInquiryToJson(EducationInquiry instance) =>
    <String, dynamic>{
      'rc': instance.rc,
      'ACK': instance.ack,
      'dataListCategory': instance.inquiryListCategory,
      'hargaJual': instance.hargaJual,
      'hargaBeli': instance.hargaBeli,
    };

InquiryListCategory _$InquiryListCategoryFromJson(Map<String, dynamic> json) {
  return InquiryListCategory(
    serviceFee: json['serviceFee'] as int,
    merchantPhone: json['merchantPhone'] as String,
    datas: (json['datas'] as List<dynamic>)
        .map((e) => InquiryListCategoryData.fromJson(e as Map<String, dynamic>))
        .toList(),
    kelas: json['kelas'] as String,
    payerName: json['payerName'] as String?,
    payerNumber: json['payerNumber'] as String?,
    caraBayar: json['caraBayar'] as String,
    customerNumber: json['customerNumber'] as String,
    customerName: json['customerName'] as String,
    reffNum: json['reffNum'] as String?,
    merchantName: json['merchantName'] as String,
  );
}

Map<String, dynamic> _$InquiryListCategoryToJson(
        InquiryListCategory instance) =>
    <String, dynamic>{
      'serviceFee': instance.serviceFee,
      'merchantPhone': instance.merchantPhone,
      'datas': instance.datas,
      'kelas': instance.kelas,
      'payerName': instance.payerName,
      'payerNumber': instance.payerNumber,
      'caraBayar': instance.caraBayar,
      'customerNumber': instance.customerNumber,
      'customerName': instance.customerName,
      'reffNum': instance.reffNum,
      'merchantName': instance.merchantName,
    };

InquiryListCategoryData _$InquiryListCategoryDataFromJson(
    Map<String, dynamic> json) {
  return InquiryListCategoryData(
    billName: json['billName'] as String,
    amount: json['amount'] as num,
    billCode: json['billCode'] as String,
  );
}

Map<String, dynamic> _$InquiryListCategoryDataToJson(
        InquiryListCategoryData instance) =>
    <String, dynamic>{
      'billName': instance.billName,
      'amount': instance.amount,
      'billCode': instance.billCode,
    };
