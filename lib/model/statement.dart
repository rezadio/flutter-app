import 'package:json_annotation/json_annotation.dart';

part 'statement.g.dart';

@JsonSerializable()
class Statement {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<NotificationData> dataNotifikasi;

  Statement({required this.ack, required this.dataNotifikasi});
  factory Statement.fromJson(Map<String, dynamic> json) =>
      _$StatementFromJson(json);
  Map<String, dynamic> toJson() => _$StatementToJson(this);
}

@JsonSerializable()
class NotificationData {
  final DateTime timeStamp;
  final String keterangan;
  final String total;
  final String statusTrx;
  final String tipeTransaksi;
  @JsonKey(name: 'id_print')
  final String idPrint;

  NotificationData({
    required this.timeStamp,
    required this.keterangan,
    required this.total,
    required this.statusTrx,
    required this.tipeTransaksi,
    required this.idPrint,
  });
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}
