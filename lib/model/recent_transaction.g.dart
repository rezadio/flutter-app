// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTransaction _$RecentTransactionFromJson(Map<String, dynamic> json) {
  return RecentTransaction(
    ack: json['ACK'] as String,
    dataLastTrx: (json['dataLastTrx'] as List<dynamic>)
        .map((e) => DataLastTrx.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RecentTransactionToJson(RecentTransaction instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataLastTrx': instance.dataLastTrx,
    };

DataLastTrx _$DataLastTrxFromJson(Map<String, dynamic> json) {
  return DataLastTrx(
    noHpTujuan: json['noHpTujuan'] as String?,
    noRekTujuan: json['noRekTujuan'] as String?,
    total: json['total'] as String,
    typeTRX: json['typeTRX'] as String,
    keterangan: json['keterangan'] as String,
    timeStamp: json['timeStamp'] as String,
    idTipetransaksi: json['idTipetransaksi'] as String,
    namaTipeTransaksi: json['namaTipeTransaksi'] as String,
  );
}

Map<String, dynamic> _$DataLastTrxToJson(DataLastTrx instance) =>
    <String, dynamic>{
      'noHpTujuan': instance.noHpTujuan,
      'noRekTujuan': instance.noRekTujuan,
      'total': instance.total,
      'typeTRX': instance.typeTRX,
      'keterangan': instance.keterangan,
      'timeStamp': instance.timeStamp,
      'idTipetransaksi': instance.idTipetransaksi,
      'namaTipeTransaksi': instance.namaTipeTransaksi,
    };
