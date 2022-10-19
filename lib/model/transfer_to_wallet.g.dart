// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_to_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferToWallet _$TransferToWalletFromJson(Map<String, dynamic> json) {
  return TransferToWallet(
    receiverName: json['receivername'] as String,
    rc: json['rc'] as String,
    responseCode: json['ResponseCode'] as String,
    total: json['total'] as int,
    receiverType: json['receivertype'] as String,
    nominal: json['nominal'] as String,
    transId: json['transid'] as String,
    ack: json['ACK'] as String,
    adminFee: json['adminfee'] as String,
    senderType: json['sendertype'] as String,
    message: json['message'] as String,
    idReceiver: json['idreceiver'] as String,
  );
}

Map<String, dynamic> _$TransferToWalletToJson(TransferToWallet instance) =>
    <String, dynamic>{
      'receivername': instance.receiverName,
      'rc': instance.rc,
      'ResponseCode': instance.responseCode,
      'total': instance.total,
      'receivertype': instance.receiverType,
      'nominal': instance.nominal,
      'transid': instance.transId,
      'ACK': instance.ack,
      'adminfee': instance.adminFee,
      'sendertype': instance.senderType,
      'message': instance.message,
      'idreceiver': instance.idReceiver,
    };
