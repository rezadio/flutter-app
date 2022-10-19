// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topup_merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DenomMerchant _$DenomMerchantFromJson(Map<String, dynamic> json) {
  return DenomMerchant(
    ack: json['ACK'] as String,
    denom: (json['denom'] as List<dynamic>)
        .map((e) => Denom.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DenomMerchantToJson(DenomMerchant instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'denom': instance.denom,
    };

Denom _$DenomFromJson(Map<String, dynamic> json) {
  return Denom(
    idDenom: json['idDenom'] as String,
    nominal: json['nominal'] as String,
    hargaCetak: json['hargaCetak'] as String,
  );
}

Map<String, dynamic> _$DenomToJson(Denom instance) => <String, dynamic>{
      'idDenom': instance.idDenom,
      'nominal': instance.nominal,
      'hargaCetak': instance.hargaCetak,
    };

MerchantPaymentCodeResponse _$MerchantPaymentCodeResponseFromJson(
    Map<String, dynamic> json) {
  return MerchantPaymentCodeResponse(
    ack: json['ACK'] as String,
    data: MerchantPaymentCode.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MerchantPaymentCodeResponseToJson(
        MerchantPaymentCodeResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'data': instance.data,
    };

MerchantPaymentCode _$MerchantPaymentCodeFromJson(Map<String, dynamic> json) {
  return MerchantPaymentCode(
    amount: json['amount'] as int,
    responseCode: json['ResponseCode'] as String,
    responseDescription: json['responseDescription'] as String,
    dateExpired: DateTime.parse(json['dateExpired'] as String),
    description: json['description'] as String,
    billNumber: json['billNumber'] as String,
    customerName: json['customerName'] as String,
  );
}

Map<String, dynamic> _$MerchantPaymentCodeToJson(
        MerchantPaymentCode instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'ResponseCode': instance.responseCode,
      'responseDescription': instance.responseDescription,
      'dateExpired': instance.dateExpired.toIso8601String(),
      'description': instance.description,
      'billNumber': instance.billNumber,
      'customerName': instance.customerName,
    };
