// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulsa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PulsaRest _$PulsaRestFromJson(Map<String, dynamic> json) {
  return PulsaRest(
    dataDenom: (json['dataDenom'] as List<dynamic>)
        .map((e) => Pulsa.fromJson(e as Map<String, dynamic>))
        .toList(),
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$PulsaRestToJson(PulsaRest instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataDenom': instance.dataDenom,
    };

Pulsa _$PulsaFromJson(Map<String, dynamic> json) {
  return Pulsa(
    idOperator: json['idOperator'] as String,
    idDenom: json['idDenom'] as String,
    nominal: json['nominal'] as String,
    idSupplier: json['idSupplier'] as String,
    hargaCetak: json['hargaCetak'] as String,
    idPrefix: json['idPrefix'] as String,
    namaOperator: json['namaOperator'] as String,
  );
}

Map<String, dynamic> _$PulsaToJson(Pulsa instance) => <String, dynamic>{
      'idOperator': instance.idOperator,
      'idDenom': instance.idDenom,
      'nominal': instance.nominal,
      'idSupplier': instance.idSupplier,
      'hargaCetak': instance.hargaCetak,
      'idPrefix': instance.idPrefix,
      'namaOperator': instance.namaOperator,
    };

DataRest _$DataRestFromJson(Map<String, dynamic> json) {
  return DataRest(
    dataDenom: (json['dataDenom'] as List<dynamic>)
        .map((e) => PaketData.fromJson(e as Map<String, dynamic>))
        .toList(),
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$DataRestToJson(DataRest instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataDenom': instance.dataDenom,
    };

PaketData _$PaketDataFromJson(Map<String, dynamic> json) {
  return PaketData(
    idOperator: json['idOperator'] as String,
    nominal: json['nominal'] as String,
    hargaCetak: json['hargaCetak'] as String,
    idPrefix: json['idPrefix'] as String,
    namaOperator: json['namaOperator'] as String,
  );
}

Map<String, dynamic> _$PaketDataToJson(PaketData instance) => <String, dynamic>{
      'idOperator': instance.idOperator,
      'nominal': instance.nominal,
      'hargaCetak': instance.hargaCetak,
      'idPrefix': instance.idPrefix,
      'namaOperator': instance.namaOperator,
    };
