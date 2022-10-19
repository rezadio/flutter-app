// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) {
  return BalanceModel(
    infoMember:
        _InfoMember.fromJson(json['infoMember'] as Map<String, dynamic>),
    ack: json['ACK'] as String,
    infoAgent: json['infoAgent'] == null
        ? null
        : _InfoAgent.fromJson(json['infoAgent'] as Map<String, dynamic>),
    infoExtended: json['infoExtended'] == null
        ? null
        : _InfoExtended.fromJson(json['infoExtended'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'infoMember': instance.infoMember,
      'infoAgent': instance.infoAgent,
      'infoExtended': instance.infoExtended,
    };

_InfoMember _$_InfoMemberFromJson(Map<String, dynamic> json) {
  return _InfoMember(
    monthLimit: json['limitBulananCashin'] as String?,
    groupId: json['group_id'] as int,
    lastBalance: json['LastBalance'] as String,
  );
}

Map<String, dynamic> _$_InfoMemberToJson(_InfoMember instance) =>
    <String, dynamic>{
      'limitBulananCashin': instance.monthLimit,
      'group_id': instance.groupId,
      'LastBalance': instance.lastBalance,
    };

_InfoAgent _$_InfoAgentFromJson(Map<String, dynamic> json) {
  return _InfoAgent();
}

Map<String, dynamic> _$_InfoAgentToJson(_InfoAgent instance) =>
    <String, dynamic>{};

_InfoExtended _$_InfoExtendedFromJson(Map<String, dynamic> json) {
  return _InfoExtended(
    extLimit: json['ms_ext_limit'] as String,
    extUsed: json['ms_ext_used'] as String,
    extDailyLimit: json['ms_ext_daily_limit'] as String,
    extDailyUsed: json['ms_ext_used_daily'] as String,
  );
}

Map<String, dynamic> _$_InfoExtendedToJson(_InfoExtended instance) =>
    <String, dynamic>{
      'ms_ext_limit': instance.extLimit,
      'ms_ext_used': instance.extUsed,
      'ms_ext_daily_limit': instance.extDailyLimit,
      'ms_ext_used_daily': instance.extDailyUsed,
    };
