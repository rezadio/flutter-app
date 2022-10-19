import 'package:json_annotation/json_annotation.dart';

part 'recent_transaction.g.dart';

@JsonSerializable()
class RecentTransaction {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataLastTrx> dataLastTrx;

  RecentTransaction({required this.ack, required this.dataLastTrx});
  factory RecentTransaction.fromJson(Map<String, dynamic> json) =>
      _$RecentTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$RecentTransactionToJson(this);
}

@JsonSerializable()
class DataLastTrx {
  final String? noHpTujuan;
  final String? noRekTujuan;
  final String total;
  final String typeTRX;
  final String keterangan;
  final String timeStamp;
  final String idTipetransaksi;
  final String namaTipeTransaksi;

  DataLastTrx({
    this.noHpTujuan,
    this.noRekTujuan,
    required this.total,
    required this.typeTRX,
    required this.keterangan,
    required this.timeStamp,
    required this.idTipetransaksi,
    required this.namaTipeTransaksi,
  });
  factory DataLastTrx.fromJson(Map<String, dynamic> json) =>
      _$DataLastTrxFromJson(json);
  Map<String, dynamic> toJson() => _$DataLastTrxToJson(this);
}
