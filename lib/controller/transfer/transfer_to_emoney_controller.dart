import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/e_money.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/extension.dart';

class TransferToEMoneyController extends GetxController {
  final Network _network;
  TransferToEMoneyController(this._network);

  var isChecked = false.obs;
  var isNotEnough = false.obs;
  var balance = '0'.obs;
  var operator = <Operator>[].obs;
  var operatorId = '0'.obs;
  var tappedId = <int>[].obs;
  var denoms = <DataDenom>[].obs;
  var denomSelected = <DataDenom>[].obs;
  var isDenomSelected = false.obs;
  String idTrx = '';

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await getBalance();
    await getEMoney();
  }

  Future<void> getBalance() async {
    final balanceModel = await _network.getBalance();
    balance.value = balanceModel.infoMember.lastBalance;
  }
  void clear() => phoneController.clear();
  Future<EMoney> getEMoney() async {
    try {
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, String>{
        'idAccount': _pref.getString(kUserId) ?? '',
        'tipeOperator': 'emoney',
        'packageName': _package.packageName,
        'tipe': _pref.getString(kUserType) ?? '',
        'lang': '',
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode
      };
      final response = await _network.post(
          url: 'eidupay/emoney/getListEmoney', header: header, body: body);
      final bodyResponse = await response.stream.bytesToString();
      final decryptedBody = _network.decrypt(bodyResponse);
      final decodedBody = jsonDecode(decryptedBody);
      final model = EMoney.fromJson(decodedBody);
      operator.assignAll(model.listEmoney);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<EMoneyDenom> getDenom() async {
    try {
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, String>{
        'idAccount': _pref.getString(kUserId) ?? '',
        'idOperator': operatorId.value,
        'packageName': _package.packageName,
        'tipe': _pref.getString(kUserType) ?? '',
        'lang': '',
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode
      };
      final response = await _network.post(
          url: 'eidupay/emoney/getDenom', header: header, body: body);
      final bodyResponse = await response.stream.bytesToString();
      final decryptedBody = _network.decrypt(bodyResponse);
      final decodedBody = jsonDecode(decryptedBody);
      final model = EMoneyDenom.fromJson(decodedBody);
      denoms.assignAll(model.dataDenom);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> pay(DataDenom denom, String pin) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    idTrx = '3' +
        DateFormat('yyMMddHHmmss').format(DateTime.now()) +
        (_pref.getString(kUid) ?? '');
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'idOperator': operatorId.value,
      'idTrx': idTrx,
      'idDenom': denom.idDenom,
      'nominal': denom.nominal,
      'idSupplier': denom.idSupplier,
      'hargaCetak': denom.hargaCetak,
      'noHp': phoneController.text,
      'namaOperator': denom.namaOperator,
      'pin': pin,
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/emoney/getPayEmoney', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  String getImage(String name) {
    if (name == 'ShopeePay') return 'assets/images/logo_shopee_pay.png';
    if (name == 'GoPay') return 'assets/images/logo_gopay.png';
    if (name == 'OVO') return 'assets/images/logo_ovo.png';
    if (name == 'DANA') return 'assets/images/logo_dana.png';
    if (name == 'LinkAja') return 'assets/images/logo_linkaja.png';
    if (name == 'Gopay Driver') return 'assets/images/logo_gopay_driver.png';
    return '';
  }

  Future<void> process() async {
    if (formKey.currentState?.validate() == true &&
        isDenomSelected.value == true) {
      final denom = denomSelected.first;
      if (num.parse(balance.value.numericOnly()) <
          num.parse(denom.hargaCetak.numericOnly())) {
        await EiduInfoDialog.showInfoDialog(title: 'Saldo tidak cukup');
        return;
      }

      final nominal = int.parse(denom.nominal.numericOnly()).amountFormat;
      const biayaAdmin = '2,500';
      final total = int.parse(denom.hargaCetak.numericOnly()).amountFormat;

      await EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Konfirmasi Pembayaran',
        body: _processWidget(
            denom: denom,
            nominal: nominal,
            biayaAdmin: biayaAdmin,
            total: total),
        color: green,
        secondaryColor: green,
        secondButtonText: 'Transfer',
        secondButtonOnPressed: () async {
          Get.back();
          List<dynamic>? results = await Get.to(
            () => PinVerificationPage<TransferToEMoneyController>(
                pageController: this),
            arguments: denom,
          );
          final bool? isSuccess = results?[0];

          if (isSuccess != null && isSuccess) {
            await Get.toNamed(
              TransactionSuccessPage.route.name,
              arguments: PageArgument(
                title: 'Transfer ke e-Money',
                ket1: denom.namaOperator,
                ket2: phoneController.text,
                trxId: idTrx,
                biayaAdmin: 'Rp $biayaAdmin',
                nominal: 'Rp $nominal',
                total: 'Rp $total',
              ),
            )?.then((value) => getBalance());
          }
        },
      );
    }
  }

  Widget _processWidget({
    required DataDenom denom,
    required String nominal,
    required String biayaAdmin,
    required String total,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 58,
            decoration: const BoxDecoration(
                color: Color(0xFFFCFBFC),
                borderRadius: BorderRadius.all(Radius.circular(14))),
            child: Row(
              children: [
                Text(
                  denom.namaOperator,
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w400, color: t80),
                ),
                const SizedBox(width: 5),
                Text(
                  phoneController.text,
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w400, color: t80),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          CustomSingleRowCard(title: 'Nominal', value: 'Rp $nominal'),
          CustomSingleRowCard(title: 'Biaya Transfer', value: 'Rp $biayaAdmin'),
          const SizedBox(
            height: 16,
            child: DashLineDivider(color: Color(0xFFB8B8B8)),
          ),
          CustomSingleRowCard(
              title: 'Total Pembayaran',
              value: 'Rp $total',
              valueColor: green,
              valueSize: 18),
        ],
      );
}
