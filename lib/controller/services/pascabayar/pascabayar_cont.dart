import 'dart:convert';

import 'package:eidupay/controller/services/util/string_utils.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/extension.dart';

class PascabayarCont extends GetxController {
  final Network _network;
  PascabayarCont(this._network);

  final contNoHp = TextEditingController();
  final favoriteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  var cookie;
  var uid;
  var idMenu;
  var balance = '0'.obs;
  var isChecked = false.obs;
  var savedName = <Favorite>[].obs;
  var inProgress = false.obs;
  var recentTrx = <DataLastTrx>[].obs;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

    inProgress(true);
    contNoHp.text = dtUser['hp'] ?? '';
    await getUid();
    await getCookie();
    await getFavorite(idMenu);
    await getRecentTrx(idMenu);
    await getBalance();
    inProgress(false);
  }

  void clear() => contNoHp.clear();

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
    debugPrint('xxx : ' + cookie);
  }

  Future<void> getUid() async {
    uid = _pref.getString(kUid) ?? '';
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

  Future<dynamic> getInq() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': '3' + uid + timeStr,
      'idPelanggan': contNoHp.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/pascabayar/inquiry', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(dynamic inquiry, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': inquiry['idTrx'],
      'idPelanggan': contNoHp.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode,
      'pin': pin,
      if (isChecked.value == true) 'namaAlias': contNoHp.text,
    };

    final response = await _network.post(
        url: 'eidupay/pascabayar/payment', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<DataFavorite> getFavorite(String idTipeTransaksi) async {
    final response = await _network.getFavorite(idTipeTransaksi);
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<void> getRecentTrx(String idMenu) async {
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

  Future<void> continueTap(String noHp) async {
        if (isChecked.value) {
      if (favoriteController.text.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Nama Favorit belum di isi');
        return;
      }
    }
    if (formKey.currentState!.validate()) {
      EiduLoadingDialog.showLoadingDialog();
      final inquiryResponse = await getInq();
      Get.back();

      if (inquiryResponse['ACK'] == 'NOK') {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay',  description:
                StringUtils.stringToErrorMessage(inquiryResponse['pesan']));
        return;
      }

      if (inquiryResponse['ACK'] == 'OK') {
        var bayar = await showCupertinoModalPopup(
            context: navigatorKey.currentContext!,
            builder: (_) => confirm(inquiryResponse, noHp));
        if (bayar) {
          List<dynamic>? results = await Get.to(
            () => PinVerificationPage<PascabayarCont>(pageController: this),
            arguments: inquiryResponse,
          );

          final bool? isSuccess = results?[0];
          final resBayar = results?[1];

          if (isSuccess != null && isSuccess) {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan Pascabayar',
                    description: 'Pembayaran Tagihan Pascabayar Berhasil!',
                    nominal: inquiryResponse['tagihan'],
                    total: inquiryResponse['hargaCetak'],
                    ket1: 'Pembayaran pascabayar',
                    ket2: 'No : ' + contNoHp.text,
                    biayaAdmin: inquiryResponse['biayaBayar'],
                    trxId: inquiryResponse['trxId']));
          }
        }
      }
    }
  }

  Widget confirm(inquiryResponse, String noHp) {
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No Handphone',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                noHp,
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
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
                'Rp. ' + inquiryResponse['tagihan'],
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
                'Rp. ' + inquiryResponse['biayaBayar'],
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
                'Rp. ' + inquiryResponse['hargaCetak'],
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
              final harga = int.parse(
                  inquiryResponse['hargaCetak'].toString().numericOnly());
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
    ));
  }
}
