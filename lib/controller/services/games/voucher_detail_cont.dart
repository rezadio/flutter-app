import 'dart:convert';

import 'package:eidupay/extension.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/game.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoucherDetailCont extends GetxController {
  final Network _network;
  VoucherDetailCont(this._network);

  var cookie;
  var uid;
  var balance = '0'.obs;
  late VoucherDetail voucherDetail;
  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

    await getBalance();
    await getCookie();
    await getUid();
  }

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
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

  Future<VoucherInquiry> getInqVoucher(VoucherDenom denom) async {
    final type = dtUser['tipe'];
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'voucherCode': denom.denominationCode,
      'voucherName': denom.denominationName,
      'idTrx': '3' + timeStr,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'amount': denom.denominationAmount
          .substring(0, denom.denominationAmount.length - 3)
    };
    final response = await _network.post(
        url: 'eidupay/game/inquiryVoucher', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = VoucherInquiry.fromJson(decodedBody);
      return model;
    } catch (_) {
      final model = DefaultModel.fromJson(decodedBody);
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: model.pesan);
      rethrow;
    }
  }

  Future<dynamic> pay(VoucherInquiry resInqVoucher, String pin) async {
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idTrx': resInqVoucher.idTrx,
      'pin': pin,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'idAccount': dtUser['idAccount'],
    };
    final response = await _network.post(
        url: 'eidupay/game/paymentVoucher', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> voucherDetaiTap(VoucherDenom denom) async {
    EiduLoadingDialog.showLoadingDialog();
    final resInqVoucher = await getInqVoucher(denom);
    Get.back();

    final bayar = await EiduConfirmationBottomSheet.showBottomSheet(
      title: 'Konfirmasi',
      body: confirm(resInqVoucher),
      secondButtonText: 'Bayar',
      secondaryColor: green,
      firstButtonOnPressed: () {
        Get.back(result: false);
      },
      secondButtonOnPressed: () {
        final infoExtended = balanceModel.infoExtended;
        final dailyLimit =
            int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
        if (infoExtended != null && dailyLimit != 0) {
          final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
              ? int.parse(infoExtended.extDailyUsed.numericOnly())
              : 0;
          if (dailyUsed + int.parse(resInqVoucher.total.numericOnly()) >
              dailyLimit) {
            EiduInfoDialog.showInfoDialog(
                title: 'Daily limit sudah mencapai batas!');
            return;
          }
        }
        Get.back(result: true);
      },
    );
    if (bayar) {
      final int lastBalance = int.parse(balance.value.numericOnly());
      const hrg = 2000000; //int.parse(resInqVoucher['total']);
      if (lastBalance < hrg) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Saldo tidak mencukupi!');
        return;
      }
      List<dynamic>? results = await Get.to(
        () => PinVerificationPage<VoucherDetailCont>(pageController: this),
        arguments: resInqVoucher,
      );

      final bool? isSuccess = results?[0];
      final resPaymentVoucher = results?[1];

      if (isSuccess != null && isSuccess) {
        await Get.offAllNamed(TransactionSuccessPage.route.name,
            arguments: PageArgument(
              title: '',
              description: resPaymentVoucher['pesan'],
              nominal: (int.parse(resInqVoucher.amount)).amountFormat,
              total: (int.parse(resInqVoucher.total)).amountFormat,
              ket1: 'Voucher : ' + resInqVoucher.voucherName,
              ket2: 'Jenis : ' + resInqVoucher.voucherName,
              trxId: resInqVoucher.idTrx,
              biayaAdmin: (int.parse(resInqVoucher.biaya)).amountFormat,
            ));
      }
    }
  }

  Widget confirm(VoucherInquiry inquiry) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inquiry.voucherName,
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.w400, color: t100),
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
                inquiry.voucherName,
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.w400, color: t70),
              ),
            ],
          ),
        ),
        SizedBox(height: w(20)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nominal',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + (int.parse(inquiry.amount)).amountFormat,
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
                'Biaya Admin',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + (int.parse(inquiry.biaya)).amountFormat,
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
                'Rp. ' + (int.parse(inquiry.total)).amountFormat,
                style: TextStyle(
                    fontSize: w(18), fontWeight: FontWeight.w400, color: green),
              ),
            ],
          ),
        )
      ],
    );
  }
}
