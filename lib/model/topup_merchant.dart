import 'package:json_annotation/json_annotation.dart';

part 'topup_merchant.g.dart';

@JsonSerializable()
class DenomMerchant {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<Denom> denom;

  DenomMerchant({required this.ack, required this.denom});
  factory DenomMerchant.fromJson(Map<String, dynamic> json) =>
      _$DenomMerchantFromJson(json);
}

@JsonSerializable()
class Denom {
  final String idDenom;
  final String nominal;
  final String hargaCetak;

  Denom(
      {required this.idDenom, required this.nominal, required this.hargaCetak});
  factory Denom.fromJson(Map<String, dynamic> json) => _$DenomFromJson(json);
}

@JsonSerializable()
class MerchantPaymentCodeResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final MerchantPaymentCode data;

  MerchantPaymentCodeResponse({required this.ack, required this.data});
  factory MerchantPaymentCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$MerchantPaymentCodeResponseFromJson(json);
}

@JsonSerializable()
class MerchantPaymentCode {
  final int amount;
  @JsonKey(name: 'ResponseCode')
  final String responseCode;
  final String responseDescription;
  final DateTime dateExpired;
  final String description;
  final String billNumber;
  final String customerName;

  MerchantPaymentCode(
      {required this.amount,
      required this.responseCode,
      required this.responseDescription,
      required this.dateExpired,
      required this.description,
      required this.billNumber,
      required this.customerName});
  factory MerchantPaymentCode.fromJson(Map<String, dynamic> json) =>
      _$MerchantPaymentCodeFromJson(json);
}
