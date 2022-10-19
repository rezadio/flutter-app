import 'package:json_annotation/json_annotation.dart';

part 'pulsa_model.g.dart';

@JsonSerializable()
class PulsaRest {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<Pulsa> dataDenom;

  PulsaRest({required this.dataDenom, required this.ack});

  factory PulsaRest.fromJson(Map<String, dynamic> json) =>
      _$PulsaRestFromJson(json);
}

@JsonSerializable()
class Pulsa {
  final String idOperator;
  final String idDenom;
  final String nominal;
  final String idSupplier;
  final String hargaCetak;
  final String idPrefix;
  final String namaOperator;

  Pulsa({
    required this.idOperator,
    required this.idDenom,
    required this.nominal,
    required this.idSupplier,
    required this.hargaCetak,
    required this.idPrefix,
    required this.namaOperator,
  });

  factory Pulsa.fromJson(Map<String, dynamic> json) => _$PulsaFromJson(json);
}

@JsonSerializable()
class DataRest {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<PaketData> dataDenom;

  DataRest({required this.dataDenom, required this.ack});

  factory DataRest.fromJson(Map<String, dynamic> json) =>
      _$DataRestFromJson(json);
}

@JsonSerializable()
class PaketData {
  final String idOperator;
  final String nominal;
  final String hargaCetak;
  final String idPrefix;
  final String namaOperator;

  PaketData(
      {required this.idOperator,
      required this.nominal,
      required this.hargaCetak,
      required this.idPrefix,
      required this.namaOperator});

  factory PaketData.fromJson(Map<String, dynamic> json) =>
      _$PaketDataFromJson(json);
}
