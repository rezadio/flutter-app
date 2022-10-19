import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/transfer_to_wallet.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_kyc_bottom_sheet.dart';
import 'package:eidupay/extension.dart';

class TransferToWalletController extends GetxController {
  final Network _network;
  TransferToWalletController(this._network);

  var isChecked = false.obs;
  var isNotEnough = false.obs;
  var balance = '0'.obs;
  var savedName = <Favorite>[].obs;

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final mobileController = TextEditingController();
  final messageController = TextEditingController();
  final favoriteController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await getBalance();
    await getFavorite();
  }

  void clear() => mobileController.clear();

  Future<void> getBalance() async {
    final balanceModel = await _network.getBalance();
    balance.value = balanceModel.infoMember.lastBalance;
  }

  Future<DataFavorite> getFavorite() async {
    final response = await _network.getFavorite('93');
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<TransferToWallet> getTransferInq() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'nominal':
          currencyMaskFormatter.magicMask.clearMask(amountController.text),
      'beritaTransfer': messageController.text,
      'remark': messageController.text,
      'idTrx': '3' +
          (_pref.getString(kUid) ?? '') +
          DateFormat('yyMMddHHmmss').format(DateTime.now()),
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'idAccountTujuan': mobileController.text,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/transferP2P/inq', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final bodyToModel = TransferToWallet.fromJson(decodedBody);
      return bodyToModel;
    } catch (e) {
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

  Future<dynamic> pay(TransferToWallet transferToWallet, String pin) async {
    try {
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, dynamic>{
        'idAccount': _pref.getString(kUserId) ?? '',
        'nominal': transferToWallet.total.toString(),
        'beritaTransfer':
            messageController.text.isNotEmpty ? messageController.text : 'null',
        'remark':
            messageController.text.isNotEmpty ? messageController.text : 'null',
        'idTrx': transferToWallet.transId,
        'packageName': _package.packageName,
        'tipe': _pref.getString(kUserType) ?? '',
        'pin': pin,
        'lang': '',
        'idAccountTujuan': mobileController.text,
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode,
        if (isChecked.value == true) 'namaAlias': favoriteController.text,
      };
      final response = await _network.post(
          url: 'eidupay/transferP2P/pay', header: header, body: body);
      final bodyResponse = await response.stream.bytesToString();
      final decryptedBody = _network.decrypt(bodyResponse);
      final decodedBody = jsonDecode(decryptedBody);
      return decodedBody;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> process() async {
    if (formKey.currentState?.validate() == true) {
      EiduLoadingDialog.showLoadingDialog();
      final response = await getTransferInq();
      Get.back();

      final nominal = int.parse(response.nominal.numericOnly()).amountFormat;
      final biayaTransfer =
          int.parse(response.adminFee.numericOnly()).amountFormat;
      final total = response.total.amountFormat;

      await EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Konfirmasi Pembayaran',
        body: _processWidget(
            response: response,
            nominal: nominal,
            biayaTransfer: biayaTransfer,
            total: total),
        color: green,
        secondaryColor: green,
        secondButtonText: 'Transfer',
        secondButtonOnPressed: () async {
          Get.back();
          List<dynamic>? results = await Get.to(
            () => PinVerificationPage<TransferToWalletController>(
                pageController: this),
            arguments: response,
          );

          final bool? isSuccess = results?[0];

          if (isSuccess != null && isSuccess) {
            await Get.toNamed(
              TransactionSuccessPage.route.name,
              arguments: PageArgument(
                title: 'Transfer ke Member',
                ket1: response.receiverName,
                ket2: mobileController.text,
                trxId: response.transId,
                biayaAdmin: 'Rp $biayaTransfer',
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
    required TransferToWallet response,
    required String nominal,
    required String biayaTransfer,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(response.receiverName,
                      style: TextStyle(
                          fontSize: w(16), fontWeight: FontWeight.bold)),
                  Text(mobileController.text,
                      style: TextStyle(
                          fontSize: w(14),
                          fontWeight: FontWeight.w400,
                          color: t80)),
                ],
              )),
          const SizedBox(height: 8),
          CustomSingleRowCard(title: 'Nominal', value: 'Rp $nominal'),
          CustomSingleRowCard(title: 'Biaya Admin', value: 'Rp $biayaTransfer'),
          const SizedBox(
            height: 16,
            child: DashLineDivider(color: Color(0xFFB8B8B8)),
          ),
          CustomSingleRowCard(
              title: 'Total Pembayaran',
              value: 'Rp ' + total,
              valueColor: green,
              valueSize: 18),
        ],
      );

  @override
  void dispose() {
    formKey.currentState?.dispose();
    amountController.dispose();
    mobileController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
