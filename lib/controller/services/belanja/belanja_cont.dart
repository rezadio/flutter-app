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
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';

class BelanjaCont extends GetxController {
  final Network _network;
  BelanjaCont(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  final contKodeMerchant = TextEditingController();
  final contNominal = TextEditingController();
  final contBerita = TextEditingController();

  final contInfo = TextEditingController();
  final contPenyedia = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final refreshController = RefreshController();
  final favoriteController = TextEditingController();

  var favorite = false.obs;
  var nom = 0.obs;
  var idBiller = ''.obs;
  var infoSamsat = ''.obs;
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
  var listProductEsamsat;
  var recentTrx = <DataLastTrx>[].obs;
  var balance = '0'.obs;
  var idTrx = '';
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

  void clearKodeMerchant() => contKodeMerchant.clear();
  void clearNominal() => contNominal.clear();
  void clearKeterangan() => contBerita.clear();

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

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    uid = _pref.getString(kUid) ?? '';
  }

  Future<dynamic> getInqBelanja() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    idTrx = '3' + uid + timeStr;
    final body = <String, String>{
      'idAgentTujuan': StringUtils.stringToFixPhoneNumber(contKodeMerchant.text),
      'nominal': contNominal.text,
      'idTrx': idTrx,
      'berita': contBerita.text,
      'idAccount': dtUser['idAccount'],
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/belanja/belanjaInq', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

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

  Future<void> continueTap() async {
    if (formKey.currentState!.validate()) {
      if (idBiller.value != null) {
        await _belanja();
      }
    }
  }

  Future<dynamic> getPayBelanja(dataInq, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': idTrx,
      'idAgentTujuan': StringUtils.stringToFixPhoneNumber(contKodeMerchant.text),
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
        url: 'eidupay/belanja/belanjaPay', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(inquiry, String pin) async {
    print('object');
    return await getPayBelanja(inquiry[1], pin);
  }

  Future<void> _belanja() async {
    EiduLoadingDialog.showLoadingDialog();
    var inquiryResponse = await getInqBelanja();
    Get.back();

    if (inquiryResponse['ack'] == 'NOK') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay',
          description:
              StringUtils.stringToErrorMessage(inquiryResponse['pesan']));
      return;
    }

    if (inquiryResponse['ack'] == 'OK') {
      hargaCetak.value = inquiryResponse['total']!;
      biayaAdmin.value = inquiryResponse['biaya']!;
      var bayar = await showCupertinoModalPopup(
          context: navigatorKey.currentContext!,
          builder: (_) => confirmBelanja(inquiryResponse));
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<BelanjaCont>(pageController: this),
          arguments: [idBiller.value, inquiryResponse],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          if (payResponse['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Pembayaran Merchant',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: 'Rp. ' + contNominal.text,
                    total: 'Rp. ' + hargaCetak.value,
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    ket1: 'Nama Merchant : ' + inquiryResponse['nama'],
                    ket2: 'Nomor Merchant : ' +
                        inquiryResponse['merchantCode'],
                     ket3: 'Berita : ' + inquiryResponse['berita'],
                    trxId: idTrx));
          } else if (payResponse['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Pembayaran Merchant',
                    description: 'Pembayaran merchant Berhasil!',
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    nominal: 'Rp. ' + contNominal.text,
                    total: 'Rp. ' + hargaCetak.value,
                    ket1: 'Nama Merchant : ' + inquiryResponse['nama'],
                    ket2: 'Nomor Merchant : ' +
                        inquiryResponse['merchantCode'],
                    ket3: 'Berita : ' + inquiryResponse['berita'],
                    trxId: idTrx));
          }
        }
      }
    }
  }

  Widget confirmBelanja(data) {
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
              'Informasi Merchant',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode Merchant',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['merchantCode'],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Merchant',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['nama'],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keterangan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Expanded(
                child: Text(
                  data['berita'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: w(13), fontWeight: FontWeight.w700, color: t90),
                ),
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
        SizedBox(height: w(33)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tagihan anda',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                StringUtils.stringToIdr(data['nominalBelanja']),
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya admin',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                StringUtils.stringToIdr(data['biaya']),
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
                'Total',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                StringUtils.stringToIdr(data['total']),
                style: TextStyle(
                    fontSize: w(18), fontWeight: FontWeight.w400, color: green),
              ),
            ],
          ),
        ),
        SizedBox(height: w(35)),
        SubmitButton(
            backgroundColor: green,
            text: 'Bayar',
            onPressed: () async {
              final infoExtended = balanceModel.infoExtended;
              final dailyLimit =
                  int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
              final harga = int.parse(data['total'].toString().numericOnly());
              final saldo = int.parse(balance.value.toString().numericOnly());
              if (saldo < harga) {
                await EiduInfoDialog.showInfoDialog(
                    title: 'Eidupay', description: 'Saldo tidak mencukupi!');
                return;
              }

              if (infoExtended != null && dailyLimit != 0) {
                final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
                    ? int.parse(infoExtended.extDailyUsed.numericOnly())
                    : 0;

                if (dailyUsed + harga > dailyLimit) {
                  await EiduInfoDialog.showInfoDialog(
                      title: 'Daily limit sudah mencapai batas!');
                  return;
                }
              }
              Get.back(result: true);
            }),
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
}
