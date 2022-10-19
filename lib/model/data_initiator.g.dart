// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_initiator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataInitiator _$DataInitiatorFromJson(Map<String, dynamic> json) {
  return DataInitiator(
    trxFeeMember: json['trx_fee_member'] as String,
    initiatorId: json['initiator_id'] as String,
    initiatorName: json['initiator_name'] as String,
  );
}

Map<String, dynamic> _$DataInitiatorToJson(DataInitiator instance) =>
    <String, dynamic>{
      'trx_fee_member': instance.trxFeeMember,
      'initiator_id': instance.initiatorId,
      'initiator_name': instance.initiatorName,
    };
