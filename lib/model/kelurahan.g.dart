// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kelurahan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kelurahan _$KelurahanFromJson(Map<String, dynamic> json) {
  return Kelurahan(
    ack: json['ACK'] as String,
    dataKelurahan: (json['dataKelurahan'] as List<dynamic>)
        .map((e) => DataKelurahan.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$KelurahanToJson(Kelurahan instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataKelurahan': instance.dataKelurahan,
    };

DataKelurahan _$DataKelurahanFromJson(Map<String, dynamic> json) {
  return DataKelurahan(
    idKecamatan: json['id_kecamatan'] as String,
    namaKecamatan: json['NamaKecamatan'] as String,
    namaKelurahan: json['NamaKelurahan'] as String,
    namaProvinsi: json['NamaProvinsi'] as String,
    idKota: json['id_kota'] as String,
    namaKota: json['NamaKota'] as String,
    idProvinsi: json['id_provinsi'] as String,
    idKelurahan: json['id_kelurahan'] as String,
  );
}

Map<String, dynamic> _$DataKelurahanToJson(DataKelurahan instance) =>
    <String, dynamic>{
      'id_kecamatan': instance.idKecamatan,
      'NamaKecamatan': instance.namaKecamatan,
      'NamaKelurahan': instance.namaKelurahan,
      'NamaProvinsi': instance.namaProvinsi,
      'id_kota': instance.idKota,
      'NamaKota': instance.namaKota,
      'id_provinsi': instance.idProvinsi,
      'id_kelurahan': instance.idKelurahan,
    };
