import 'package:json_annotation/json_annotation.dart';

part 'transfer_to_bank.g.dart';

@JsonSerializable()
class TransferToBank {
  @JsonKey(name: 'Status')
  final String status;
  @JsonKey(name: 'TrxId')
  final String trxId;
  final String nominalTransfer;
  final String kodeBank;
  @JsonKey(name: 'ACK')
  final String ack;
  final String namaTujuan;
  final String namaBank;
  final String namaPengirim;
  final String kodeBankHuruf;
  @JsonKey(name: 'Signature')
  final String signature;
  final String hargaCetak;
  final int idBank;
  final String nomorRekeningTujuan;
  @JsonKey(name: 'ID')
  final String id;
  final String remark1;
  final String biayaTransferBank;
  final String remark2;

  TransferToBank({
    required this.status,
    required this.trxId,
    required this.nominalTransfer,
    required this.kodeBank,
    required this.ack,
    required this.namaTujuan,
    required this.namaBank,
    required this.namaPengirim,
    required this.kodeBankHuruf,
    required this.signature,
    required this.hargaCetak,
    required this.idBank,
    required this.nomorRekeningTujuan,
    required this.id,
    required this.remark1,
    required this.biayaTransferBank,
    required this.remark2,
  });
  factory TransferToBank.fromJson(Map<String, dynamic> json) =>
      _$TransferToBankFromJson(json);
  Map<String, dynamic> toJson() => _$TransferToBankToJson(this);
}
