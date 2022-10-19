// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_debit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectDebitInit _$DirectDebitInitFromJson(Map<String, dynamic> json) {
  return DirectDebitInit(
    ack: json['ACK'] as String,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$DirectDebitInitToJson(DirectDebitInit instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'data': instance.data,
    };

DirectDebitInitData _$DirectDebitInitDataFromJson(Map<String, dynamic> json) {
  return DirectDebitInitData(
    responseCode: json['ResponseCode'] as String,
    maskedPhoneNumber: json['masked_phone_number'] as String,
    sessionToken: json['session_token'] as String,
    otpRefNum: json['otp_ref_num'] as String,
  );
}

Map<String, dynamic> _$DirectDebitInitDataToJson(
        DirectDebitInitData instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'masked_phone_number': instance.maskedPhoneNumber,
      'session_token': instance.sessionToken,
      'otp_ref_num': instance.otpRefNum,
    };

DebitCard _$DebitCardFromJson(Map<String, dynamic> json) {
  return DebitCard(
    ack: json['ACK'] as String,
    data: (json['data'] as List<dynamic>)
        .map((e) => DebitCardData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DebitCardToJson(DebitCard instance) => <String, dynamic>{
      'ACK': instance.ack,
      'data': instance.data,
    };

DebitCardData _$DebitCardDataFromJson(Map<String, dynamic> json) {
  return DebitCardData(
    id: json['id'] as int,
    cardNum: json['cardNum'] as String,
    expiredDate: json['expiredDate'] as String,
    nameHolder: json['nameHolder'] as String,
    cardType: json['cardType'] as String,
  );
}

Map<String, dynamic> _$DebitCardDataToJson(DebitCardData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardNum': instance.cardNum,
      'expiredDate': instance.expiredDate,
      'nameHolder': instance.nameHolder,
      'cardType': instance.cardType,
    };
