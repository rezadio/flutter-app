// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) {
  return AddressResponse(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    data: (json['data'] as List<dynamic>)
        .map((e) => AddressData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'data': instance.data,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) {
  return AddressData(
    id: json['id'] as int,
    nama: json['nama'] as String,
  );
}

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
    };
