// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_to_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferToBank _$TransferToBankFromJson(Map<String, dynamic> json) {
  return TransferToBank(
    status: json['Status'] as String,
    trxId: json['TrxId'] as String,
    nominalTransfer: json['nominalTransfer'] as String,
    kodeBank: json['kodeBank'] as String,
    ack: json['ACK'] as String,
    namaTujuan: json['namaTujuan'] as String,
    namaBank: json['namaBank'] as String,
    namaPengirim: json['namaPengirim'] as String,
    kodeBankHuruf: json['kodeBankHuruf'] as String,
    signature: json['Signature'] as String,
    hargaCetak: json['hargaCetak'] as String,
    idBank: json['idBank'] as int,
    nomorRekeningTujuan: json['nomorRekeningTujuan'] as String,
    id: json['ID'] as String,
    remark1: json['remark1'] as String,
    biayaTransferBank: json['biayaTransferBank'] as String,
    remark2: json['remark2'] as String,
  );
}

Map<String, dynamic> _$TransferToBankToJson(TransferToBank instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'TrxId': instance.trxId,
      'nominalTransfer': instance.nominalTransfer,
      'kodeBank': instance.kodeBank,
      'ACK': instance.ack,
      'namaTujuan': instance.namaTujuan,
      'namaBank': instance.namaBank,
      'namaPengirim': instance.namaPengirim,
      'kodeBankHuruf': instance.kodeBankHuruf,
      'Signature': instance.signature,
      'hargaCetak': instance.hargaCetak,
      'idBank': instance.idBank,
      'nomorRekeningTujuan': instance.nomorRekeningTujuan,
      'ID': instance.id,
      'remark1': instance.remark1,
      'biayaTransferBank': instance.biayaTransferBank,
      'remark2': instance.remark2,
    };
