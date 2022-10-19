// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statement _$StatementFromJson(Map<String, dynamic> json) {
  return Statement(
    ack: json['ACK'] as String,
    dataNotifikasi: (json['dataNotifikasi'] as List<dynamic>)
        .map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StatementToJson(Statement instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataNotifikasi': instance.dataNotifikasi,
    };

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return NotificationData(
    timeStamp: DateTime.parse(json['timeStamp'] as String),
    keterangan: json['keterangan'] as String,
    total: json['total'] as String,
    statusTrx: json['statusTrx'] as String,
    tipeTransaksi: json['tipeTransaksi'] as String,
    idPrint: json['id_print'] as String,
  );
}

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'timeStamp': instance.timeStamp.toIso8601String(),
      'keterangan': instance.keterangan,
      'total': instance.total,
      'statusTrx': instance.statusTrx,
      'tipeTransaksi': instance.tipeTransaksi,
      'id_print': instance.idPrint,
    };
