// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    ack: json['ACK'] as String,
    dataBank: (json['dataBank'] as List<dynamic>)
        .map((e) => DataBank.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataBank': instance.dataBank,
    };

DataBank _$DataBankFromJson(Map<String, dynamic> json) {
  return DataBank(
    createDateDba: json['create_date_dba'] as String,
    initBank: json['initbank'] as String,
    namaBank: json['NamaBank'] as String,
    flagActive: json['FlagActive'] as String,
    timeStamp: json['TimeStamp'] as String,
    kodeBank: json['kodebank'] as String,
    kodeBankHuruf: json['kode_bank_huruf'] as String,
    idBank: json['id_bank'] as String,
    bankPriority: json['bank_priority'] as String,
    isOnline: json['is_online'] as String,
    isLlg: json['is_llg'] as String,
    modifyDate: json['modify_date'] as String,
    tipeTransfer: json['TipeTransfer'] as String,
    isRtg: json['is_rtg'] as String,
  );
}

Map<String, dynamic> _$DataBankToJson(DataBank instance) => <String, dynamic>{
      'create_date_dba': instance.createDateDba,
      'initbank': instance.initBank,
      'NamaBank': instance.namaBank,
      'FlagActive': instance.flagActive,
      'TimeStamp': instance.timeStamp,
      'kodebank': instance.kodeBank,
      'kode_bank_huruf': instance.kodeBankHuruf,
      'id_bank': instance.idBank,
      'bank_priority': instance.bankPriority,
      'is_online': instance.isOnline,
      'is_llg': instance.isLlg,
      'modify_date': instance.modifyDate,
      'TipeTransfer': instance.tipeTransfer,
      'is_rtg': instance.isRtg,
    };
