import 'dart:convert';

import 'package:eidupay/extension.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/swiff.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwiffPaymentController extends GetxController {
  final Network _network;
  SwiffPaymentController(this._network);

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  String idTrx = '';
  var balance = '0'.obs;
  var isNotEnough = false.obs;
  var isParentAccount = true.obs;

  @override
  void onInit() async {
    super.onInit();
    isParentAccount.value = checkAccountType();
    await getBalance();
  }

  bool checkAccountType() => dtUser['tipe'] == 'member' ? true : false;

  Future<void> getBalance() async {
    final balanceModel = await _network.getBalance();
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

  Future<dynamic> pay(SwiffInquiry inquiry, String pin) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    idTrx = '3' +
        (_pref.getString(kUid) ?? '') +
        DateFormat('yyMMddHHmmss').format(DateTime.now());

    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'payCode': inquiry.merchantCode,
      'merchantCode': inquiry.merchantCode,
      'berita': '',
      'idTrx': idTrx,
      'namaToko': inquiry.nama,
      'nominalBelanja': inquiry.nominalBelanja,
      'fee': inquiry.biaya,
      'total': inquiry.total,
      'idAgentTujuan': inquiry.merchantCode,
      'pin': pin,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'packageName': _package.packageName,
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/belanja/payMerchantSwiff', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    // String decryptedBody =
    //     '{"ACK":"OK","pesan":"Pembayaran Ke A sebesar Rp. 12.000,00"}';
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> process({required SwiffInquiry inquiry}) async {
    if (int.parse(amountController.text.numericOnly()) >
        int.parse(balance.value.numericOnly())) {
      await EiduInfoDialog.showInfoDialog(title: 'Saldo Tidak Cukup!');
      return;
    }
    List<dynamic>? results = await Get.to(
      () => PinVerificationPage<SwiffPaymentController>(pageController: this),
      arguments: inquiry,
    );

    final bool? isSuccess = results?[0];
    final response = results?[1];

    if (isSuccess != null && isSuccess) {
      final biayaAdmin =
          int.parse(inquiry.total) - int.parse(inquiry.nominalBelanja);
      final nominal = int.parse(inquiry.nominalBelanja).amountFormat;
      final total = int.parse(inquiry.total).amountFormat;
      late String title;
      if (response['ACK'] == 'OK') {
        title = 'Pembayaran Sukses!';
      } else if (response['ACK'] == 'PENDING') {
        title = 'Transaksi sedang dalam proses';
      } else {
        title = 'Pembayaran';
      }
      await Get.toNamed(
        TransactionSuccessPage.route.name,
        arguments: PageArgument(
          title: title,
          ket1: 'Nama Merchant : ' + inquiry.nama,
          ket2: 'Kode Merchant : ' + inquiry.merchantCode,
          trxId: idTrx,
          biayaAdmin: 'Rp $biayaAdmin',
          nominal: 'Rp $nominal',
          total: 'Rp $total',
        ),
      );

    }
  }
}
