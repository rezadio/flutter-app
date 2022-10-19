import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class DataFavorite {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<Favorite> dataFavorite;

  DataFavorite({required this.ack, required this.dataFavorite});
  factory DataFavorite.fromJson(Map<String, dynamic> json) =>
      _$DataFavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$DataFavoriteToJson(this);
}

@JsonSerializable()
class Favorite {
  final String idTipeTransaksi;
  final String aliasName;
  final String idMember;
  final String noPelanggan;

  Favorite(
      {required this.idTipeTransaksi,
      required this.aliasName,
      required this.idMember,
      required this.noPelanggan});
  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
