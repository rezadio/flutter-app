import 'package:json_annotation/json_annotation.dart';

part 'mutasi.g.dart';

@JsonSerializable()
class MutasiModel {
  @JsonKey(name: 'ACK')
  final String ack;
  @JsonKey(defaultValue: [])
  final List<Mutasi> dataMutasi;

  MutasiModel({required this.ack, required this.dataMutasi});
  factory MutasiModel.fromJson(Map<String, dynamic> json) =>
      _$MutasiModelFromJson(json);
  Map<String, dynamic> toJson() => _$MutasiModelToJson(this);
}

@JsonSerializable()
class Mutasi {
  @JsonKey(name: 'NoHPPenerima')
  final String? noHpPenerima;
  @JsonKey(name: 'StatusTRX')
  final String statusTrx;
  final String typeTrx;
  @JsonKey(name: 'id_pelanggan')
  final String? idPelanggan;
  @JsonKey(name: 'NoHPTujuan')
  final String noHpTujuan;
  final String total;
  @JsonKey(name: 'NamePengirim')
  final String namePengirim;
  @JsonKey(name: 'TanggalExpired')
  final String? tanggalExpired;
  @JsonKey(name: 'NamaPenerima')
  final String? namaPenerima;
  @JsonKey(name: 'StatusDeduct')
  final String statusDeduct;
  @JsonKey(name: 'hargajual')
  final String hargaJual;
  @JsonKey(name: 'NoHPPengirim')
  final String noHpPengirim;
  @JsonKey(name: 'hargabeli')
  final String hargaBeli;
  @JsonKey(name: 'IdIdentitasPenerima')
  final String? idIdentitasPenerima;
  @JsonKey(name: 'Berita')
  final String? berita;
  final String idTransaksi;
  @JsonKey(name: 'PinPencairan')
  final String? pinPencairan;
  final String idTrx;
  final String tipeTransaksi;
  final String lastBalance;
  final DateTime timeStamp;
  @JsonKey(name: 'StatusDana')
  final String statusDana;
  @JsonKey(name: 'Biaya')
  final String biaya;
  @JsonKey(name: 'StatusTopUp')
  final String? statusTopUp;
  @JsonKey(name: 'Keterangan')
  final String keterangan;
  @JsonKey(name: 'NamePenerima')
  final String? namePenerima;
  @JsonKey(name: 'StatusRefund')
  final String statusRefund;
  @JsonKey(name: 'NamaTipeTransaksi')
  final String namaTipeTransaksi;
  final String idStock;
  final String? customerReference;
  final String? phoneExtended;
  final String? nameExtended;

  // final String lastBalance;
  // final DateTime timeStamp;
  // final String total;
  // final String typeTrx;
  // final String idTransaksi;
  // final String tipeTransaksi;
  // @JsonKey(name: 'Keterangan')
  // final String keterangan;
  // @JsonKey(name: 'NamePenerima')
  // final String? namaPenerima;

  const Mutasi({
    this.noHpPenerima,
    required this.statusTrx,
    required this.typeTrx,
    this.idPelanggan,
    required this.noHpTujuan,
    required this.total,
    required this.namePengirim,
    this.tanggalExpired,
    this.namaPenerima,
    required this.statusDeduct,
    required this.hargaJual,
    required this.noHpPengirim,
    required this.hargaBeli,
    this.idIdentitasPenerima,
    this.berita,
    required this.idTransaksi,
    this.pinPencairan,
    required this.idTrx,
    required this.tipeTransaksi,
    required this.lastBalance,
    required this.timeStamp,
    required this.statusDana,
    required this.biaya,
    this.statusTopUp,
    required this.keterangan,
    this.namePenerima,
    required this.statusRefund,
    required this.namaTipeTransaksi,
    required this.idStock,
    this.nameExtended,
    this.customerReference,
    this.phoneExtended,
  });
  factory Mutasi.fromJson(Map<String, dynamic> json) => _$MutasiFromJson(json);
  Map<String, dynamic> toJson() => _$MutasiToJson(this);
}
