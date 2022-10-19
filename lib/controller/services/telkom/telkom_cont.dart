import 'dart:convert';

import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/recent_transaction.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';

class TelkomCont extends GetxController {
  final Network _network;
  TelkomCont(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  final contNoPelanggan = TextEditingController();
  final contPenyedia = TextEditingController();
  final contNominal = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final refreshController = RefreshController();
  final favoriteController = TextEditingController();

  var favorite = false.obs;
  var nom = 0.obs;
  var idBiller = ''.obs;
  var val = 'token'.obs;
  var adminFee = 5000.obs;
  var biayaAdmin = '0'.obs;
  var hargaCetak = '0'.obs;
  var periodeTagihan = ''.obs;
  var inProccess = false.obs;
  var listRecent = [].obs;
  var savedName = <Favorite>[].obs;
  var cookie;
  var uid;
  var listProductTv;
  var recentTrx = <DataLastTrx>[].obs;
  var balance = '0'.obs;
  var infoTelkom =
      '1. Produk Telkom IndiHome/ Telepon tidak tersedia pada jam cut off/maintenance (23.30 - 01.30).\n2. Transaksi pembayaran tagihan Telkom Indihome/ Telepon membutuhkan waktu proses maksimal 2x24 jam.'
          .obs;
  Map<String, dynamic> denomSelected = {};

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

    inProccess(true);
    await getCookie();
    await getUid();
    await getBalance();
    inProccess(false);
  }

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    uid = _pref.getString(kUid) ?? '';
  }

  void clear() => contNoPelanggan.clear();

  Future<void> getRecentTrx(String idMenu) async {
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idMenu': idMenu,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/home/getLastTrx', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final recentTrxModel = RecentTransaction.fromJson(decodedBody);
    recentTrx.addAll(recentTrxModel.dataLastTrx);
  }

  Future<DataFavorite> getFavorite(String idTipeTransaksi) async {
    final response = await _network.getFavorite(idTipeTransaksi);
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<void> getBalance() async {
    balanceModel = await _network.getBalance();
    final infoExtended = balanceModel.infoExtended;
    final lastBalance = balanceModel.infoMember.lastBalance;
    if (infoExtended != null) {
      if (int.parse(lastBalance.numericOnly()) <
          int.parse(infoExtended.extLimit.numericOnly())) {
        balance.value = lastBalance;
        return;
      }
      final limitInt = (int.parse(infoExtended.extLimit.numericOnly()) -
          int.parse(infoExtended.extUsed.numericOnly()));
      balance.value = limitInt.amountFormat;
      return;
    }
    balance.value = balanceModel.infoMember.lastBalance;
  }

  Future<dynamic> getProductTelkom() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/telkom/getBiller', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getInqTelkom() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': '3' + uid + timeStr,
      'idPelanggan': contNoPelanggan.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/telkom/inquiry', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getPayTelkom(dataDenom, dataInq, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': dataInq['idTrx'],
      'idPelanggan': contNoPelanggan.text,
      'deviceInfo': uid,
      'versionCode': versionCode,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'pin': pin,
      if (favorite.value == true) 'namaAlias': favoriteController.text,
    };
    final response = await _network.post(
        url: 'eidupay/telkom/payment', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(inquiry, String pin) async {
    return await getPayTelkom(inquiry[0], inquiry[1], pin);
  }

  Future<void> continueTap() async {
    if (favorite.value) {
      if (favoriteController.text.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Nama Favorit belum di isi');
        return;
      }
    }
    if (formKey.currentState!.validate()) {
      if (idBiller.value != null) {
        await _tv();
      }
    }
  }

  Future<void> _tv() async {
    EiduLoadingDialog.showLoadingDialog();
    var inquiryResponse = await getInqTelkom();
    Get.back();

    if (inquiryResponse['ACK'] == 'NOK') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay',
          description:
              StringUtils.stringToErrorMessage(inquiryResponse['pesan']));
      return;
    }

    if (inquiryResponse['ACK'] == 'OK') {
      hargaCetak.value = inquiryResponse['hargaCetak']!;
      biayaAdmin.value = inquiryResponse['biayaAdmin']!;
      var bayar = await showCupertinoModalPopup(
          context: navigatorKey.currentContext!,
          builder: (_) => confirmTelkom(inquiryResponse));
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<TelkomCont>(pageController: this),
          arguments: [idBiller.value, inquiryResponse],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          if (payResponse['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan Telkom',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: 'Rp. ' + hargaCetak.value,
                    total: 'Rp. ' + hargaCetak.value,
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'Periode Tagihan : ' + periodeTagihan.value,
                    trxId: inquiryResponse['idTrx']));
          } else if (payResponse['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan Telkom',
                    description: 'Pembayaran Tagihan Telkom Berhasil!',
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    nominal: 'Rp. ' + hargaCetak.value,
                    total: 'Rp. ' + hargaCetak.value,
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'Periode Tagihan : ' + periodeTagihan.value,
                    trxId: inquiryResponse['idTrx']));
          }
        }
      }
    }
  }

  Widget confirmTelkom(data) {
    return CupertinoActionSheet(
        message: Column(
      children: [
        Container(
          width: w(65),
          height: 5,
          color: Colors.grey[350],
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: w(37),
          height: w(37),
          child: Image.asset('assets/images/ico_confirm_btm.png'),
        ),
        const SizedBox(height: 18),
        Text(
          'Konfirmasi',
          style: TextStyle(
              fontSize: w(22), fontWeight: FontWeight.w500, color: t100),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informasi Pelanggan',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        SizedBox(height: w(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No. Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                contNoPelanggan.text,
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        SizedBox(height: h(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              SizedBox(
                width: 120.0,
                child: Text(
                  data['nama'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: h(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Periode',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['periode'],
                maxLines: 1,
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        SizedBox(height: w(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informasi Pembayaran',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        SizedBox(height: w(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nominal',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                'Rp. ' + data['tagihan'],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Colors.grey[200],
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Admin',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                'Rp. ' + data['biayaAdmin'],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        const SizedBox(
            width: double.infinity,
            height: 30,
            child: DashLineDivider(height: 1)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
              ),
              Text(
                'Rp. ' + data['hargaCetak'],
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.bold, color: green),
              ),
            ],
          ),
        ),
        SizedBox(height: w(35)),
        SubmitButton(
          backgroundColor: green,
          text: 'Bayar',
          onPressed: () {
            final infoExtended = balanceModel.infoExtended;
            final dailyLimit =
                int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
            final harga =
                int.parse(data['hargaCetak'].toString().numericOnly());
            final saldo = int.parse(balance.value.toString().numericOnly());
            if (saldo < harga) {
              EiduInfoDialog.showInfoDialog(
                  title: 'Eidupay', description: 'Saldo tidak mencukupi!');
              return;
            }
            if (infoExtended != null && dailyLimit != 0) {
              final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
                  ? int.parse(infoExtended.extDailyUsed.numericOnly())
                  : 0;
              final harga =
                  int.parse(data['hargaCetak'].toString().numericOnly());
              if (dailyUsed + harga > dailyLimit) {
                EiduInfoDialog.showInfoDialog(
                    title: 'Daily limit sudah mencapai batas!');
                return;
              }
            }
            Get.back(result: true);
          },
        ),
        SizedBox(height: w(17)),
        GestureDetector(
            onTap: () => Get.back(result: false),
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
            )),
        SizedBox(height: w(20)),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
