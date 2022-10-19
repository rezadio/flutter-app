import 'package:json_annotation/json_annotation.dart';

part 'transfer_to_wallet.g.dart';

@JsonSerializable()
class TransferToWallet {
  @JsonKey(name: 'receivername')
  final String receiverName;
  final String rc;
  @JsonKey(name: 'ResponseCode')
  final String responseCode;
  final int total;
  @JsonKey(name: 'receivertype')
  final String receiverType;
  final String nominal;
  @JsonKey(name: 'transid')
  final String transId;
  @JsonKey(name: 'ACK')
  final String ack;
  @JsonKey(name: 'adminfee')
  final String adminFee;
  @JsonKey(name: 'sendertype')
  final String senderType;
  final String message;
  @JsonKey(name: 'idreceiver')
  final String idReceiver;

  TransferToWallet(
      {required this.receiverName,
      required this.rc,
      required this.responseCode,
      required this.total,
      required this.receiverType,
      required this.nominal,
      required this.transId,
      required this.ack,
      required this.adminFee,
      required this.senderType,
      required this.message,
      required this.idReceiver});
  factory TransferToWallet.fromJson(Map<String, dynamic> json) =>
      _$TransferToWalletFromJson(json);
  Map<String, dynamic> toJson() => _$TransferToWalletToJson(this);
}
