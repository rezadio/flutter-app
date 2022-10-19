import 'package:json_annotation/json_annotation.dart';

part 'sub_account.g.dart';

@JsonSerializable()
class ResSubAccList {
  @JsonKey(name: 'ACK')
  final String ack;
  final String? pesan;
  @JsonKey(name: 'dataExtended')
  final List<ListSubAcc> listAcc;

  ResSubAccList({required this.ack, this.pesan, required this.listAcc});
  factory ResSubAccList.fromJson(Map<String, dynamic> json) =>
      _$ResSubAccListFromJson(json);
}

@JsonSerializable()
class ListSubAcc {
  final String idExt;
  final String phone;
  final DateTime created;
  final bool lockFund;
  final String name;
  final String limit;
  final String used;
  final String usedDaily;
  final String updated;
  final String parentId;
  final String email;
  final String relation;
  final bool status;
  final bool deactive;
  final bool flagActive;
  final String limitDaily;
  final String counterPin;

  ListSubAcc({
    required this.idExt,
    required this.phone,
    required this.created,
    required this.lockFund,
    required this.name,
    required this.limit,
    required this.used,
    required this.updated,
    required this.parentId,
    required this.email,
    required this.relation,
    required this.status,
    required this.limitDaily,
    required this.usedDaily,
    required this.deactive,
    required this.flagActive,
    required this.counterPin,
  });
  factory ListSubAcc.fromJson(Map<String, dynamic> json) =>
      _$ListSubAccFromJson(json);
}

@JsonSerializable()
class SubAccountResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final SubAccountDetail dataExtended;

  SubAccountResponse({required this.ack, required this.dataExtended});
  factory SubAccountResponse.fromJson(Map<String, dynamic> data) =>
      _$SubAccountResponseFromJson(data);
}

@JsonSerializable()
class SubAccountDetail {
  final String limitDaily;
  final String used;
  final String parentId;
  final String relation;
  final String idExt;
  final String phone;
  final bool lockFund;
  final String name;
  final String limit;
  final String counterPin;
  final bool deactive;
  final String email;
  final bool status;

  SubAccountDetail(
      {required this.limitDaily,
      required this.used,
      required this.parentId,
      required this.relation,
      required this.idExt,
      required this.phone,
      required this.lockFund,
      required this.name,
      required this.limit,
      required this.counterPin,
      required this.deactive,
      required this.email,
      required this.status});
  factory SubAccountDetail.fromJson(Map<String, dynamic> json) =>
      _$SubAccountDetailFromJson(json);
}
