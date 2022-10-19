// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameResponse _$GameResponseFromJson(Map<String, dynamic> json) {
  return GameResponse(
    ack: json['ACK'] as String,
    listGame: (json['listGame'] as List<dynamic>?)
        ?.map((e) => Game.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GameResponseToJson(GameResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'listGame': instance.listGame,
    };

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    gameCategory: json['gameCategory'] as String,
    gameName: json['gameName'] as String,
    gameStatus: json['gameStatus'] as String,
    gameCode: json['gameCode'] as String,
    iconUrl: json['iconUrl'] as String,
    categoryName: json['categoryName'] as String,
    productName: json['productName'] as String,
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'gameCategory': instance.gameCategory,
      'gameName': instance.gameName,
      'gameStatus': instance.gameStatus,
      'gameCode': instance.gameCode,
      'iconUrl': instance.iconUrl,
      'categoryName': instance.categoryName,
      'productName': instance.productName,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

GameDetailResponse _$GameDetailResponseFromJson(Map<String, dynamic> json) {
  return GameDetailResponse(
    ack: json['ACK'] as String,
    helpImg: json['helpImg'] as String,
    game: GameDetail.fromJson(json['game'] as Map<String, dynamic>),
    denom: (json['denom'] as List<dynamic>)
        .map((e) => GameDenom.fromJson(e as Map<String, dynamic>))
        .toList(),
    fields: (json['fields'] as List<dynamic>)
        .map((e) => GameField.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GameDetailResponseToJson(GameDetailResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'helpImg': instance.helpImg,
      'game': instance.game,
      'denom': instance.denom,
      'fields': instance.fields,
    };

GameDetail _$GameDetailFromJson(Map<String, dynamic> json) {
  return GameDetail(
    nameGame: json['nameGame'] as String,
    code: json['code'] as String,
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$GameDetailToJson(GameDetail instance) =>
    <String, dynamic>{
      'nameGame': instance.nameGame,
      'code': instance.code,
      'category': instance.category,
    };

GameDenom _$GameDenomFromJson(Map<String, dynamic> json) {
  return GameDenom(
    id: json['id'] as int,
    nameDenom: json['nameDenom'] as String,
    currency: json['currency'] as String,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$GameDenomToJson(GameDenom instance) => <String, dynamic>{
      'id': instance.id,
      'nameDenom': instance.nameDenom,
      'currency': instance.currency,
      'amount': instance.amount,
    };

GameField _$GameFieldFromJson(Map<String, dynamic> json) {
  return GameField(
    nameField: json['nameField'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$GameFieldToJson(GameField instance) => <String, dynamic>{
      'nameField': instance.nameField,
      'type': instance.type,
    };

GameInquiry _$GameInquiryFromJson(Map<String, dynamic> json) {
  return GameInquiry(
    biaya: json['biaya'] as String?,
    amount: json['amount'] as String?,
    total: json['total'] as String?,
    server: json['server'] as String?,
    gameName: json['gameName'] as String,
    gameCode: json['gameCode'] as String,
    denominationId: json['denominationId'] as String,
    denominationName: json['denominationName'] as String,
    username: json['username'] as String,
    userId: json['user_id'] as String,
    zoneId: json['zoneId'] as String,
    token: json['token'] as String,
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$GameInquiryToJson(GameInquiry instance) =>
    <String, dynamic>{
      'biaya': instance.biaya,
      'amount': instance.amount,
      'total': instance.total,
      'server': instance.server,
      'gameName': instance.gameName,
      'gameCode': instance.gameCode,
      'denominationId': instance.denominationId,
      'denominationName': instance.denominationName,
      'username': instance.username,
      'user_id': instance.userId,
      'zoneId': instance.zoneId,
      'token': instance.token,
      'ACK': instance.ack,
    };

VoucherResponse _$VoucherResponseFromJson(Map<String, dynamic> json) {
  return VoucherResponse(
    ack: json['ACK'] as String,
    listVoucher: (json['listVoucher'] as List<dynamic>?)
        ?.map((e) => Voucher.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VoucherResponseToJson(VoucherResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'listVoucher': instance.listVoucher,
    };

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return Voucher(
    voucherName: json['voucherName'] as String,
    iconUrl: json['iconUrl'] as String,
    voucherCode: json['voucherCode'] as String,
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'voucherName': instance.voucherName,
      'iconUrl': instance.iconUrl,
      'voucherCode': instance.voucherCode,
    };

VoucherDetail _$VoucherDetailFromJson(Map<String, dynamic> json) {
  return VoucherDetail(
    ack: json['ACK'] as String,
    denom: (json['denom'] as List<dynamic>)
        .map((e) => VoucherDenom.fromJson(e as Map<String, dynamic>))
        .toList(),
    voucherName: json['voucherName'] as String,
    voucherCode: json['voucherCode'] as String,
    iconUrl: json['iconUrl'] as String,
  );
}

Map<String, dynamic> _$VoucherDetailToJson(VoucherDetail instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'denom': instance.denom,
      'voucherName': instance.voucherName,
      'voucherCode': instance.voucherCode,
      'iconUrl': instance.iconUrl,
    };

VoucherDenom _$VoucherDenomFromJson(Map<String, dynamic> json) {
  return VoucherDenom(
    denominationCode: json['denominationCode'] as String,
    denominationName: json['denominationName'] as String,
    denominationCurrency: json['denominationCurrency'] as String,
    denominationAmount: json['denominationAmount'] as String,
    stock: json['stock'] as int,
  );
}

Map<String, dynamic> _$VoucherDenomToJson(VoucherDenom instance) =>
    <String, dynamic>{
      'denominationCode': instance.denominationCode,
      'denominationName': instance.denominationName,
      'denominationCurrency': instance.denominationCurrency,
      'denominationAmount': instance.denominationAmount,
      'stock': instance.stock,
    };

VoucherInquiry _$VoucherInquiryFromJson(Map<String, dynamic> json) {
  return VoucherInquiry(
    voucherCode: json['voucherCode'] as String,
    voucherName: json['voucherName'] as String,
    idTrx: json['idTrx'] as String,
    amount: json['amount'] as String,
    biaya: json['biaya'] as String,
    total: json['total'] as String,
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$VoucherInquiryToJson(VoucherInquiry instance) =>
    <String, dynamic>{
      'voucherCode': instance.voucherCode,
      'voucherName': instance.voucherName,
      'idTrx': instance.idTrx,
      'amount': instance.amount,
      'biaya': instance.biaya,
      'total': instance.total,
      'ACK': instance.ack,
    };
