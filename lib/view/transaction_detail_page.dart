import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/controller/transaction_detail_controller.dart';
import 'package:eidupay/model/education.dart';
import 'package:eidupay/model/mutasi.dart';
import 'package:eidupay/model/notification.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:eidupay/extension.dart';

class TransactionDetailPage extends StatefulWidget {
  static final route = GetPage(
      name: '/transaction/detail/:id',
      page: () => const TransactionDetailPage());

  const TransactionDetailPage({Key? key}) : super(key: key);

  @override
  _TransactionDetailPageState createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  NotifDetail argument = Get.arguments['notifDetail'];
  Mutasi mutasi = Get.arguments['mutasi'];
  final _c = Get.put(TransactionDetailController());

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _c.screenshotController,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
          title: const Text('Rincian Transaksi',
              style: TextStyle(color: Colors.white)),
          actions: [
            MaterialButton(
              shape: const CircleBorder(),
              child: const Image(
                  height: 24,
                  color: Colors.white,
                  image: AssetImage('assets/images/share.png')),
              onPressed: () async {
                await _c.screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((Uint8List? image) async {
                  if (image != null) {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath =
                        await File('${directory.path}/image.png').create();
                    await imagePath.writeAsBytes(image);

                    /// Share Plugin
                    await Share.shareFiles([imagePath.path]);
                  }
                });
              },
            )
          ],
        ),
        body: _BodyTransactionDetailPage(argument: argument, mutasi: mutasi),
      ),
    );
  }
}

class _BodyTransactionDetailPage extends StatefulWidget {
  final NotifDetail argument;
  final Mutasi mutasi;
  const _BodyTransactionDetailPage(
      {Key? key, required this.argument, required this.mutasi})
      : super(key: key);

  @override
  _BodyTransactionDetailPageState createState() =>
      _BodyTransactionDetailPageState();
}

