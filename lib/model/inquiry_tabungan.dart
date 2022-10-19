import 'package:json_annotation/json_annotation.dart';

part 'inquiry_tabungan.g.dart';

@JsonSerializable()
class InquiryTabungan {
  final String rc;
  @JsonKey(name: 'ACK')
  final String ack;
  final int hargaJual;
  final int hargaBeli;
  final DataListCategory dataListCategory;

  InquiryTabungan(
      {required this.rc,
      required this.ack,
      required this.hargaJual,
      required this.hargaBeli,
      required this.dataListCategory});
  factory InquiryTabungan.fromJson(Map<String, dynamic> json) =>
      _$InquiryTabunganFromJson(json);
  Map<String, dynamic> toJson() => _$InquiryTabunganToJson(this);
}

@JsonSerializable()
class DataListCategory {
  final String merchantPhone;
  final String kelas;
  final String payerName;
  final String payerNumber;
  final String customerNumber;
  final String customerName;
  final String reffNum;
  final String merchantName;

  DataListCategory(
      {required this.merchantPhone,
      required this.kelas,
      required this.payerName,
      required this.payerNumber,
      required this.customerNumber,
      required this.customerName,
      required this.reffNum,
      required this.merchantName});
  factory DataListCategory.fromJson(Map<String, dynamic> json) =>
      _$DataListCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$DataListCategoryToJson(this);
}
