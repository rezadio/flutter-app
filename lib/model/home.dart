import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class HomeModel {
  @JsonKey(defaultValue: [])
  final List<DataSiswa> dataSiswa;
  @JsonKey(defaultValue: [])
  final List<LastTransaction> lastTrx;
  @JsonKey(name: 'versi')
  final String version;
  @JsonKey(defaultValue: [])
  final List<Produk> bestSeller;
  @JsonKey(name: 'ACK')
  final String ack;
  @JsonKey(defaultValue: [])
  final List<Produk> flashSale;
  final List<Menu> menu;
  final Iklan iklan;
  @JsonKey(defaultValue: [])
  final List<Produk> newProduct;

  HomeModel(
      {required this.dataSiswa,
      required this.lastTrx,
      required this.version,
      required this.bestSeller,
      required this.ack,
      required this.flashSale,
      required this.menu,
      required this.iklan,
      required this.newProduct});

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class DataSiswa {
  @JsonKey(name: 'pesan')
  final String message;
  @JsonKey(name: 'ACK')
  final String ack;
  final int? biaya;
  final String? phone;
  @JsonKey(name: 'total_tagihan')
  final String? totalTagihan;
  final String? kelas;
    @JsonKey(name: 'name')
  final String? nama;
  @JsonKey(name: 'nama_sekolah')
  final String? namaSekolah;
  final String? nis;
  final String? caraBayar;
  @JsonKey(name: 'phone_sekolah')
  final String? phoneSekolah;
  @JsonKey(name: 'path_logo')
  final String? logo;

  DataSiswa(this.biaya, this.phone, this.totalTagihan, this.kelas, this.nama, this.namaSekolah, this.nis, this.caraBayar, this.phoneSekolah, this.logo, {required this.message, required this.ack});

  factory DataSiswa.fromJson(Map<String, dynamic> json) =>
      _$DataSiswaFromJson(json);
  Map<String, dynamic> toJson() => _$DataSiswaToJson(this);
}

@JsonSerializable()
class LastTransaction {
  final DateTime timeStamp;
  final String noHpTujuan;
  final String total;
  final String keterangan;
  final String? noRekTujuan;
  @JsonKey(name: 'idTipetransaksi')
  final String id;
  @JsonKey(name: 'biaya')
  final String biayaAdmin;
  final String nominal;
  final String typeTRX;
  final String idTrx;
  final String namaTipeTransaksi;
  final String? nomorPenerima;
  final String? namaBank;

  LastTransaction({
    required this.timeStamp,
    required this.noHpTujuan,
    required this.total,
    required this.keterangan,
    this.noRekTujuan,
    required this.id,
    required this.biayaAdmin,
    required this.nominal,
    required this.typeTRX,
    required this.idTrx,
    required this.namaTipeTransaksi,
    this.nomorPenerima,
    this.namaBank,
  });
  factory LastTransaction.fromJson(Map<String, dynamic> json) =>
      _$LastTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$LastTransactionToJson(this);
}

@JsonSerializable()
class Produk {
  final String namaProduk;
  final String urlProduk;
  final String fotoProduk;
  @JsonKey(name: 'kategori_produk')
  final String kategoriProduk;
  final String hargaProduk;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String hargaDiskonProduk;

  Produk(
      {required this.namaProduk,
      required this.urlProduk,
      required this.fotoProduk,
      required this.kategoriProduk,
      required this.hargaProduk,
      required this.createdAt,
      required this.hargaDiskonProduk});

  factory Produk.fromJson(Map<String, dynamic> json) => _$ProdukFromJson(json);
  Map<String, dynamic> toJson() => _$ProdukToJson(this);
}

@JsonSerializable()
class Menu {
  final String redirectClassName;
  final String icon;
  final String title;
  final String type;
  final String idMenu;

  Menu(
      {required this.redirectClassName,
      required this.icon,
      required this.title,
      required this.type,
      required this.idMenu});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class Iklan {
  final List<Images> images;

  Iklan(this.images);

  factory Iklan.fromJson(Map<String, dynamic> json) => _$IklanFromJson(json);
  Map<String, dynamic> toJson() => _$IklanToJson(this);
}

@JsonSerializable()
class Images {
  final String image;
  final String url;

  Images({required this.image, required this.url});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
