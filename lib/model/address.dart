import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class AddressResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final List<AddressData> data;

  AddressResponse({required this.ack, required this.pesan, required this.data});
  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);
}

@JsonSerializable()
class AddressData {
  final int id;
  final String nama;

  AddressData({required this.id, required this.nama});
  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);
}
