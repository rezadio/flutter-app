// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    dataSiswa: (json['dataSiswa'] as List<dynamic>?)
            ?.map((e) => DataSiswa.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    lastTrx: (json['lastTrx'] as List<dynamic>?)
            ?.map((e) => LastTransaction.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    version: json['versi'] as String,
    bestSeller: (json['bestSeller'] as List<dynamic>?)
            ?.map((e) => Produk.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    ack: json['ACK'] as String,
    flashSale: (json['flashSale'] as List<dynamic>?)
            ?.map((e) => Produk.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    menu: (json['menu'] as List<dynamic>)
        .map((e) => Menu.fromJson(e as Map<String, dynamic>))
        .toList(),
    iklan: Iklan.fromJson(json['iklan'] as Map<String, dynamic>),
    newProduct: (json['newProduct'] as List<dynamic>?)
            ?.map((e) => Produk.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'dataSiswa': instance.dataSiswa,
      'lastTrx': instance.lastTrx,
      'versi': instance.version,
      'bestSeller': instance.bestSeller,
      'ACK': instance.ack,
      'flashSale': instance.flashSale,
      'menu': instance.menu,
      'iklan': instance.iklan,
      'newProduct': instance.newProduct,
    };

DataSiswa _$DataSiswaFromJson(Map<String, dynamic> json) {
  return DataSiswa(
    json['biaya'] as int?,
    json['phone'] as String?,
    json['total_tagihan'] as String?,
    json['kelas'] as String?,
    json['name'] as String?,
    json['nama_sekolah'] as String?,
    json['nis'] as String?,
    json['caraBayar'] as String?,
    json['phone_sekolah'] as String?,
    json['path_logo'] as String?,
    message: json['pesan'] as String,
    ack: json['ACK'] as String,
  );
}

Map<String, dynamic> _$DataSiswaToJson(DataSiswa instance) => <String, dynamic>{
      'pesan': instance.message,
      'ACK': instance.ack,
      'biaya': instance.biaya,
      'phone': instance.phone,
      'total_tagihan': instance.totalTagihan,
      'kelas': instance.kelas,
      'name': instance.nama,
      'nama_sekolah': instance.namaSekolah,
      'nis': instance.nis,
      'caraBayar': instance.caraBayar,
      'phone_sekolah': instance.phoneSekolah,
      'path_logo': instance.logo,
    };

LastTransaction _$LastTransactionFromJson(Map<String, dynamic> json) {
  return LastTransaction(
    timeStamp: DateTime.parse(json['timeStamp'] as String),
    noHpTujuan: json['noHpTujuan'] as String,
    total: json['total'] as String,
    keterangan: json['keterangan'] as String,
    noRekTujuan: json['noRekTujuan'] as String?,
    id: json['idTipetransaksi'] as String,
    biayaAdmin: json['biaya'] as String,
    nominal: json['nominal'] as String,
    typeTRX: json['typeTRX'] as String,
    idTrx: json['idTrx'] as String,
    namaTipeTransaksi: json['namaTipeTransaksi'] as String,
    nomorPenerima: json['nomorPenerima'] as String?,
    namaBank: json['namaBank'] as String?,
  );
}

Map<String, dynamic> _$LastTransactionToJson(LastTransaction instance) =>
    <String, dynamic>{
      'timeStamp': instance.timeStamp.toIso8601String(),
      'noHpTujuan': instance.noHpTujuan,
      'total': instance.total,
      'keterangan': instance.keterangan,
      'noRekTujuan': instance.noRekTujuan,
      'idTipetransaksi': instance.id,
      'biaya': instance.biayaAdmin,
      'nominal': instance.nominal,
      'typeTRX': instance.typeTRX,
      'idTrx': instance.idTrx,
      'namaTipeTransaksi': instance.namaTipeTransaksi,
      'nomorPenerima': instance.nomorPenerima,
      'namaBank': instance.namaBank,
    };

Produk _$ProdukFromJson(Map<String, dynamic> json) {
  return Produk(
    namaProduk: json['namaProduk'] as String,
    urlProduk: json['urlProduk'] as String,
    fotoProduk: json['fotoProduk'] as String,
    kategoriProduk: json['kategori_produk'] as String,
    hargaProduk: json['hargaProduk'] as String,
    createdAt: json['created_at'] as String,
    hargaDiskonProduk: json['hargaDiskonProduk'] as String,
  );
}

Map<String, dynamic> _$ProdukToJson(Produk instance) => <String, dynamic>{
      'namaProduk': instance.namaProduk,
      'urlProduk': instance.urlProduk,
      'fotoProduk': instance.fotoProduk,
      'kategori_produk': instance.kategoriProduk,
      'hargaProduk': instance.hargaProduk,
      'created_at': instance.createdAt,
      'hargaDiskonProduk': instance.hargaDiskonProduk,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    redirectClassName: json['redirectClassName'] as String,
    icon: json['icon'] as String,
    title: json['title'] as String,
    type: json['type'] as String,
    idMenu: json['idMenu'] as String,
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'redirectClassName': instance.redirectClassName,
      'icon': instance.icon,
      'title': instance.title,
      'type': instance.type,
      'idMenu': instance.idMenu,
    };

Iklan _$IklanFromJson(Map<String, dynamic> json) {
  return Iklan(
    (json['images'] as List<dynamic>)
        .map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$IklanToJson(Iklan instance) => <String, dynamic>{
      'images': instance.images,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(
    image: json['image'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'image': instance.image,
      'url': instance.url,
    };
