import 'package:eidupay/model/education.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final Data data;

  NotificationModel(
      {required this.ack, required this.pesan, required this.data});
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class Data {
  final int unread;
  final List<NotificationData> list;

  Data({required this.unread, required this.list});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

//TODO: update model if nullable parameter found
@JsonSerializable()
class NotificationData {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String body;
  @JsonKey(defaultValue: '')
  final String detailType;
  @JsonKey(defaultValue: false)
  final bool read;
  final DateTime? createdAt;
  final String? detailReff;

  NotificationData(
      {required this.id,
      required this.title,
      required this.body,
      required this.detailType,
      required this.read,
      required this.createdAt,
      required this.detailReff});
  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

@JsonSerializable()
class NotifInfoResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final NotifInfo data;

  const NotifInfoResponse(
      {required this.ack, required this.pesan, required this.data});
  factory NotifInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$NotifInfoResponseFromJson(json);
}

@JsonSerializable()
class NotifInfo {
  final int id;
  final String title, body;

  const NotifInfo({required this.id, required this.title, required this.body});
  factory NotifInfo.fromJson(Map<String, dynamic> json) =>
      _$NotifInfoFromJson(json);
}

@JsonSerializable()
class NotifDetailResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final List<NotifDetail> data;

  const NotifDetailResponse(
      {required this.ack, required this.pesan, required this.data});
  factory NotifDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailResponseFromJson(json);
}

@JsonSerializable()
class NotifDetail {
  final String idTransaksi;
  final String idTrx;
  final String statusTrx;
  final String statusDana;
  final String statusRefund;
  final String statusDeduct;
  final String typeTrx;
  final String namaTipeTransaksi;
  final String hargaJual;
  final String biaya;
  final String total;
  final String keterangan;
  final String lastBalance;
  final String timeStamp;
  final int idTipetransaksi;
  final String? detail;
  final String? customerReference;

  const NotifDetail({
    required this.idTransaksi,
    required this.idTrx,
    required this.statusTrx,
    required this.statusDana,
    required this.statusRefund,
    required this.statusDeduct,
    required this.typeTrx,
    required this.namaTipeTransaksi,
    required this.hargaJual,
    required this.biaya,
    required this.total,
    required this.keterangan,
    required this.lastBalance,
    required this.timeStamp,
    required this.idTipetransaksi,
    this.detail,
    this.customerReference,
  });
  factory NotifDetail.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailFromJson(json);
}

@JsonSerializable()
class NotifDetailPulsa {
  final String noHp, provider;
  final int nominal;

  const NotifDetailPulsa(
      {required this.noHp, required this.provider, required this.nominal});
  factory NotifDetailPulsa.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailPulsaFromJson(json);
}

@JsonSerializable()
class NotifDetailTv {
  final String idPelanggan, nama, blnTahun;

  factory NotifDetailTv.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailTvFromJson(json);

  NotifDetailTv(this.idPelanggan, this.nama, this.blnTahun);
}

@JsonSerializable()
class NotifDetailTelkom {
  final String idPelanggan, nama, blnTahun;

  factory NotifDetailTelkom.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailTelkomFromJson(json);

  NotifDetailTelkom(this.idPelanggan, this.nama, this.blnTahun);
}

@JsonSerializable()
class NotifDetailMember {
  final String noHpPenerima, namaPenerima, noHpPengirim, namaPengirim, remark;
  final int nominal;

  const NotifDetailMember(
      {required this.noHpPenerima,
      required this.namaPenerima,
      required this.noHpPengirim,
      required this.namaPengirim,
      required this.nominal,
      required this.remark});
  factory NotifDetailMember.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailMemberFromJson(json);
}

@JsonSerializable()
class NotifDetailBank {
  final String namaBank, noRek, namaRek, remark;
  final int nominal;

  const NotifDetailBank(
      {required this.namaBank,
      required this.noRek,
      required this.namaRek,
      required this.nominal,
      required this.remark});
  factory NotifDetailBank.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailBankFromJson(json);
}

@JsonSerializable()
class NotifDetailPaketData {
  final String noHp, provider, namaProduk;

  const NotifDetailPaketData(
      {required this.noHp, required this.provider, required this.namaProduk});
  factory NotifDetailPaketData.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailPaketDataFromJson(json);
}

@JsonSerializable()
class NotifDetailTagihanPlnPascaBayar {
  final String idPelanggan, nama, tarifDaya, standMeter, bulanTahun;
  final int nominal;

