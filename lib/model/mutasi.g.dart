// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mutasi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutasiModel _$MutasiModelFromJson(Map<String, dynamic> json) {
  return MutasiModel(
    ack: json['ACK'] as String,
    dataMutasi: (json['dataMutasi'] as List<dynamic>?)
            ?.map((e) => Mutasi.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$MutasiModelToJson(MutasiModel instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'dataMutasi': instance.dataMutasi,
    };

Mutasi _$MutasiFromJson(Map<String, dynamic> json) {
  return Mutasi(
    noHpPenerima: json['NoHPPenerima'] as String?,
    statusTrx: json['StatusTRX'] as String,
    typeTrx: json['typeTrx'] as String,
    idPelanggan: json['id_pelanggan'] as String?,
    noHpTujuan: json['NoHPTujuan'] as String,
    total: json['total'] as String,
    namePengirim: json['NamePengirim'] as String,
    tanggalExpired: json['TanggalExpired'] as String?,
    namaPenerima: json['NamaPenerima'] as String?,
    statusDeduct: json['StatusDeduct'] as String,
    hargaJual: json['hargajual'] as String,
    noHpPengirim: json['NoHPPengirim'] as String,
    hargaBeli: json['hargabeli'] as String,
    idIdentitasPenerima: json['IdIdentitasPenerima'] as String?,
    berita: json['Berita'] as String?,
    idTransaksi: json['idTransaksi'] as String,
    pinPencairan: json['PinPencairan'] as String?,
    idTrx: json['idTrx'] as String,
    tipeTransaksi: json['tipeTransaksi'] as String,
    lastBalance: json['lastBalance'] as String,
    timeStamp: DateTime.parse(json['timeStamp'] as String),
    statusDana: json['StatusDana'] as String,
    biaya: json['Biaya'] as String,
    statusTopUp: json['StatusTopUp'] as String?,
    keterangan: json['Keterangan'] as String,
    namePenerima: json['NamePenerima'] as String?,
    statusRefund: json['StatusRefund'] as String,
    namaTipeTransaksi: json['NamaTipeTransaksi'] as String,
    idStock: json['idStock'] as String,
    nameExtended: json['nameExtended'] as String?,
    customerReference: json['customerReference'] as String?,
    phoneExtended: json['phoneExtended'] as String?,
  );
}

Map<String, dynamic> _$MutasiToJson(Mutasi instance) => <String, dynamic>{
      'NoHPPenerima': instance.noHpPenerima,
      'StatusTRX': instance.statusTrx,
      'typeTrx': instance.typeTrx,
      'id_pelanggan': instance.idPelanggan,
      'NoHPTujuan': instance.noHpTujuan,
      'total': instance.total,
      'NamePengirim': instance.namePengirim,
      'TanggalExpired': instance.tanggalExpired,
      'NamaPenerima': instance.namaPenerima,
      'StatusDeduct': instance.statusDeduct,
      'hargajual': instance.hargaJual,
      'NoHPPengirim': instance.noHpPengirim,
      'hargabeli': instance.hargaBeli,
      'IdIdentitasPenerima': instance.idIdentitasPenerima,
      'Berita': instance.berita,
      'idTransaksi': instance.idTransaksi,
      'PinPencairan': instance.pinPencairan,
      'idTrx': instance.idTrx,
      'tipeTransaksi': instance.tipeTransaksi,
      'lastBalance': instance.lastBalance,
      'timeStamp': instance.timeStamp.toIso8601String(),
      'StatusDana': instance.statusDana,
      'Biaya': instance.biaya,
      'StatusTopUp': instance.statusTopUp,
      'Keterangan': instance.keterangan,
      'NamePenerima': instance.namePenerima,
      'StatusRefund': instance.statusRefund,
      'NamaTipeTransaksi': instance.namaTipeTransaksi,
      'idStock': instance.idStock,
      'customerReference': instance.customerReference,
      'phoneExtended': instance.phoneExtended,
      'nameExtended': instance.nameExtended,
    };