class _BodyTransactionDetailPageState
    extends State<_BodyTransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    final lastTransaction = widget.argument;
    final status = widget.argument.statusTrx;
    final biaya = int.parse(lastTransaction.biaya.numericOnly()).amountFormat;
    final total = int.parse(lastTransaction.total.numericOnly()).amountFormat;
    final detail = lastTransaction.detail != 'null'
        ? lastTransaction.detail
        : lastTransaction.customerReference;
    final nameExtended = widget.mutasi.nameExtended;
    final phoneExtended = widget.mutasi.phoneExtended;
    final type = dtUser['tipe'];
    final color = status == 'SUKSES'
        ? green
        : status == 'PENDING'
            ? orange1
            : red;

    int getNominal() {
      late int nominal;
      if (widget.argument.idTipetransaksi == 2) {
        nominal = (int.parse(lastTransaction.total.numericOnly()) +
            int.parse(lastTransaction.biaya.numericOnly()));
      } else {
        nominal = (int.parse(lastTransaction.total.numericOnly()) -
            int.parse(lastTransaction.biaya.numericOnly()));
      }
      return nominal;
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.43,
          decoration: BoxDecoration(
              color: color,
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/fingerprint_shape.png'))),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.060,
              right: 12,
              left: 12,
              bottom: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h(16)),
                    Text(
                      lastTransaction.namaTipeTransaksi,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: h(8)),
                    Row(
                      children: [
                        Icon(
                            status == 'SUKSES'
                                ? Icons.check_circle_outline
                                : status == 'PENDING'
                                    ? Icons.autorenew_outlined
                                    : Icons.cancel_outlined,
                            color: Colors.white,
                            size: 20),
                        const SizedBox(width: 11),
                        Text(
                            status == 'SUKSES'
                                ? 'Transaksi berhasil'
                                : status == 'PENDING'
                                    ? 'Transaksi dalam proses'
                                    : 'Transaksi gagal',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 476,
                width: 350,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(27)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFFD8D8D8).withAlpha(80),
                          offset: const Offset(0, 33),
                          blurRadius: 26)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          CustomSingleRowSelectableTextCard(
                              title: 'ID Transaksi',
                              value: lastTransaction.idTransaksi),

                          //dynamic transaction detail
                          if (detail != null && detail != 'null')
                            _detailWidget(detail),
                          // if (lastTransaction.namaTipeTransaksi ==
                          //         'PLN Prabayar' &&
                          //     lastTransaction.customerReference != '')
                          //   CustomSingleRowCard(
                          //     title: 'Token',
                          //     value: lastTransaction.customerReference!
                          //         .substring(0, 24),
                          //   ),
                          CustomSingleRowCard(
                            title: 'Tanggal',
                            value: lastTransaction.timeStamp,
                          ),
                          CustomSingleRowCard(
                            title: 'Nominal',
                            value: 'Rp ' + getNominal().amountFormat,
                          ),
                          CustomSingleRowCard(
                            title: 'Biaya Admin',
                            value: 'Rp ' + biaya,
                          ),
                          const SizedBox(
                            height: 10,
                            child: DashLineDivider(
                              color: Color(0xFFB8B8B8),
                            ),
                          ),
                          CustomSingleRowCard(
                            title: 'Total',
                            value: 'Rp ' + total,
                            valueColor: color,
                            valueSize: 18,
                          ),
                          const SizedBox(
                            height: 5,
                            child: DashLineDivider(
                              color: Color(0xFFB8B8B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/logo_eidupay.png',
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              (nameExtended != null ||
                      phoneExtended != null && type != 'extended')
                  ? Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '*transaksi dilakukan oleh sub account ($nameExtended: $phoneExtended).',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    )
                  : const Spacer(flex: 4),
            ],
          ),
        )
      ],
    );
  }

  Widget _detailWidget(String detail) {
    final lastTransaction = widget.argument;
    final decodedDetail = jsonDecode(detail);
    switch (lastTransaction.idTipetransaksi) {
      case (17): //Pulsa
        final detail = NotifDetailPulsa.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'Provider', value: detail.provider),
            CustomSingleRowSelectableTextCard(
                title: 'No. HP', value: detail.noHp),
          ],
        );
      case (13): //Paket Data
        final detail = NotifDetailTv.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(
                title: 'Nomor Pelanggan', value: detail.idPelanggan),
            CustomSingleRowSelectableTextCard(
                title: 'Nama Pelanggan', value: detail.nama),
            CustomSingleRowCard(
                title: 'Periode Tagihan', value: detail.blnTahun),
          ],
        );
      case (15): //Telkom
        final detail = NotifDetailTelkom.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(
                title: 'Nomor Pelanggan', value: detail.idPelanggan),
            CustomSingleRowSelectableTextCard(
                title: 'Nama Pelanggan', value: detail.nama),
            CustomSingleRowCard(
                title: 'Periode Tagihan', value: detail.blnTahun),
          ],
        );

      case (57): //Paket Data
        final detail = NotifDetailPaketData.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'Provider', value: detail.provider),
            CustomSingleRowSelectableTextCard(
                title: 'No. HP', value: detail.noHp),
            CustomSingleRowCard(title: 'Paket', value: detail.namaProduk),
          ],
        );
      case (93): //Transfer Member
        final detail = NotifDetailMember.fromJson(decodedDetail);
        final remark = detail.remark.isNotEmpty ? detail.remark : '-';
        if (lastTransaction.typeTrx == 'DEPOSIT') {
          return Column(
            children: [
              CustomSingleRowCard(
                  title: 'Dari',
                  value: '${detail.namaPengirim} - ${detail.noHpPengirim}'),
              CustomSingleRowCard(title: 'Berita', value: remark),
            ],
          );
        } else if (lastTransaction.typeTrx == 'WITHDRAW') {
          return Column(
            children: [
              CustomSingleRowCard(
                  title: 'Ke',
                  value: '${detail.namaPenerima} - ${detail.noHpPenerima}'),
              CustomSingleRowCard(title: 'Berita', value: remark),
            ],
          );
        }
        break;
      case (6): // Transfer Bank
        final detail = NotifDetailBank.fromJson(decodedDetail);
        final remark = (detail.remark.isNotEmpty && detail.remark != ' ')
            ? detail.remark
            : '-';
        return Column(
          children: [
            CustomSingleRowCard(title: 'Nama Bank', value: detail.namaBank),
            CustomSingleRowSelectableTextCard(
                title: 'No. Rek', value: detail.noRek),
            CustomSingleRowCard(title: 'Nama', value: detail.namaRek),
            CustomSingleRowCard(title: 'Berita', value: remark),
          ],
        );
      case (12): // PLN Pasca bayar
        final detail = NotifDetailTagihanPlnPascaBayar.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowSelectableTextCard(
                title: 'Nomor Pelanggan', value: detail.idPelanggan),
            CustomSingleRowCard(title: 'Nama', value: detail.nama),
            CustomSingleRowCard(
                title: 'Tagihan pada', value: detail.bulanTahun),
            CustomSingleRowSelectableTextCard(
                title: 'Stand Meter', value: detail.standMeter),
          ],
        );
      case (18): // PLN Prabayar
        final detail = NotifDetailTagihanPlnPraBayar.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowSelectableTextCard(
                title: 'Nomor Pelanggan', value: detail.idPelanggan),
            CustomSingleRowCard(
              title: 'Nama',
              value: detail.nama,
            ),
            CustomSingleRowCard(
              title: 'Token',
              value: detail.token,
              copyable: true,
            ),
            CustomSingleRowCard(title: 'kWh', value: detail.kwh),
            CustomSingleRowSelectableTextCard(
                title: 'Tarif/Daya', value: detail.tarifDaya),
          ],
        );
      case (92):
        final detail = NotifDetailEdukasiReference.fromJson(decodedDetail);
        String dataBill = detail.dataBill
            .map((e) => InquiryListCategoryData.fromJson(e).billName)
            .toList()
            .join('\n');
        return Column(
          children: [
            CustomSingleRowCard(title: 'Lembaga', value: detail.lembaga),
            CustomSingleRowSelectableTextCard(title: 'NIS', value: detail.nis),
            CustomSingleRowCard(title: 'Nama', value: detail.namaSiswa),
            CustomSingleRowCard(title: 'Kelas', value: detail.kelas),
            CustomSingleRowCard(title: 'Tagihan', value: dataBill),
          ],
        ); //Edukasi
      case (100): //Tabungan
        final detail = NotifDetailEdukasi.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'Lembaga', value: detail.lembaga),
            CustomSingleRowSelectableTextCard(title: 'NIS', value: detail.nis),
            CustomSingleRowCard(title: 'Nama', value: detail.namaSiswa),
            CustomSingleRowCard(title: 'Kelas', value: detail.kelas),
          ],
        );
      case (97): //Donasi
        final detail = NotifDetailDonasi.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'Lembaga', value: detail.lembaga),
            CustomSingleRowCard(title: 'Tipe', value: detail.tipeDonasi),
          ],
        );
      case (101): //Topup Game
        final detail = NotifDetailTopupGame.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(
                title: 'Game', value: '${detail.game} - ${detail.produk}'),
            CustomSingleRowSelectableTextCard(
                title: 'Username', value: detail.username),
          ],
        );
      case (102): //Voucher Game
        final detail = NotifDetailVoucherGame.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'Game', value: detail.game),
          ],
        );
      case (98): //Pembayaran Merchant
        final detail = NotifDetailMerchant.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'Merchant', value: detail.namaMerchant)
          ],
        );
      case (39):
        final detail = NotifDetailBpjs.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowSelectableTextCard(
                title: 'Nomor Pelanggan', value: detail.idPelanggan),
            CustomSingleRowCard(title: 'Nama', value: detail.nama),
            CustomSingleRowCard(
                title: 'Jumlah Peserta', value: detail.jmlPeserta),
            CustomSingleRowSelectableTextCard(
                title: 'Periode', value: StringUtils.getMonth(detail.jmlBulan)),
          ],
        );
      case (11): // PDAM
        final detail = NotifDetailLain.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowSelectableTextCard(
                title: 'No.', value: detail.idPelanggan),
          ],
        );
      case (104):
        final detail = NotifDetailEMoney.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(title: 'E-Money', value: detail.emoney),
            CustomSingleRowCard(title: 'No. Tujuan', value: detail.tujuan),
          ],
        );
      case (105):
        final detail = NotifDetailESamsat.fromJson(decodedDetail);
        return Column(
          children: [
            CustomSingleRowCard(
                title: 'Kode Pembayaran', value: detail.kodePembayaran),
            CustomSingleRowCard(
                title: 'Plat Nomor', value: detail.platNomorKendaraan),
            CustomSingleRowCard(
                title: 'Nama Pemilik', value: detail.namaPemilik),
            CustomSingleRowCard(
                title: 'Alamat Pemilik', value: detail.alamatPemilik),
            CustomSingleRowCard(
                title: 'Merek Kendaraan', value: detail.namaMerekKb),
            CustomSingleRowCard(
                title: 'Model Kendaraan', value: detail.namaModelKb),
            CustomSingleRowCard(
                title: 'Merek Kendaraan', value: detail.namaMerekKb),
            CustomSingleRowCard(
                title: 'Tahun Pembuatan', value: detail.tahunBuatan),

            // ,namaMerekKb,namaModelKb,alamatPemilik,tahunBuatan
          ],
        );
      default:
        break;
    }
    return const SizedBox.shrink();
  }
}
