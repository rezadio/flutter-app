// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRest _$LoginRestFromJson(Map<String, dynamic> json) {
  return LoginRest(
    ack: json['ACK'] as String,
    rc: json['RC'] as String,
    idAccount: json['idAccount'] as String,
    tipe: json['tipe'] as String,
    hp: json['hp'] as String,
    nama: json['nama'] as String,
    device: json['device'] as String,
    pesan: json['pesan'] as String,
    vaBsi: json['vabsi'] as String?,
    vaBri: json['vabri'] as String?,
    vaMuamalat: json['vamuamalat'] as String?,
    dataInitiator: (json['dataInitiator'] as List<dynamic>?)
            ?.map((e) => DataInitiator.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    vaMandiri: json['vamandiri'] as String?,
    pinChangeStatus: json['pinChangeStatus'] as String?,
    vaBca: json['vabca'] as String?,
    vaBniSyariah: json['vabnisyariah'] as String?,
    vaBni: json['vabni'] as String?,
  );
}

Map<String, dynamic> _$LoginRestToJson(LoginRest instance) => <String, dynamic>{
      'ACK': instance.ack,
      'RC': instance.rc,
      'idAccount': instance.idAccount,
      'pesan': instance.pesan,
      'nama': instance.nama,
      'hp': instance.hp,
      'tipe': instance.tipe,
      'device': instance.device,
      'vabsi': instance.vaBsi,
      'vabri': instance.vaBri,
      'vamuamalat': instance.vaMuamalat,
      'dataInitiator': instance.dataInitiator,
      'vamandiri': instance.vaMandiri,
      'pinChangeStatus': instance.pinChangeStatus,
      'vabca': instance.vaBca,
      'vabnisyariah': instance.vaBniSyariah,
      'vabni': instance.vaBni,
    };

LoginGetOtp _$LoginGetOtpFromJson(Map<String, dynamic> json) {
  return LoginGetOtp(
    pesan: json['pesan'] as String,
    noHp: json['no_hp'] as String,
    ack: json['ACK'] as String,
    otp: json['otp'] as String,
    otpType: json['otp_type'] as String,
  );
}

Map<String, dynamic> _$LoginGetOtpToJson(LoginGetOtp instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'no_hp': instance.noHp,
      'otp': instance.otp,
      'otp_type': instance.otpType,
    };

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) {
  return AccountInfo(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    dataDiri: (json['dataDiri'] as List<dynamic>?)
            ?.map((e) => DataDiri.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'dataDiri': instance.dataDiri,
    };

DataDiri _$DataDiriFromJson(Map<String, dynamic> json) {
  return DataDiri(
    idTipeAccount: json['id_tipeaccount'] as String,
    idMember: json['id_member'] as String,
    idStatusVerifikasi: json['id_statusverifikasi'] as String,
    namaIbuKandung: json['NamaIbuKandung'] as String,
    nama: json['Nama'] as String,
    tanggalLahir: json['TanggalLahir'] as String,
    tempatLahir: json['TempatLahir'] as String,
    email: json['Email'] as String,
    handphone: json['Handphone'] as String,
    nomorKtp: json['NomorKTP'] as String,
  );
}

Map<String, dynamic> _$DataDiriToJson(DataDiri instance) => <String, dynamic>{
      'id_tipeaccount': instance.idTipeAccount,
      'id_member': instance.idMember,
      'id_statusverifikasi': instance.idStatusVerifikasi,
      'NamaIbuKandung': instance.namaIbuKandung,
      'Nama': instance.nama,
      'TanggalLahir': instance.tanggalLahir,
      'TempatLahir': instance.tempatLahir,
      'Email': instance.email,
      'Handphone': instance.handphone,
      'NomorKTP': instance.nomorKtp,
    };
