import 'package:eidupay/model/data_initiator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginRest {
  @JsonKey(name: 'ACK')
  final String ack;
  @JsonKey(name: 'RC')
  final String rc;
  final String idAccount;
  final String pesan;
  final String nama;
  final String hp;
  final String tipe;
  final String device;
  @JsonKey(name: 'vabsi')
  final String? vaBsi;
  @JsonKey(name: 'vabri')
  final String? vaBri;
  @JsonKey(name: 'vamuamalat')
  final String? vaMuamalat;
  @JsonKey(defaultValue: [])
  final List<DataInitiator> dataInitiator;
  @JsonKey(name: 'vamandiri')
  final String? vaMandiri;
  final String? pinChangeStatus;
  @JsonKey(name: 'vabca')
  final String? vaBca;
  @JsonKey(name: 'vabnisyariah')
  final String? vaBniSyariah;
  @JsonKey(name: 'vabni')
  final String? vaBni;

  LoginRest({
    required this.ack,
    required this.rc,
    required this.idAccount,
    required this.tipe,
    required this.hp,
    required this.nama,
    required this.device,
    required this.pesan,
    this.vaBsi,
    this.vaBri,
    this.vaMuamalat,
    required this.dataInitiator,
    this.vaMandiri,
    this.pinChangeStatus,
    this.vaBca,
    this.vaBniSyariah,
    this.vaBni,
  });
  factory LoginRest.fromJson(Map<String, dynamic> json) =>
      _$LoginRestFromJson(json);
}

@JsonSerializable()
class LoginGetOtp {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  @JsonKey(name: 'no_hp')
  final String noHp;
  final String otp;
  @JsonKey(name: 'otp_type')
  final String otpType;

  LoginGetOtp({
    required this.pesan,
    required this.noHp,
    required this.ack,
    required this.otp,
    required this.otpType,
  });
  factory LoginGetOtp.fromJson(Map<String, dynamic> json) =>
      _$LoginGetOtpFromJson(json);
}

@JsonSerializable()
class AccountInfo {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  @JsonKey(defaultValue: [])
  final List<DataDiri> dataDiri;

  AccountInfo({required this.ack, required this.pesan, required this.dataDiri});
  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);
}

@JsonSerializable()
class DataDiri {
  @JsonKey(name: 'id_tipeaccount')
  final String idTipeAccount;
  @JsonKey(name: 'id_member')
  final String idMember;
  @JsonKey(name: 'id_statusverifikasi')
  final String idStatusVerifikasi;
  @JsonKey(name: 'NamaIbuKandung')
  final String namaIbuKandung;
  @JsonKey(name: 'Nama')
  final String nama;
  @JsonKey(name: 'TanggalLahir')
  final String tanggalLahir;
  @JsonKey(name: 'TempatLahir')
  final String tempatLahir;
  @JsonKey(name: 'Email')
  final String email;
  @JsonKey(name: 'Handphone')
  final String handphone;
  @JsonKey(name: 'NomorKTP')
  final String nomorKtp;

  DataDiri({
    required this.idTipeAccount,
    required this.idMember,
    required this.idStatusVerifikasi,
    required this.namaIbuKandung,
    required this.nama,
    required this.tanggalLahir,
    required this.tempatLahir,
    required this.email,
    required this.handphone,
    required this.nomorKtp,
  });
  factory DataDiri.fromJson(Map<String, dynamic> json) =>
      _$DataDiriFromJson(json);
}
