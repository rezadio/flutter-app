import 'package:json_annotation/json_annotation.dart';

part 'swiff.g.dart';

@JsonSerializable()
class SwiffInquiry {

  final String ack;
  final String merchantCode;
  final String total;
  final String nama;
  final String biaya;
  final String nominalBelanja;
  final DateTime dateTrx;


  SwiffInquiry(
      {required this.total,
      required this.nama,
      required this.ack,
      required this.biaya,
      required this.merchantCode,
      required this.nominalBelanja,
      required this.dateTrx});

  factory SwiffInquiry.fromJson(Map<String, dynamic> json) =>
      _$SwiffInquiryFromJson(json);
}
