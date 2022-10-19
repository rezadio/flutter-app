import 'package:json_annotation/json_annotation.dart';

part 'data_initiator.g.dart';

@JsonSerializable()
class DataInitiator {
  @JsonKey(name: 'trx_fee_member')
  final String trxFeeMember;
  @JsonKey(name: 'initiator_id')
  final String initiatorId;
  @JsonKey(name: 'initiator_name')
  final String initiatorName;

  DataInitiator(
      {required this.trxFeeMember,
      required this.initiatorId,
      required this.initiatorName});
  factory DataInitiator.fromJson(Map<String, dynamic> json) =>
      _$DataInitiatorFromJson(json);
  Map<String, dynamic> toJson() => _$DataInitiatorToJson(this);
}
