import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable()
class BalanceModel {
  @JsonKey(name: 'ACK')
  final String ack;
  final _InfoMember infoMember;
  final _InfoAgent? infoAgent;
  final _InfoExtended? infoExtended;

  const BalanceModel(
      {required this.infoMember,
      required this.ack,
      this.infoAgent,
      this.infoExtended});
  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);
}

@JsonSerializable()
class _InfoMember {
  @JsonKey(name: 'limitBulananCashin')
  final String? monthLimit;
  @JsonKey(name: 'group_id')
  final int groupId;
  @JsonKey(name: 'LastBalance')
  final String lastBalance;

  _InfoMember(
      {this.monthLimit, required this.groupId, required this.lastBalance});
  factory _InfoMember.fromJson(Map<String, dynamic> json) =>
      _$_InfoMemberFromJson(json);
  Map<String, dynamic> toJson() => _$_InfoMemberToJson(this);
}

@JsonSerializable()
class _InfoAgent {
  _InfoAgent();
  factory _InfoAgent.fromJson(Map<String, dynamic> json) =>
      _$_InfoAgentFromJson(json);
  Map<String, dynamic> toJson() => _$_InfoAgentToJson(this);
}

@JsonSerializable()
class _InfoExtended {
  @JsonKey(name: 'ms_ext_limit')
  final String extLimit;
  @JsonKey(name: 'ms_ext_used')
  final String extUsed;
  @JsonKey(name: 'ms_ext_daily_limit')
  final String extDailyLimit;
  @JsonKey(name: 'ms_ext_used_daily')
  final String extDailyUsed;

  _InfoExtended({
    required this.extLimit,
    required this.extUsed,
    required this.extDailyLimit,
    required this.extDailyUsed,
  });
  factory _InfoExtended.fromJson(Map<String, dynamic> json) =>
      _$_InfoExtendedFromJson(json);
}
