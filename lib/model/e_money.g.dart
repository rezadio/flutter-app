// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EMoney _$EMoneyFromJson(Map<String, dynamic> json) {
  return EMoney(
    ack: json['ACK'] as String,
    listEmoney: (json['listEmoney'] as List<dynamic>)
        .map((e) => Operator.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EMoneyToJson(EMoney instance) => <String, dynamic>{
      'ACK': instance.ack,
      'listEmoney': instance.listEmoney,
    };

Operator _$OperatorFromJson(Map<String, dynamic> json) {
  return Operator(
    idOperator: json['idOperator'] as String,
    namaOperator: json['namaOperator'] as String,
  );
}

Map<String, dynamic> _$OperatorToJson(Operator instance) => <String, dynamic>{
      'idOperator': instance.idOperator,
      'namaOperator': instance.namaOperator,
    };

EMoneyDenom _$EMoneyDenomFromJson(Map<String, dynamic> json) {
  return EMoneyDenom(
    ack: json['ACK'] as String,
    dataDenom: (json['dataDenom'] as List<dynamic>)
        .map((e) => DataDenom.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EMoneyDenomToJson(EMoneyDenom instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataDenom': instance.dataDenom,
    };

DataDenom _$DataDenomFromJson(Map<String, dynamic> json) {
  return DataDenom(
    idOperator: json['idOperator'] as String,
    idDenom: json['idDenom'] as String,
    nominal: json['nominal'] as String,
    idSupplier: json['idSupplier'] as String,
    hargaCetak: json['hargaCetak'] as String,
    namaOperator: json['namaOperator'] as String,
  );
}

Map<String, dynamic> _$DataDenomToJson(DataDenom instance) => <String, dynamic>{
      'idOperator': instance.idOperator,
      'idDenom': instance.idDenom,
      'nominal': instance.nominal,
      'idSupplier': instance.idSupplier,
      'hargaCetak': instance.hargaCetak,
      'namaOperator': instance.namaOperator,
    };

EMoneySuccess _$EMoneySuccessFromJson(Map<String, dynamic> json) {
  return EMoneySuccess(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    idTrx: json['idTrx'] as String,
    status: json['status'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$EMoneySuccessToJson(EMoneySuccess instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'idTrx': instance.idTrx,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
    };
