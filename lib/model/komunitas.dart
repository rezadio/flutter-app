import 'package:json_annotation/json_annotation.dart';

part 'komunitas.g.dart';

@JsonSerializable()
class Komunitas {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataKomunitas> dataKomunitas;

  const Komunitas({required this.ack, required this.dataKomunitas});
  factory Komunitas.fromJson(Map<String, dynamic> json) =>
      _$KomunitasFromJson(json);
}

@JsonSerializable()
class DataKomunitas {
  final String communityAddress;
  final String communityName;
  final int communityId;
  final String picName;
  final String picPhone;
  final int picId;

  DataKomunitas(
      {required this.communityAddress,
      required this.communityName,
      required this.communityId,
      required this.picName,
      required this.picPhone,
      required this.picId});
  factory DataKomunitas.fromJson(Map<String, dynamic> json) =>
      _$DataKomunitasFromJson(json);
}
