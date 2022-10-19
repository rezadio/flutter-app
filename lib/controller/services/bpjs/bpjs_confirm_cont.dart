import 'dart:convert';

import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/bpjs.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/extension.dart';

class BPJSConfirmCont extends GetxController {
  final Network _network;
  BPJSConfirmCont(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  var remember = false.obs;
  var balance = '0'.obs;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
    await getBalance();
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

  Future<dynamic> pay(BPJS bpjs, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'idTrx': bpjs.idTrx,
      'idPelanggan': bpjs.idPelanggan,
      'packageName': _package.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'pin': pin,
      'versionCode': versionCode,
      if (bpjs.namaAlias != 'null') 'namaAlias': bpjs.namaAlias,
    };

    final response = await _network.post(
        url: 'eidupay/bpjs/bayarBpjs', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> continueTap(BPJS response) async {
    if (num.parse(balance.value.numericOnly()) <
        num.parse(response.hargaCetak.numericOnly())) {
      await EiduInfoDialog.showInfoDialog(title: 'Saldo anda tidak cukup');
      return;
    }
    final infoExtended = balanceModel.infoExtended;
    final dailyLimit =
        int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
    if (infoExtended != null && dailyLimit != 0) {
      final hargaCetak = int.parse(response.hargaCetak.numericOnly());
      final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
          ? int.parse(infoExtended.extDailyUsed.numericOnly())
          : 0;
      if (dailyUsed + hargaCetak > dailyLimit) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Daily limit sudah mencapai batas!');
        return;
      }
    }
    await EiduConfirmationBottomSheet.showBottomSheet(
        iconUrl: 'assets/images/logo_bpjs.png',
        title: 'BPJS Kesehatan',
        body: _confirmWidget(response),
        color: green,
        secondaryColor: green,
        secondButtonText: 'Bayar',
        secondButtonOnPressed: () async {
          Get.back();
          List<dynamic>? results = await Get.to(
            () => PinVerificationPage<BPJSConfirmCont>(pageController: this),
            arguments: response,
          );
          final bool? isSuccess = results?[0];
          if (isSuccess != null && isSuccess) {
            await Get.toNamed(
              TransactionSuccessPage.route.name,
              arguments: PageArgument(
                title: 'Pembayaran BPJS berhasil',
                ket1: response.nama,
                ket2: response.idPelanggan,
                trxId: response.idTrx,
                biayaAdmin: 'Rp ${response.biayaAdmin}',
                nominal: 'Rp ${response.tagihan}',
                total: 'Rp ${response.hargaCetak}',
              ),
            )?.then((value) => getBalance());
          }
        });
  }

  Widget _confirmWidget(BPJS response) {
    final idPelanggan = response.idPelanggan;
    return Column(
      children: [
        Text(response.nama,
            style: TextStyle(
                fontSize: w(12), fontWeight: FontWeight.w400, color: t100)),
        if (idPelanggan != null)
          Text(idPelanggan,
              style: TextStyle(
                  fontSize: w(12), fontWeight: FontWeight.w400, color: t100)),
        SizedBox(height: w(33)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nominal',
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t70)),
              Text('Rp. ${response.tagihan}',
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t100)),
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
              Text('Biaya Admin',
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t70)),
              Text('Rp. ${response.biayaAdmin}',
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t100)),
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
              Text('Total Pembayaran',
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t70)),
              Text('Rp. ${response.hargaCetak}',
                  style: TextStyle(
                      fontSize: w(18),
                      fontWeight: FontWeight.w400,
                      color: green)),
            ],
          ),
        ),
      ],
    );
  }
}