  const NotifDetailTagihanPlnPascaBayar(
      {required this.idPelanggan,
      required this.nama,
      required this.tarifDaya,
      required this.standMeter,
      required this.bulanTahun,
      required this.nominal});
  factory NotifDetailTagihanPlnPascaBayar.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailTagihanPlnPascaBayarFromJson(json);
}

@JsonSerializable()
class NotifDetailTagihanPlnPraBayar {
  final String idPelanggan, nama, tarifDaya, kwh, token;

  const NotifDetailTagihanPlnPraBayar(
      {required this.idPelanggan,
      required this.nama,
      required this.tarifDaya,
      required this.kwh,
      required this.token});
  factory NotifDetailTagihanPlnPraBayar.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailTagihanPlnPraBayarFromJson(json);
}

@JsonSerializable()
class NotifDetailDonasi {
  final String lembaga, tipeDonasi;
  final int nominal;

  const NotifDetailDonasi(
      {required this.lembaga, required this.tipeDonasi, required this.nominal});
  factory NotifDetailDonasi.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailDonasiFromJson(json);
}

//Edukasi dan Tabungan
@JsonSerializable()
class NotifDetailEdukasi {
  final String lembaga, kelas, namaSiswa, nis;
  final int nominal;

  const NotifDetailEdukasi(
      {required this.lembaga,
      required this.kelas,
      required this.namaSiswa,
      required this.nis,
      required this.nominal});
  factory NotifDetailEdukasi.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailEdukasiFromJson(json);
}

//Edukasi dan Tabungan
@JsonSerializable()
class NotifDetailEdukasiReference {
  @JsonKey(name: 'merchantName')
  final String lembaga;
  final String kelas;
  @JsonKey(name: 'customerName')
  final String namaSiswa;
  @JsonKey(name: 'customerNumber')
  final String nis;
    @JsonKey(name: 'bayar')
  final String nominal;
  @JsonKey(name: 'dataBill')
  final List<dynamic> dataBill;
  const NotifDetailEdukasiReference(this.dataBill,
      {required this.lembaga,
      required this.kelas,
      required this.namaSiswa,
      required this.nis,
      required this.nominal});
  factory NotifDetailEdukasiReference.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailEdukasiReferenceFromJson(json);
}

@JsonSerializable()
class NotifDetailTopupGame {
  final String game, username, produk;
  final int nominal;

  const NotifDetailTopupGame(
      {required this.game,
      required this.username,
      required this.produk,
      required this.nominal});
  factory NotifDetailTopupGame.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailTopupGameFromJson(json);
}

@JsonSerializable()
class NotifDetailVoucherGame {
  final String game;
  final int nominal;

  const NotifDetailVoucherGame({required this.game, required this.nominal});
  factory NotifDetailVoucherGame.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailVoucherGameFromJson(json);
}

@JsonSerializable()
class NotifDetailMerchant {
  final String namaMerchant;
  final int nominal;

  const NotifDetailMerchant(
      {required this.namaMerchant, required this.nominal});
  factory NotifDetailMerchant.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailMerchantFromJson(json);
}

@JsonSerializable()
class NotifDetailLain {
  final String idPelanggan;
  final int nominal;

  const NotifDetailLain({required this.idPelanggan, required this.nominal});
  factory NotifDetailLain.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailLainFromJson(json);
}

@JsonSerializable()
class NotifDetailBpjs {
  final String idPelanggan;
  final String nama;
  final String jmlPeserta;
  final String jmlBulan;

  factory NotifDetailBpjs.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailBpjsFromJson(json);

  NotifDetailBpjs(this.idPelanggan, this.nama, this.jmlPeserta, this.jmlBulan);
}

@JsonSerializable()
class NotifDetailEMoney {
  final String tujuan, emoney, nominal;

  const NotifDetailEMoney(
      {required this.tujuan, required this.emoney, required this.nominal});
  factory NotifDetailEMoney.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailEMoneyFromJson(json);
}

@JsonSerializable()
class NotifDetailESamsat {
  final String kodePembayaran,
      namaPemilik,
      platNomorKendaraan,
      namaMerekKb,
      namaModelKb,
      alamatPemilik,
      tahunBuatan;

  const NotifDetailESamsat(
      this.namaMerekKb, this.namaModelKb, this.alamatPemilik, this.tahunBuatan,
      {required this.kodePembayaran,
      required this.namaPemilik,
      required this.platNomorKendaraan});
  factory NotifDetailESamsat.fromJson(Map<String, dynamic> json) =>
      _$NotifDetailESamsatFromJson(json);
}
