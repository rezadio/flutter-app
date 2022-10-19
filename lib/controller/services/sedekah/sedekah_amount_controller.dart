import 'dart:convert';

import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/sedekah.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/extension.dart';

class SedekahAmountController extends GetxController {
  final Network _network;
  SedekahAmountController(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
    await getBalance();
  }

  var idTrx = ''.obs;
  var balance = '0'.obs;

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

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

  Future<dynamic> donasiInq(DataSedekah dataSedekah) async {
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'lembaga': dataSedekah.merchantName,
      'typeSedekah': dataSedekah.programName,
      'nominalSedekah':
          currencyMaskFormatter.magicMask.clearMask(amountController.text),
      'packageName': _package.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'programId': dataSedekah.programId,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/donasi/donasiInq', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(DataSedekah dataSedekah, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    idTrx.value = '3' +
        (_pref.getString(kUid) ?? '') +
        DateFormat('yyMMddHHmmss').format(DateTime.now());
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'programId': dataSedekah.programId,
      'merchantCode': dataSedekah.merchantPhone,
      'lembaga': dataSedekah.merchantName,
      'typeSedekah': dataSedekah.programName,
      'idTrx': idTrx.value,
      'nominalSedekah':
          currencyMaskFormatter.magicMask.clearMask(amountController.text),
      'packageName': _package.packageName,
      'pin': pin,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/donasi/donasiPay', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> process({required DataSedekah dataSedekah}) async {
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

        EiduLoadingDialog.showLoadingDialog();
        final response = await donasiInq(dataSedekah);
        Get.back();
        if (response['ACK'] == 'NOK') {
          await EiduInfoDialog.showInfoDialog(title: response['pesan']);
          return;
        }
        await EiduConfirmationBottomSheet.showBottomSheet(
          title: 'Konfirmasi Sedekah',
          body: _processWidget(dataSedekah: dataSedekah),
          color: green,
          secondaryColor: green,
          secondButtonText: 'Bayar',
          secondButtonOnPressed: () async {
            Get.back();
            List<dynamic>? results = await Get.to(
              () => PinVerificationPage<SedekahAmountController>(
                  pageController: this),
              arguments: dataSedekah,
            );

            final bool? isSuccess = results?[0];

            if (isSuccess != null && isSuccess) {
              await Get.toNamed(
                TransactionSuccessPage.route.name,
                arguments: PageArgument(
                  title: 'Sedekah',
                  ket1: dataSedekah.merchantName,
                  ket2: dataSedekah.programName,
                  trxId: idTrx.value,
                  nominal: amountController.text,
                  total: 'Rp ${amountController.text}',
                ),
              );
            }
          },
        );
      }
    }
  }

  Widget _processWidget({
    required DataSedekah dataSedekah,
  }) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.all(8),
            height: 58,
            decoration: const BoxDecoration(
                color: Color(0xFFFCFBFC),
                borderRadius: BorderRadius.all(Radius.circular(14))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dataSedekah.merchantName,
                    style: TextStyle(
                        fontSize: w(16), fontWeight: FontWeight.bold)),
                Text(dataSedekah.programName ?? '',
                    style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.w400,
                        color: t80)),
              ],
            )),
        const SizedBox(height: 8),
        CustomSingleRowCard(
            title: 'Nominal Sedekah', value: 'Rp ${amountController.text}'),
        const CustomSingleRowCard(title: 'Biaya Admin', value: 'Rp 0'),
        const SizedBox(
          height: 16,
          child: DashLineDivider(color: Color(0xFFB8B8B8)),
        ),
        CustomSingleRowCard(
            title: 'Total Pembayaran',
            value: 'Rp ' + amountController.text,
            valueColor: green,
            valueSize: 18),
      ]);
}
