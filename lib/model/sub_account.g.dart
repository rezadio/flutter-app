// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResSubAccList _$ResSubAccListFromJson(Map<String, dynamic> json) {
  return ResSubAccList(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String?,
    listAcc: (json['dataExtended'] as List<dynamic>)
        .map((e) => ListSubAcc.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResSubAccListToJson(ResSubAccList instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'dataExtended': instance.listAcc,
    };

ListSubAcc _$ListSubAccFromJson(Map<String, dynamic> json) {
  return ListSubAcc(
    idExt: json['idExt'] as String,
    phone: json['phone'] as String,
    created: DateTime.parse(json['created'] as String),
    lockFund: json['lockFund'] as bool,
    name: json['name'] as String,
    limit: json['limit'] as String,
    used: json['used'] as String,
    updated: json['updated'] as String,
    parentId: json['parentId'] as String,
    email: json['email'] as String,
    relation: json['relation'] as String,
    status: json['status'] as bool,
    limitDaily: json['limitDaily'] as String,
    usedDaily: json['usedDaily'] as String,
    deactive: json['deactive'] as bool,
    flagActive: json['flagActive'] as bool,
    counterPin: json['counterPin'] as String,
  );
}

Map<String, dynamic> _$ListSubAccToJson(ListSubAcc instance) =>
    <String, dynamic>{
      'idExt': instance.idExt,
      'phone': instance.phone,
      'created': instance.created.toIso8601String(),
      'lockFund': instance.lockFund,
      'name': instance.name,
      'limit': instance.limit,
      'used': instance.used,
      'usedDaily': instance.usedDaily,
      'updated': instance.updated,
      'parentId': instance.parentId,
      'email': instance.email,
      'relation': instance.relation,
      'status': instance.status,
      'deactive': instance.deactive,
      'flagActive': instance.flagActive,
      'limitDaily': instance.limitDaily,
      'counterPin': instance.counterPin,
    };

SubAccountResponse _$SubAccountResponseFromJson(Map<String, dynamic> json) {
  return SubAccountResponse(
    ack: json['ACK'] as String,
    dataExtended:
        SubAccountDetail.fromJson(json['dataExtended'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SubAccountResponseToJson(SubAccountResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataExtended': instance.dataExtended,
    };

SubAccountDetail _$SubAccountDetailFromJson(Map<String, dynamic> json) {
  return SubAccountDetail(
    limitDaily: json['limitDaily'] as String,
    used: json['used'] as String,
    parentId: json['parentId'] as String,
    relation: json['relation'] as String,
    idExt: json['idExt'] as String,
    phone: json['phone'] as String,
    lockFund: json['lockFund'] as bool,
    name: json['name'] as String,
    limit: json['limit'] as String,
    counterPin: json['counterPin'] as String,
    deactive: json['deactive'] as bool,
    email: json['email'] as String,
    status: json['status'] as bool,
  );
}

Map<String, dynamic> _$SubAccountDetailToJson(SubAccountDetail instance) =>
    <String, dynamic>{
      'limitDaily': instance.limitDaily,
      'used': instance.used,
      'parentId': instance.parentId,
      'relation': instance.relation,
      'idExt': instance.idExt,
      'phone': instance.phone,
      'lockFund': instance.lockFund,
      'name': instance.name,
      'limit': instance.limit,
      'counterPin': instance.counterPin,
      'deactive': instance.deactive,
      'email': instance.email,
      'status': instance.status,
    };
