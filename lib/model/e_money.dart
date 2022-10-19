import 'package:json_annotation/json_annotation.dart';

part 'e_money.g.dart';

@JsonSerializable()
class EMoney {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<Operator> listEmoney;

  EMoney({required this.ack, required this.listEmoney});
  factory EMoney.fromJson(Map<String, dynamic> json) => _$EMoneyFromJson(json);
  Map<String, dynamic> toJson() => _$EMoneyToJson(this);
}

@JsonSerializable()
class Operator {
  final String idOperator;
  final String namaOperator;

  Operator({required this.idOperator, required this.namaOperator});
  factory Operator.fromJson(Map<String, dynamic> json) =>
      _$OperatorFromJson(json);
  Map<String, dynamic> toJson() => _$OperatorToJson(this);
}

@JsonSerializable()
class EMoneyDenom {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataDenom> dataDenom;

  EMoneyDenom({required this.ack, required this.dataDenom});
  factory EMoneyDenom.fromJson(Map<String, dynamic> json) =>
      _$EMoneyDenomFromJson(json);
  Map<String, dynamic> toJson() => _$EMoneyDenomToJson(this);
}

@JsonSerializable()
class DataDenom {
  final String idOperator;
  final String idDenom;
  final String nominal;
  final String idSupplier;
  final String hargaCetak;
  final String namaOperator;

  DataDenom(
      {required this.idOperator,
      required this.idDenom,
      required this.nominal,
      required this.idSupplier,
      required this.hargaCetak,
      required this.namaOperator});
  factory DataDenom.fromJson(Map<String, dynamic> json) =>
      _$DataDenomFromJson(json);
  Map<String, dynamic> toJson() => _$DataDenomToJson(this);
}

@JsonSerializable()
class EMoneySuccess {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final String idTrx;
  final String status;
  final DateTime timestamp;

  EMoneySuccess(
      {required this.ack,
      required this.pesan,
      required this.idTrx,
      required this.status,
      required this.timestamp});
  factory EMoneySuccess.fromJson(Map<String, dynamic> json) =>
      _$EMoneySuccessFromJson(json);
  Map<String, dynamic> toJson() => _$EMoneySuccessToJson(this);
}
