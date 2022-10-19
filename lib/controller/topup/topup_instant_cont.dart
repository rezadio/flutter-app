import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/direct_debit.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/otp_page.dart';
import 'package:eidupay/view/topup/add_new_card.dart';
import 'package:eidupay/view/topup/manage_card.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopupInstantCont extends GetxController {
  final Network _network;
  TopupInstantCont(this._network);

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  Map<String, dynamic> listMerchant = {};
  var selectedDebitCard = <String, dynamic>{}.obs;
  var balance = 'NA'.obs;
  var isNotEnough = false.obs;
  var cardNum = '-'.obs;
  var isCardSelected = false.obs;
  var cardList = <DebitCardData>[].obs;
  late DebitCardData selectedCard;

  @override
  void onInit() async {
    super.onInit();
    balance.value = await getBalance();
    await _getCard();
  }

  Future<String> getBalance() async {
    final balanceModel = await _network.getBalance();
    balance.value = balanceModel.infoMember.lastBalance;
    return balance.value;
  }

  Future<void> _getCard() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getCard', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = DebitCard.fromJson(decodedBody);
      cardList.assignAll(model.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<DirectDebitInitData> initialization(DebitCardData card) async {
    final _pref = await SharedPreferences.getInstance();
    const fatSecretRestUrl =
        'http://45.64.96.45:6263/prismalink/initialization';
    final trxId = '3' +
        (_pref.getString(kUid) ?? '') +
        DateFormat('yyMMddHHmmss').format(DateTime.now());
    final body = <String, dynamic>{
      'merchant_ref_no': trxId,
      'user_id': _pref.getString(kUserId) ?? '',
      'user_contact': _pref.getString(kUserId) ?? '',
      'user_email': accountData['Email'],
      'debit_card_no': card.cardNum,
      'card_exp_date': card.expiredDate.replaceRange(2, 4, ''),
      'transaction_amount':
          currencyMaskFormatter.magicMask.clearMask(amountController.text)
    };
    final response =
        await http.post(Uri.parse(fatSecretRestUrl), body: jsonEncode(body));
    final decodedBody = jsonDecode(response.body);
    try {
      final model = DirectDebitInit.fromJson(decodedBody);
      final data = DirectDebitInitData.fromJson(jsonDecode(model.data));
      return data;
    } catch (e) {
      final model = DefaultModel.fromJson(decodedBody);
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: model.pesan);
      rethrow;
    }
  }

  Future<dynamic> dd(DirectDebitInitData data, String otp) async {
    const fatSecretRestUrl = 'http://45.64.96.45:6263/prismalink/dd';
    final body = <String, dynamic>{
      'otp_value': otp,
      'otp_ref_num': data.otpRefNum,
      'remarks': 'yes',
      'session_token': data.sessionToken
    };
    final response =
        await http.post(Uri.parse(fatSecretRestUrl), body: jsonEncode(body));
    return jsonDecode(response.body);
  }

  String getLogo(String cardNum) {
    if (cardNum.startsWith('34') || cardNum.startsWith('37')) {
      return 'assets/images/logo_american_express.png';
    }
    if (cardNum.startsWith(RegExp(r"^(352[89]|35[3-8][0-9])"))) {
      return 'assets/images/logo_jcb.png';
    }
    if (cardNum.startsWith('4')) return 'assets/images/logo_visa.png';
    if (cardNum.startsWith('5')) return 'assets/images/logo_mastercard.png';
    if (cardNum.startsWith('60')) return 'assets/images/logo_gpn.png';
    if (cardNum.startsWith('6750') ||
        cardNum.startsWith('676770') ||
        cardNum.startsWith('676774')) return 'assets/images/logo_maestro.png';
    return '';
  }

  Future<void> selectCard() async {
    final card = await Get.toNamed(ManageCard.route.name);
    await _getCard();
    if (card != null && card is DebitCardData) {
      selectedCard = card;
      isCardSelected.value = true;
      cardNum.value = 'XX ' + card.cardNum.substring(card.cardNum.length - 4);
    }
  }

  Future<void> addNewCard() async {
    await Get.toNamed(AddNewCard.route.name);
    await _getCard();
  }

  Future<void> continueTap(bool withCard) async {
    final card = selectedCard;
    if (formKey.currentState?.validate() == true) {
      confirmSheet(card);
    }
  }

  void confirmSheet(DebitCardData card) =>
      EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Konfirmasi Topup',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                height: 65,
                decoration: const BoxDecoration(
                    color: Color(0xFFFCFBFC),
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(getLogo(card.cardNum), width: 65),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(card.nameHolder,
                            style: TextStyle(
                                fontSize: w(16), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(
                            cardNumFormatter.magicMask
                                .getMaskedString(card.cardNum),
                            style: TextStyle(
                                fontSize: w(14),
                                fontWeight: FontWeight.w400,
                                color: t80)),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            CustomSingleRowCard(
                title: 'Nominal', value: 'Rp ${amountController.text}'),
            const SizedBox(
              height: 16,
              child: DashLineDivider(color: Color(0xFFB8B8B8)),
            ),
            CustomSingleRowCard(
                title: 'Total Pembayaran',
                value: 'Rp ${amountController.text}',
                valueColor: green,
                valueSize: 18),
          ],
        ),
        color: green,
        secondaryColor: green,
        secondButtonText: 'Bayar',
        secondButtonOnPressed: () async {
          EiduLoadingDialog.showLoadingDialog();
          final response = await initialization(card);
          Get.back();
          Get.back();
          final otp = await Get.toNamed(OtpPage.route.name,
              arguments: response.maskedPhoneNumber);
          EiduLoadingDialog.showLoadingDialog();
          final ddResponse = await dd(response, otp);
          Get.back();
          if (ddResponse['ACK'] == 'NOK') {
            await EiduInfoDialog.showInfoDialog(title: ddResponse['pesan']);
            return;
          }
          await Get.toNamed(
            TransactionSuccessPage.route.name,
            arguments: PageArgument(
              title: 'Topup',
              ket1: 'Dari',
              ket2: cardNumFormatter.magicMask.getMaskedString(card.cardNum),
              description: 'Topup Berhasil',
              trxId: '',
              biayaAdmin: 'Rp 0',
              nominal: 'Rp ${amountController.text}',
              total: 'Rp ${amountController.text}',
            ),
          );
        },
      );
}
