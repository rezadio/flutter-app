import 'dart:convert';

import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/inquiry_tabungan.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/extension.dart';

class TitipanConfirmationController extends GetxController {
  final Network _network;
  TitipanConfirmationController(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  var balance = '0'.obs;
  var isNotEnough = false.obs;

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

  Future<dynamic> pay(InquiryTabungan inquiryTabungan, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'pin': pin,
      'idTrx': '3' +
          DateFormat('yyMMddHHmmss').format(DateTime.now()) +
          (_pref.getString(kUid) ?? ''),
      'payerNumber': inquiryTabungan.dataListCategory.payerNumber,
      'tagihan': amountController.text,
      'totalEduBeli': amountController.text.replaceAll(',', ''),
      'totalEduJual': amountController.text.replaceAll(',', ''),
      'reffNum': inquiryTabungan.dataListCategory.reffNum,
      'hargaJual': inquiryTabungan.hargaJual.toString(),
      'hargaBeli': inquiryTabungan.hargaBeli.toString(),
      'customerNumber': inquiryTabungan.dataListCategory.customerNumber,
      'customerName': inquiryTabungan.dataListCategory.customerName,
      'merchantPhone': inquiryTabungan.dataListCategory.merchantPhone,
      'merchantName': inquiryTabungan.dataListCategory.merchantName,
      'kelas': inquiryTabungan.dataListCategory.kelas,
      'packageName': _package.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getPaymentTabungan',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> process(InquiryTabungan inquiryTabungan) async {
    final isBalanceEnough = int.parse(balance.value.numericOnly()) >
        int.parse(amountController.text.numericOnly());
    if (!isBalanceEnough) {
      await EiduInfoDialog.showInfoDialog(title: 'Saldo anda tidak cukup');
    } else {
      if (formKey.currentState?.validate() == true) {
        final infoExtended = balanceModel.infoExtended;
        final dailyLimit =
            int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');

        if (infoExtended != null && dailyLimit != 0) {
          final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
              ? int.parse(infoExtended.extDailyUsed.numericOnly())
              : 0;
          final harga = int.parse(amountController.text.numericOnly());
          if (dailyUsed + harga > dailyLimit) {
            await EiduInfoDialog.showInfoDialog(
                title: 'Daily limit sudah mencapai batas!');
            return;
          }
        }

        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<TitipanConfirmationController>(
              pageController: this),
          arguments: inquiryTabungan,
        );

        final bool? isSuccess = results?[0];
        final response = results?[1];
        final model = DefaultModel.fromJson(response);

        if (isSuccess != null && isSuccess) {
          if (model.ack != 'OK') {
            await EiduInfoDialog.showInfoDialog(title: model.pesan);
          } else {
            await EiduInfoDialog.showInfoDialog(
                title: model.pesan, icon: 'assets/lottie/success.json');
          }
        }
      }
    }
  }
}
