import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable()
class EducationList {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataListCategory> dataListCategory;

  EducationList({required this.ack, required this.dataListCategory});
  factory EducationList.fromJson(Map<String, dynamic> json) =>
      _$EducationListFromJson(json);
}

@JsonSerializable()
class EducationRandomList {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataListCategory> dataRandomCategory;

  EducationRandomList({required this.ack, required this.dataRandomCategory});
  factory EducationRandomList.fromJson(Map<String, dynamic> json) =>
      _$EducationRandomListFromJson(json);
}

@JsonSerializable()
class EducationCategory {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<EducationDataCategory> dataCategory;

  EducationCategory({required this.ack, required this.dataCategory});
  factory EducationCategory.fromJson(Map<String, dynamic> json) =>
      _$EducationCategoryFromJson(json);
}

@JsonSerializable()
class EducationDataCategory {
  final int id;
  final String categoryCode, categoryName;

  EducationDataCategory(
      {required this.id,
      required this.categoryCode,
      required this.categoryName});
  factory EducationDataCategory.fromJson(Map<String, dynamic> json) =>
      _$EducationDataCategoryFromJson(json);
}

@JsonSerializable()
class DataListCategory {
  final String edukasiName;
  final String? logo;
  final String id;

  DataListCategory({required this.edukasiName, this.logo, required this.id});
  factory DataListCategory.fromJson(Map<String, dynamic> json) =>
      _$DataListCategoryFromJson(json);
}

@JsonSerializable()
class EducationInquiry {
  final String rc;
  @JsonKey(name: 'ACK')
  final String ack;
  @JsonKey(name: 'dataListCategory')
  final InquiryListCategory inquiryListCategory;
  final int? hargaJual, hargaBeli;

  EducationInquiry(
      {required this.rc,
      required this.ack,
      required this.inquiryListCategory,
      this.hargaJual,
      this.hargaBeli});
  factory EducationInquiry.fromJson(Map<String, dynamic> json) =>
      _$EducationInquiryFromJson(json);
}

@JsonSerializable()
class InquiryListCategory {
  final int serviceFee;
  final String merchantPhone;
  final List<InquiryListCategoryData> datas;
  final String kelas;
  final String? payerName;
  final String? payerNumber;
  final String caraBayar;
  final String customerNumber;
  final String customerName;
  final String? reffNum;
  final String merchantName;

  InquiryListCategory({
    required this.serviceFee,
    required this.merchantPhone,
    required this.datas,
    required this.kelas,
    this.payerName,
    this.payerNumber,
    required this.caraBayar,
    required this.customerNumber,
    required this.customerName,
    this.reffNum,
    required this.merchantName,
  });
  factory InquiryListCategory.fromJson(Map<String, dynamic> json) =>
      _$InquiryListCategoryFromJson(json);
}

@JsonSerializable()
class InquiryListCategoryData {
  final String billName;
  final num amount;
  final String billCode;

  InquiryListCategoryData(
      {required this.billName, required this.amount, required this.billCode});
  factory InquiryListCategoryData.fromJson(Map<String, dynamic> json) =>
      _$InquiryListCategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$InquiryListCategoryDataToJson(this);
}
