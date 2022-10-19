// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataFavorite _$DataFavoriteFromJson(Map<String, dynamic> json) {
  return DataFavorite(
    ack: json['ACK'] as String,
    dataFavorite: (json['dataFavorite'] as List<dynamic>)
        .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DataFavoriteToJson(DataFavorite instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataFavorite': instance.dataFavorite,
    };

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
    idTipeTransaksi: json['idTipeTransaksi'] as String,
    aliasName: json['aliasName'] as String,
    idMember: json['idMember'] as String,
    noPelanggan: json['noPelanggan'] as String,
  );
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'idTipeTransaksi': instance.idTipeTransaksi,
      'aliasName': instance.aliasName,
      'idMember': instance.idMember,
      'noPelanggan': instance.noPelanggan,
    };
