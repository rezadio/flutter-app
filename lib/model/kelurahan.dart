import 'package:json_annotation/json_annotation.dart';

part 'kelurahan.g.dart';

@JsonSerializable()
class Kelurahan {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataKelurahan> dataKelurahan;

  Kelurahan({required this.ack, required this.dataKelurahan});
  factory Kelurahan.fromJson(Map<String, dynamic> json) =>
      _$KelurahanFromJson(json);
}

@JsonSerializable()
class DataKelurahan {
  @JsonKey(name: 'id_kecamatan')
  final String idKecamatan;
  @JsonKey(name: 'NamaKecamatan')
  final String namaKecamatan;
  @JsonKey(name: 'NamaKelurahan')
  final String namaKelurahan;
  @JsonKey(name: 'NamaProvinsi')
  final String namaProvinsi;
  @JsonKey(name: 'id_kota')
  final String idKota;
  @JsonKey(name: 'NamaKota')
  final String namaKota;
  @JsonKey(name: 'id_provinsi')
  final String idProvinsi;
  @JsonKey(name: 'id_kelurahan')
  final String idKelurahan;

  DataKelurahan(
      {required this.idKecamatan,
      required this.namaKecamatan,
      required this.namaKelurahan,
      required this.namaProvinsi,
      required this.idKota,
      required this.namaKota,
      required this.idProvinsi,
      required this.idKelurahan});
  factory DataKelurahan.fromJson(Map<String, dynamic> json) =>
      _$DataKelurahanFromJson(json);
}
