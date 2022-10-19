import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class GameResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<Game>? listGame;

  GameResponse({required this.ack, this.listGame});
  factory GameResponse.fromJson(Map<String, dynamic> json) =>
      _$GameResponseFromJson(json);
}

@JsonSerializable()
class Game {
  final String gameCategory;
  final String gameName;
  final String gameStatus;
  final String gameCode;
  final String iconUrl;
  final String categoryName;
  final String productName;
  final DateTime updatedAt;

  Game(
      {required this.gameCategory,
      required this.gameName,
      required this.gameStatus,
      required this.gameCode,
      required this.iconUrl,
      required this.categoryName,
      required this.productName,
      required this.updatedAt});
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

@JsonSerializable()
class GameDetailResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final String helpImg;
  final GameDetail game;
  final List<GameDenom> denom;
  final List<GameField> fields;

  GameDetailResponse(
      {required this.ack,
      required this.helpImg,
      required this.game,
      required this.denom,
      required this.fields});
  factory GameDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GameDetailResponseFromJson(json);
}

@JsonSerializable()
class GameDetail {
  final String nameGame, code, category;

  GameDetail(
      {required this.nameGame, required this.code, required this.category});
  factory GameDetail.fromJson(Map<String, dynamic> json) =>
      _$GameDetailFromJson(json);
}

@JsonSerializable()
class GameDenom {
  final int id;
  final String nameDenom, currency, amount;

  GameDenom(
      {required this.id,
      required this.nameDenom,
      required this.currency,
      required this.amount});
  factory GameDenom.fromJson(Map<String, dynamic> json) =>
      _$GameDenomFromJson(json);
}

@JsonSerializable()
class GameField {
  final String nameField, type;

  GameField({required this.nameField, required this.type});
  factory GameField.fromJson(Map<String, dynamic> json) =>
      _$GameFieldFromJson(json);
}

@JsonSerializable()
class GameInquiry {
  final String? biaya;
  final String? amount;
  final String? total;
  final String? server;
  final String gameName;
  final String gameCode;
  final String denominationId;
  final String denominationName;
  final String username;
  @JsonKey(name: 'user_id')
  final String userId;
  final String zoneId;
  final String token;
  @JsonKey(name: 'ACK')
  final String ack;

  GameInquiry(
      {this.biaya,
      this.amount,
      this.total,
      this.server,
      required this.gameName,
      required this.gameCode,
      required this.denominationId,
      required this.denominationName,
      required this.username,
      required this.userId,
      required this.zoneId,
      required this.token,
      required this.ack});
  factory GameInquiry.fromJson(Map<String, dynamic> json) =>
      _$GameInquiryFromJson(json);
}

@JsonSerializable()
class VoucherResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<Voucher>? listVoucher;

  VoucherResponse({required this.ack, this.listVoucher});
  factory VoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$VoucherResponseFromJson(json);
}

@JsonSerializable()
class Voucher {
  final String voucherName, iconUrl, voucherCode;

  Voucher(
      {required this.voucherName,
      required this.iconUrl,
      required this.voucherCode});
  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);
}

@JsonSerializable()
class VoucherDetail {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<VoucherDenom> denom;
  final String voucherName;
  final String voucherCode;
  final String iconUrl;

  VoucherDetail(
      {required this.ack,
      required this.denom,
      required this.voucherName,
      required this.voucherCode,
      required this.iconUrl});
  factory VoucherDetail.fromJson(Map<String, dynamic> json) =>
      _$VoucherDetailFromJson(json);
}

@JsonSerializable()
class VoucherDenom {
  final String denominationCode;
  final String denominationName;
  final String denominationCurrency;
  final String denominationAmount;
  final int stock;

  VoucherDenom(
      {required this.denominationCode,
      required this.denominationName,
      required this.denominationCurrency,
      required this.denominationAmount,
      required this.stock});
  factory VoucherDenom.fromJson(Map<String, dynamic> json) =>
      _$VoucherDenomFromJson(json);
}

@JsonSerializable()
class VoucherInquiry {
  final String voucherCode;
  final String voucherName;
  final String idTrx;
  final String amount;
  final String biaya;
  final String total;
  @JsonKey(name: 'ACK')
  final String ack;

  VoucherInquiry(
      {required this.voucherCode,
      required this.voucherName,
      required this.idTrx,
      required this.amount,
      required this.biaya,
      required this.total,
      required this.ack});
  factory VoucherInquiry.fromJson(Map<String, dynamic> json) =>
      _$VoucherInquiryFromJson(json);
}
