import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class Bank {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataBank> dataBank;

  Bank({required this.ack, required this.dataBank});
  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
}

@JsonSerializable()
class DataBank {
  @JsonKey(name: 'create_date_dba')
  final String createDateDba;
  @JsonKey(name: 'initbank')
  final String initBank;
  @JsonKey(name: 'NamaBank')
  final String namaBank;
  @JsonKey(name: 'FlagActive')
  final String flagActive;
  @JsonKey(name: 'TimeStamp')
  final String timeStamp;
  @JsonKey(name: 'kodebank')
  final String kodeBank;
  @JsonKey(name: 'kode_bank_huruf')
  final String kodeBankHuruf;
  @JsonKey(name: 'id_bank')
  final String idBank;
  @JsonKey(name: 'bank_priority')
  final String bankPriority;
  @JsonKey(name: 'is_online')
  final String isOnline;
  @JsonKey(name: 'is_llg')
  final String isLlg;
  @JsonKey(name: 'modify_date')
  final String modifyDate;
  @JsonKey(name: 'TipeTransfer')
  final String tipeTransfer;
  @JsonKey(name: 'is_rtg')
  final String isRtg;

  DataBank({
    required this.createDateDba,
    required this.initBank,
    required this.namaBank,
    required this.flagActive,
    required this.timeStamp,
    required this.kodeBank,
    required this.kodeBankHuruf,
    required this.idBank,
    required this.bankPriority,
    required this.isOnline,
    required this.isLlg,
    required this.modifyDate,
    required this.tipeTransfer,
    required this.isRtg,
  });
  factory DataBank.fromJson(Map<String, dynamic> json) =>
      _$DataBankFromJson(json);
  Map<String, dynamic> toJson() => _$DataBankToJson(this);
}
