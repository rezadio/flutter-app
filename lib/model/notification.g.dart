// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    data: Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    unread: json['unread'] as int,
    list: (json['list'] as List<dynamic>)
        .map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'unread': instance.unread,
      'list': instance.list,
    };

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return NotificationData(
    id: json['id'] as int? ?? 0,
    title: json['title'] as String? ?? '',
    body: json['body'] as String? ?? '',
    detailType: json['detailType'] as String? ?? '',
    read: json['read'] as bool? ?? false,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    detailReff: json['detailReff'] as String?,
  );
}

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'detailType': instance.detailType,
      'read': instance.read,
      'createdAt': instance.createdAt?.toIso8601String(),
      'detailReff': instance.detailReff,
    };

NotifInfoResponse _$NotifInfoResponseFromJson(Map<String, dynamic> json) {
  return NotifInfoResponse(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    data: NotifInfo.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotifInfoResponseToJson(NotifInfoResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'data': instance.data,
    };

NotifInfo _$NotifInfoFromJson(Map<String, dynamic> json) {
  return NotifInfo(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$NotifInfoToJson(NotifInfo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };

NotifDetailResponse _$NotifDetailResponseFromJson(Map<String, dynamic> json) {
  return NotifDetailResponse(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    data: (json['data'] as List<dynamic>)
        .map((e) => NotifDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NotifDetailResponseToJson(
        NotifDetailResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'data': instance.data,
    };

NotifDetail _$NotifDetailFromJson(Map<String, dynamic> json) {
  return NotifDetail(
    idTransaksi: json['idTransaksi'] as String,
    idTrx: json['idTrx'] as String,
    statusTrx: json['statusTrx'] as String,
    statusDana: json['statusDana'] as String,
    statusRefund: json['statusRefund'] as String,
    statusDeduct: json['statusDeduct'] as String,
    typeTrx: json['typeTrx'] as String,
    namaTipeTransaksi: json['namaTipeTransaksi'] as String,
    hargaJual: json['hargaJual'] as String,
    biaya: json['biaya'] as String,
    total: json['total'] as String,
    keterangan: json['keterangan'] as String,
    lastBalance: json['lastBalance'] as String,
    timeStamp: json['timeStamp'] as String,
    idTipetransaksi: json['idTipetransaksi'] as int,
    detail: json['detail'] as String?,
    customerReference: json['customerReference'] as String?,
  );
}

Map<String, dynamic> _$NotifDetailToJson(NotifDetail instance) =>
    <String, dynamic>{
      'idTransaksi': instance.idTransaksi,
      'idTrx': instance.idTrx,
      'statusTrx': instance.statusTrx,
      'statusDana': instance.statusDana,
      'statusRefund': instance.statusRefund,
      'statusDeduct': instance.statusDeduct,
      'typeTrx': instance.typeTrx,
      'namaTipeTransaksi': instance.namaTipeTransaksi,
      'hargaJual': instance.hargaJual,
      'biaya': instance.biaya,
      'total': instance.total,
      'keterangan': instance.keterangan,
      'lastBalance': instance.lastBalance,
      'timeStamp': instance.timeStamp,
      'idTipetransaksi': instance.idTipetransaksi,
      'detail': instance.detail,
      'customerReference': instance.customerReference,
    };

NotifDetailPulsa _$NotifDetailPulsaFromJson(Map<String, dynamic> json) {
  return NotifDetailPulsa(
    noHp: json['noHp'] as String,
    provider: json['provider'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailPulsaToJson(NotifDetailPulsa instance) =>
    <String, dynamic>{
      'noHp': instance.noHp,
      'provider': instance.provider,
      'nominal': instance.nominal,
    };

NotifDetailTv _$NotifDetailTvFromJson(Map<String, dynamic> json) {
  return NotifDetailTv(
    json['idPelanggan'] as String,
    json['nama'] as String,
    json['blnTahun'] as String,
  );
}

Map<String, dynamic> _$NotifDetailTvToJson(NotifDetailTv instance) =>
    <String, dynamic>{
      'idPelanggan': instance.idPelanggan,
      'nama': instance.nama,
      'blnTahun': instance.blnTahun,
    };

NotifDetailTelkom _$NotifDetailTelkomFromJson(Map<String, dynamic> json) {
  return NotifDetailTelkom(
    json['idPelanggan'] as String,
    json['nama'] as String,
    json['blnTahun'] as String,
  );
}

Map<String, dynamic> _$NotifDetailTelkomToJson(NotifDetailTelkom instance) =>
    <String, dynamic>{
      'idPelanggan': instance.idPelanggan,
      'nama': instance.nama,
      'blnTahun': instance.blnTahun,
    };

NotifDetailMember _$NotifDetailMemberFromJson(Map<String, dynamic> json) {
  return NotifDetailMember(
    noHpPenerima: json['noHpPenerima'] as String,
    namaPenerima: json['namaPenerima'] as String,
    noHpPengirim: json['noHpPengirim'] as String,
    namaPengirim: json['namaPengirim'] as String,
    nominal: json['nominal'] as int,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$NotifDetailMemberToJson(NotifDetailMember instance) =>
    <String, dynamic>{
      'noHpPenerima': instance.noHpPenerima,
      'namaPenerima': instance.namaPenerima,
      'noHpPengirim': instance.noHpPengirim,
      'namaPengirim': instance.namaPengirim,
      'remark': instance.remark,
      'nominal': instance.nominal,
    };

NotifDetailBank _$NotifDetailBankFromJson(Map<String, dynamic> json) {
  return NotifDetailBank(
    namaBank: json['namaBank'] as String,
    noRek: json['noRek'] as String,
    namaRek: json['namaRek'] as String,
    nominal: json['nominal'] as int,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$NotifDetailBankToJson(NotifDetailBank instance) =>
    <String, dynamic>{
      'namaBank': instance.namaBank,
      'noRek': instance.noRek,
      'namaRek': instance.namaRek,
      'remark': instance.remark,
      'nominal': instance.nominal,
    };

NotifDetailPaketData _$NotifDetailPaketDataFromJson(Map<String, dynamic> json) {
  return NotifDetailPaketData(
    noHp: json['noHp'] as String,
    provider: json['provider'] as String,
    namaProduk: json['namaProduk'] as String,
  );
}

Map<String, dynamic> _$NotifDetailPaketDataToJson(
        NotifDetailPaketData instance) =>
    <String, dynamic>{
      'noHp': instance.noHp,
      'provider': instance.provider,
      'namaProduk': instance.namaProduk,
    };

NotifDetailTagihanPlnPascaBayar _$NotifDetailTagihanPlnPascaBayarFromJson(
    Map<String, dynamic> json) {
  return NotifDetailTagihanPlnPascaBayar(
    idPelanggan: json['idPelanggan'] as String,
    nama: json['nama'] as String,
    tarifDaya: json['tarifDaya'] as String,
    standMeter: json['standMeter'] as String,
    bulanTahun: json['bulanTahun'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailTagihanPlnPascaBayarToJson(
        NotifDetailTagihanPlnPascaBayar instance) =>
    <String, dynamic>{
      'idPelanggan': instance.idPelanggan,
      'nama': instance.nama,
      'tarifDaya': instance.tarifDaya,
      'standMeter': instance.standMeter,
      'bulanTahun': instance.bulanTahun,
      'nominal': instance.nominal,
    };

NotifDetailTagihanPlnPraBayar _$NotifDetailTagihanPlnPraBayarFromJson(
    Map<String, dynamic> json) {
  return NotifDetailTagihanPlnPraBayar(
    idPelanggan: json['idPelanggan'] as String,
    nama: json['nama'] as String,
    tarifDaya: json['tarifDaya'] as String,
    kwh: json['kwh'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$NotifDetailTagihanPlnPraBayarToJson(
        NotifDetailTagihanPlnPraBayar instance) =>
    <String, dynamic>{
      'idPelanggan': instance.idPelanggan,
      'nama': instance.nama,
      'tarifDaya': instance.tarifDaya,
      'kwh': instance.kwh,
      'token': instance.token,
    };

NotifDetailDonasi _$NotifDetailDonasiFromJson(Map<String, dynamic> json) {
  return NotifDetailDonasi(
    lembaga: json['lembaga'] as String,
    tipeDonasi: json['tipeDonasi'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailDonasiToJson(NotifDetailDonasi instance) =>
    <String, dynamic>{
      'lembaga': instance.lembaga,
      'tipeDonasi': instance.tipeDonasi,
      'nominal': instance.nominal,
    };

NotifDetailEdukasi _$NotifDetailEdukasiFromJson(Map<String, dynamic> json) {
  return NotifDetailEdukasi(
    lembaga: json['lembaga'] as String,
    kelas: json['kelas'] as String,
    namaSiswa: json['namaSiswa'] as String,
    nis: json['nis'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailEdukasiToJson(NotifDetailEdukasi instance) =>
    <String, dynamic>{
      'lembaga': instance.lembaga,
      'kelas': instance.kelas,
      'namaSiswa': instance.namaSiswa,
      'nis': instance.nis,
      'nominal': instance.nominal,
    };

NotifDetailEdukasiReference _$NotifDetailEdukasiReferenceFromJson(
    Map<String, dynamic> json) {
  return NotifDetailEdukasiReference(
    json['dataBill'] as List<dynamic>,
    lembaga: json['merchantName'] as String,
    kelas: json['kelas'] as String,
    namaSiswa: json['customerName'] as String,
    nis: json['customerNumber'] as String,
    nominal: json['bayar'] as String,
  );
}

Map<String, dynamic> _$NotifDetailEdukasiReferenceToJson(
        NotifDetailEdukasiReference instance) =>
    <String, dynamic>{
      'merchantName': instance.lembaga,
      'kelas': instance.kelas,
      'customerName': instance.namaSiswa,
      'customerNumber': instance.nis,
      'bayar': instance.nominal,
      'dataBill': instance.dataBill,
    };

NotifDetailTopupGame _$NotifDetailTopupGameFromJson(Map<String, dynamic> json) {
  return NotifDetailTopupGame(
    game: json['game'] as String,
    username: json['username'] as String,
    produk: json['produk'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailTopupGameToJson(
        NotifDetailTopupGame instance) =>
    <String, dynamic>{
      'game': instance.game,
      'username': instance.username,
      'produk': instance.produk,
      'nominal': instance.nominal,
    };

NotifDetailVoucherGame _$NotifDetailVoucherGameFromJson(
    Map<String, dynamic> json) {
  return NotifDetailVoucherGame(
    game: json['game'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailVoucherGameToJson(
        NotifDetailVoucherGame instance) =>
    <String, dynamic>{
      'game': instance.game,
      'nominal': instance.nominal,
    };

NotifDetailMerchant _$NotifDetailMerchantFromJson(Map<String, dynamic> json) {
  return NotifDetailMerchant(
    namaMerchant: json['namaMerchant'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailMerchantToJson(
        NotifDetailMerchant instance) =>
    <String, dynamic>{
      'namaMerchant': instance.namaMerchant,
      'nominal': instance.nominal,
    };

NotifDetailLain _$NotifDetailLainFromJson(Map<String, dynamic> json) {
  return NotifDetailLain(
    idPelanggan: json['idPelanggan'] as String,
    nominal: json['nominal'] as int,
  );
}

Map<String, dynamic> _$NotifDetailLainToJson(NotifDetailLain instance) =>
    <String, dynamic>{
      'idPelanggan': instance.idPelanggan,
      'nominal': instance.nominal,
    };

NotifDetailBpjs _$NotifDetailBpjsFromJson(Map<String, dynamic> json) {
  return NotifDetailBpjs(
    json['idPelanggan'] as String,
    json['nama'] as String,
    json['jmlPeserta'] as String,
    json['jmlBulan'] as String,
  );
}

Map<String, dynamic> _$NotifDetailBpjsToJson(NotifDetailBpjs instance) =>
    <String, dynamic>{
      'idPelanggan': instance.idPelanggan,
      'nama': instance.nama,
      'jmlPeserta': instance.jmlPeserta,
      'jmlBulan': instance.jmlBulan,
    };

NotifDetailEMoney _$NotifDetailEMoneyFromJson(Map<String, dynamic> json) {
  return NotifDetailEMoney(
    tujuan: json['tujuan'] as String,
    emoney: json['emoney'] as String,
    nominal: json['nominal'] as String,
  );
}

Map<String, dynamic> _$NotifDetailEMoneyToJson(NotifDetailEMoney instance) =>
    <String, dynamic>{
      'tujuan': instance.tujuan,
      'emoney': instance.emoney,
      'nominal': instance.nominal,
    };

NotifDetailESamsat _$NotifDetailESamsatFromJson(Map<String, dynamic> json) {
  return NotifDetailESamsat(
    json['namaMerekKb'] as String,
    json['namaModelKb'] as String,
    json['alamatPemilik'] as String,
    json['tahunBuatan'] as String,
    kodePembayaran: json['kodePembayaran'] as String,
    namaPemilik: json['namaPemilik'] as String,
    platNomorKendaraan: json['platNomorKendaraan'] as String,
  );
}

Map<String, dynamic> _$NotifDetailESamsatToJson(NotifDetailESamsat instance) =>
    <String, dynamic>{
      'kodePembayaran': instance.kodePembayaran,
      'namaPemilik': instance.namaPemilik,
      'platNomorKendaraan': instance.platNomorKendaraan,
      'namaMerekKb': instance.namaMerekKb,
      'namaModelKb': instance.namaModelKb,
      'alamatPemilik': instance.alamatPemilik,
      'tahunBuatan': instance.tahunBuatan,
    };
