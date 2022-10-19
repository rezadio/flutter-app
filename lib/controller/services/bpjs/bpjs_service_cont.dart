import 'dart:convert';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/extension.dart';

import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/recent_transaction.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/model/default_model.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_kyc_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';

class BPJSServiceCont extends GetxController {
  final Network _network;
  BPJSServiceCont(this._network);
  late BalanceModel balanceModel;
  final formKey = GlobalKey<FormState>();
  final custNumberCont = TextEditingController();
  var remember = false.obs;
  var recentTrx = <DataLastTrx>[].obs;
  final favoriteController = TextEditingController();
  var aliasName = 'null'.obs;
  var savedName = <Favorite>[].obs;
  var biayaAdmin = '0'.obs;
  var hargaCetak = '0'.obs;
  var cookie;
  var balance = '0'.obs;
  var inProccess = false.obs;
  late SharedPreferences _pref;
  void clear() => custNumberCont.clear();
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

  Future<void> getRecentTrx(String idMenu) async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
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

  Future<void> continueTap() async {
    if (remember.value) {
      if (favoriteController.text.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Nama Favorit belum di isi');
        return;
      }
    }
    if (formKey.currentState?.validate() == true) {
      await _bpjs();
    }
  }

  Future<dynamic> getInqTagihan() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'idTrx': '3' +
          DateFormat('yyMMddHHmmss').format(DateTime.now()) +
          (_pref.getString(kUid) ?? ''),
      'idPelanggan': custNumberCont.text,
      'packageName': _package.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/bpjs/getInq', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      return decodedBody;
    } catch (e) {
      e.printError();
      Get.back();
      final defaultModel = DefaultModel.fromJson(decodedBody);
      if (defaultModel.pesan.contains('Upgrade Premium')) {
        EiduKycBottomSheet.showBottomSheet();
      } else {
        await EiduInfoDialog.showInfoDialog(title: defaultModel.pesan);
      }
      rethrow;
    }
  }

  Future<dynamic> pay(inquiry, String pin) async {
    return await getPayBpjs(inquiry[0], inquiry[1], pin);
  }

  Future<void> _bpjs() async {
    EiduLoadingDialog.showLoadingDialog();
    var inquiryResponse = await getInqTagihan();
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
          builder: (_) => confirmBpjs(inquiryResponse));
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<BPJSServiceCont>(pageController: this),
          arguments: [custNumberCont.value, inquiryResponse],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          if (payResponse['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan BPJS Kesehatan',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: 'Rp. ' + hargaCetak.value,
                    total: 'Rp. ' + hargaCetak.value,
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    ket1:
                        'Nama Pelanggan : ' + inquiryResponse['namaPelanggan'],
                    ket2: 'Periode : ' + inquiryResponse['periode'],
                    trxId: inquiryResponse['idTrx']));
          } else if (payResponse['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan BPJS Kesehatan',
                    description: 'Pembayaran tagihan BPJS Kesehatan Berhasil!',
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    nominal: 'Rp. ' + inquiryResponse['tagihan'],
                    total: 'Rp. ' + hargaCetak.value,
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'Periode : ' +
                        StringUtils.getMonth(inquiryResponse['periode']),
                    trxId: inquiryResponse['idTrx']));
          }
        }
      }
    }
  }

  Widget confirmBpjs(data) {
    return Material(
        child: CupertinoActionSheet(
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
                'Nomor Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                custNumberCont.text,
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
                width: 150.0,
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
                StringUtils.getMonth(data['periode']),
                maxLines: 1,
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
                'Jumlah Peserta',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['jmlPeserta'],
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
    )));
  }

  Future<void> getPayBpjs(dataDenom, dataInq, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      // 'namaPelanggan': bpjs.nama,
      // 'switchPrintStruk': false,
      'idTrx': dataInq['idTrx'],
      'idPelanggan': custNumberCont.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'pin': pin,
      'versionCode': versionCode,
      if (dataInq['namaAlias'] != null) 'namaAlias': dataInq['namaAlias'],
    };

    final response = await _network.post(
        url: 'eidupay/bpjs/bayarBpjs', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
  }
}
