import 'package:json_annotation/json_annotation.dart';

part 'direct_debit.g.dart';

@JsonSerializable()
class DirectDebitInit {
  @JsonKey(name: 'ACK')
  final String ack;
  final String data;

  DirectDebitInit({required this.ack, required this.data});
  factory DirectDebitInit.fromJson(Map<String, dynamic> json) =>
      _$DirectDebitInitFromJson(json);
}

@JsonSerializable()
class DirectDebitInitData {
  @JsonKey(name: 'ResponseCode')
  final String responseCode;
  @JsonKey(name: 'masked_phone_number')
  final String maskedPhoneNumber;
  @JsonKey(name: 'session_token')
  final String sessionToken;
  @JsonKey(name: 'otp_ref_num')
  final String otpRefNum;

  DirectDebitInitData(
      {required this.responseCode,
      required this.maskedPhoneNumber,
      required this.sessionToken,
      required this.otpRefNum});
  factory DirectDebitInitData.fromJson(Map<String, dynamic> json) =>
      _$DirectDebitInitDataFromJson(json);
}

@JsonSerializable()
class DebitCard {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DebitCardData> data;

  DebitCard({required this.ack, required this.data});
  factory DebitCard.fromJson(Map<String, dynamic> json) =>
      _$DebitCardFromJson(json);
}

@JsonSerializable()
class DebitCardData {
  final int id;
  final String cardNum;
  final String expiredDate;
  final String nameHolder;
  final String cardType;

  DebitCardData(
      {required this.id,
      required this.cardNum,
      required this.expiredDate,
      required this.nameHolder,
      required this.cardType});
  factory DebitCardData.fromJson(Map<String, dynamic> json) =>
      _$DebitCardDataFromJson(json);
}
