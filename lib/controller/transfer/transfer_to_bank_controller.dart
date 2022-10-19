import 'dart:convert';
import 'dart:math';

import 'package:eidupay/model/bank.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/transfer_to_bank.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_kyc_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/extension.dart';

class TransferToBankController extends GetxController {
  final Network _network;
  TransferToBankController(this._network);

  var isChecked = false.obs;
  var isNotEnough = false.obs;
  var balance = '0'.obs;
  var bankLists = <String>[].obs;
  var bankName = ''.obs;
  var idTipeTransaksi = '6'.obs;
  var savedName = <Favorite>[].obs;

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final accountNumberController = TextEditingController();
  final nameController = TextEditingController();
  final noteController = TextEditingController();
  final favoriteController = TextEditingController();
  final random = Random();
  var listBank = <DataBank>[].obs;
  var  selectedBank ;
  @override
  void onInit() async {
    super.onInit();
    await getBank('bank');
    await getBalance();
    await getFavorite();
  }

  void clear() => accountNumberController.clear();

  Future<void> getBalance() async {
    final balanceModel = await _network.getBalance();
    balance.value = balanceModel.infoMember.lastBalance;
  }

  Future<List<DataBank>> getBank(String bankName) async {
    try {
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, String>{
        'idAccount': _pref.getString(kUserId) ?? '',
        'search': bankName,
        'packageName': _package.packageName,
        'tipe': _pref.getString(kUserType) ?? '',
        'lang': '',
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode
      };
      final response = await _network.post(
          url: 'eidupay/transfer/getBank', header: header, body: body);
      final bodyResponse = await response.stream.bytesToString();
      final decryptedBody = _network.decrypt(bodyResponse);
      final decodedBody = jsonDecode(decryptedBody);
      final bodyToModel = Bank.fromJson(decodedBody);
      listBank.value = bodyToModel.dataBank;
      return bodyToModel.dataBank;
    } catch (e) {
      rethrow;
    }
  }

  Future<DataFavorite> getFavorite() async {
    final response = await _network.getFavorite(idTipeTransaksi.value);
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<TransferToBank> getInq() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    String idTrx = '';
    for (int i = 0; i < 8; i++) {
      idTrx += random.nextInt(10).toString();
    }
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'bankTujuan': bankName.value,
      'nominal':
          currencyMaskFormatter.magicMask.clearMask(amountController.text),
      'noRek': accountNumberController.text,
      'beritaTransfer': noteController.text,
      'remark': noteController.text,
      'idTrx': idTrx,
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'simpanDenganNama': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/transfer/inquiryBank', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final bodyToModel = TransferToBank.fromJson(decodedBody);
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

  Future<dynamic> pay(TransferToBank transferToBank, String pin) async {
    try {
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, String>{
        'idTipeTransaksi': idTipeTransaksi.value,
        'bankTujuan': transferToBank.namaBank,
        'nominal': transferToBank.nominalTransfer,
        'noRek': transferToBank.nomorRekeningTujuan,
        'beritaTransfer': transferToBank.remark1,
        'remark': transferToBank.remark1,
        'idTrx': transferToBank.trxId,
        'pin': pin,
        'idAccount': _pref.getString(kUserId) ?? '',
        'lang': '',
        'tipe': _pref.getString(kUserType) ?? '',
        'packageName': _package.packageName,
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode,
        if (isChecked.value == true) 'namaAlias': favoriteController.text,
      };
      final response = await _network.post(
          url: 'eidupay/transfer/transferBank', header: header, body: body);
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
      final response = await getInq();
      Get.back();

      final nominal =
          int.parse(response.nominalTransfer.numericOnly()).amountFormat;
      final biayaTransfer =
          int.parse(response.biayaTransferBank.numericOnly()).amountFormat;
      final total = (num.parse(response.nominalTransfer.numericOnly()) +
              num.parse(response.biayaTransferBank.numericOnly()))
          .amountFormat;

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
            () => PinVerificationPage<TransferToBankController>(
                pageController: this),
            arguments: response,
          );

          final bool? isSuccess = results?[0];

          if (isSuccess != null && isSuccess) {
            await Get.toNamed(
              TransactionSuccessPage.route.name,
              arguments: PageArgument(
                title: 'Transfer ke Bank',
                ket1: response.namaTujuan,
                ket2: '${response.namaBank} - ${response.nomorRekeningTujuan}',
                trxId: response.trxId,
                biayaAdmin: biayaTransfer,
                nominal: nominal,
                total: 'Rp $total',
              ),
            )?.then((value) => getBalance());
          }
        },
      );
    }
  }

  Widget _processWidget({
    required TransferToBank response,
    required String nominal,
    required String biayaTransfer,
    required String total,
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
              Text(response.namaTujuan,
                  style:
                      TextStyle(fontSize: w(16), fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(
                    response.namaBank,
                    style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.w400,
                        color: t80),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    response.nomorRekeningTujuan,
                    style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.w400,
                        color: t80),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CustomSingleRowCard(title: 'Nominal', value: 'Rp $nominal'),
        CustomSingleRowCard(
            title: 'Biaya Transfer Bank', value: 'Rp $biayaTransfer'),
        const SizedBox(
          height: 16,
          child: DashLineDivider(color: Color(0xFFB8B8B8)),
        ),
        CustomSingleRowCard(
            title: 'Total Pembayaran',
            value: 'Rp $total',
            valueColor: green,
            valueSize: 18),
      ]);

  @override
  void dispose() {
    formKey.currentState?.dispose();
    amountController.dispose();
    accountNumberController.dispose();
    nameController.dispose();
    noteController.dispose();
    super.dispose();
  }
}
