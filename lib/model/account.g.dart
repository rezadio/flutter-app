// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  return AccountModel(
    data: (json['data'] as List<dynamic>)
        .map((e) => Account.fromJson(e as Map<String, dynamic>))
        .toList(),
    ack: json['ACK'] as String,
    dataKomunitas: (json['dataKomunitas'] as List<dynamic>?)
        ?.map((e) => DataKomunitas.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'ACK': instance.ack,
      'dataKomunitas': instance.dataKomunitas,
    };

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    alamat: json['Alamat'] as String,
    idMember: json['id_memberaccount'] as String,
    handphone: json['Handphone'] as String,
    rt: json['RT'] as String,
    kodePos: json['KodePOS'] as String,
    email: json['Email'] as String,
    tempatLahir: json['TempatLahir'] as String,
    rw: json['RW'] as String,
    namaIbuKandung: json['NamaIbuKandung'] as String,
    idKota: json['id_kota'] as String,
    idStatusVerifikasi: json['id_statusverifikasi'] as String,
    idProvinsi: json['id_provinsi'] as String,
    jenisKelamin: json['JenisKelamin'] as String,
    fotoProfile: json['fotoprofile'] as String,
    idKecamatan: json['id_kecamatan'] as String,
    fotoMember: json['fotomember'] as String,
    lbMember: json['lbmember'] as String,
    tanggalLahir: json['TanggalLahir'] as String,
    referralCode: json['referral_code'] as String,
    noKtp: json['NomorKTP'] as String,
    name: json['namamember'] as String,
    idAccountStatus: json['id_accountstatus'] as String,
    idKelurahan: json['id_kelurahan'] as String,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'Alamat': instance.alamat,
      'id_memberaccount': instance.idMember,
      'Handphone': instance.handphone,
      'RT': instance.rt,
      'KodePOS': instance.kodePos,
      'Email': instance.email,
      'TempatLahir': instance.tempatLahir,
      'RW': instance.rw,
      'NamaIbuKandung': instance.namaIbuKandung,
      'id_kota': instance.idKota,
      'id_statusverifikasi': instance.idStatusVerifikasi,
      'id_provinsi': instance.idProvinsi,
      'JenisKelamin': instance.jenisKelamin,
      'fotoprofile': instance.fotoProfile,
      'id_kecamatan': instance.idKecamatan,
      'fotomember': instance.fotoMember,
      'lbmember': instance.lbMember,
      'TanggalLahir': instance.tanggalLahir,
      'referral_code': instance.referralCode,
      'NomorKTP': instance.noKtp,
      'namamember': instance.name,
      'id_accountstatus': instance.idAccountStatus,
      'id_kelurahan': instance.idKelurahan,
    };
