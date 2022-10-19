// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bpjs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BPJS _$BPJSFromJson(Map<String, dynamic> json) {
  return BPJS(
    tagihan: json['tagihan'] as String,
    nama: json['nama'] as String,
    biayaAdmin: json['biayaAdmin'] as String,
    hargaCetak: json['hargaCetak'] as String,
    ack: json['ACK'] as String,
    idTrx: json['idTrx'] as String,
    reffId: json['reffId'] as String,
    periode: json['periode'] as String,
    idPelanggan: json['idPelanggan'] as String?,
    namaAlias: json['namaAlias'] as String?,
  );
}

Map<String, dynamic> _$BPJSToJson(BPJS instance) => <String, dynamic>{
      'tagihan': instance.tagihan,
      'nama': instance.nama,
      'biayaAdmin': instance.biayaAdmin,
      'hargaCetak': instance.hargaCetak,
      'ACK': instance.ack,
      'idTrx': instance.idTrx,
      'reffId': instance.reffId,
      'periode': instance.periode,
      'idPelanggan': instance.idPelanggan,
      'namaAlias': instance.namaAlias,
    };
