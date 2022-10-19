import 'package:eidupay/model/komunitas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class AccountModel {
  final List<Account> data;
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataKomunitas>? dataKomunitas;

  static var obs;

  AccountModel({required this.data, required this.ack, this.dataKomunitas});
  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}

@JsonSerializable()
class Account {
  @JsonKey(name: 'Alamat')
  final String alamat;
  @JsonKey(name: 'id_memberaccount')
  final String idMember;
  @JsonKey(name: 'Handphone')
  final String handphone;
  @JsonKey(name: 'RT')
  final String rt;
  @JsonKey(name: 'KodePOS')
  final String kodePos;
  @JsonKey(name: 'Email')
  final String email;
  @JsonKey(name: 'TempatLahir')
  final String tempatLahir;
  @JsonKey(name: 'RW')
  final String rw;
  @JsonKey(name: 'NamaIbuKandung')
  final String namaIbuKandung;
  @JsonKey(name: 'id_kota')
  final String idKota;
  @JsonKey(name: 'id_statusverifikasi')
  final String idStatusVerifikasi;
  @JsonKey(name: 'id_provinsi')
  final String idProvinsi;
  @JsonKey(name: 'JenisKelamin')
  final String jenisKelamin;
  @JsonKey(name: 'fotoprofile')
  final String fotoProfile;
  @JsonKey(name: 'id_kecamatan')
  final String idKecamatan;
  @JsonKey(name: 'fotomember')
  final String fotoMember;
  @JsonKey(name: 'lbmember')
  final String lbMember;
  @JsonKey(name: 'TanggalLahir')
  final String tanggalLahir;
  @JsonKey(name: 'referral_code')
  final String referralCode;
  @JsonKey(name: 'NomorKTP')
  final String noKtp;
  @JsonKey(name: 'namamember')
  final String name;
  @JsonKey(name: 'id_accountstatus')
  final String idAccountStatus;
  @JsonKey(name: 'id_kelurahan')
  final String idKelurahan;

  Account(
      {required this.alamat,
      required this.idMember,
      required this.handphone,
      required this.rt,
      required this.kodePos,
      required this.email,
      required this.tempatLahir,
      required this.rw,
      required this.namaIbuKandung,
      required this.idKota,
      required this.idStatusVerifikasi,
      required this.idProvinsi,
      required this.jenisKelamin,
      required this.fotoProfile,
      required this.idKecamatan,
      required this.fotoMember,
      required this.lbMember,
      required this.tanggalLahir,
      required this.referralCode,
      required this.noKtp,
      required this.name,
      required this.idAccountStatus,
      required this.idKelurahan});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
