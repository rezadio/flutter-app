import 'package:json_annotation/json_annotation.dart';

part 'qris.g.dart';

@JsonSerializable()
class Qris {
  final String pesan;
  final String nama;
  final String data;
  final String city;
  @JsonKey(name: 'ACK')
  final String ack;

  Qris(
      {required this.pesan,
      required this.nama,
      required this.data,
      required this.city,
      required this.ack});
  factory Qris.fromJson(Map<String, dynamic> json) => _$QrisFromJson(json);
  Map<String, dynamic> toJson() => _$QrisToJson(this);
}

@JsonSerializable()
class QrisData {
  final String approvalCode;
  @JsonKey(name: 'GloballyUniqueIdentifier')
  final String globallyUniqueIdentifier;
  @JsonKey(name: 'MPAN')
  final String mpan;
  @JsonKey(name: 'MPANCRC')
  final String mpanCrc;
  @JsonKey(name: 'MPANJalin')
  final String mpanJalin;

  const QrisData(
      {required this.approvalCode,
      required this.globallyUniqueIdentifier,
      required this.mpan,
      required this.mpanCrc,
      required this.mpanJalin});
  factory QrisData.fromJson(Map<String, dynamic> json) =>
      _$QrisDataFromJson(json);
}

@JsonSerializable()
class InquiryQris {
  final String merchantCode, merchantName, logo;
  final int fee, amount;

  const InquiryQris(
      {required this.merchantCode,
      required this.merchantName,
      required this.logo,
      required this.fee,
      required this.amount});
  factory InquiryQris.fromJson(Map<String, dynamic> json) =>
      _$InquiryQrisFromJson(json);
  Map<String, dynamic> toJson() => _$InquiryQrisToJson(this);
}
