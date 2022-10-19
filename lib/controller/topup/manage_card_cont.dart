import 'dart:convert';

import 'package:eidupay/model/direct_debit.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/add_new_card.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';

class ManageCardCont extends GetxController {
  final Network _network;
  ManageCardCont(this._network);

  var cardList = <DebitCardData>[].obs;
  var cardSelectedIndex = <int>[].obs;
  var cardSelectedId = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getCard();
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
    final model = DebitCard.fromJson(decodedBody);
    cardList.assignAll(model.data);
  }

  Future<void> _deleteCard(int id) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'cardId': id,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/deleteCard', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
  }

  String formatExpDate(String expDate) => expDate.replaceRange(2, 4, '/');

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

  String formatCardNum(String cardNum) =>
      cardNumFormatter.magicMask.getMaskedString(cardNum);

  void cardTap(int index, int cardId) {
    cardSelectedIndex.assign(index);
    cardSelectedId.value = cardId;
  }

  Future<void> addNewCard() async =>
      Get.toNamed(AddNewCard.route.name)?.then((value) async {
        EiduLoadingDialog.showLoadingDialog();
        await _getCard();
        Get.back();
      });

  void continueTap(int id) {
    final cardData = cardList.where((card) => id == card.id).first;
    Get.back(result: cardData);
  }

  void removeCard(int id) {
    EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Hapus Kartu',
        body: const Text(
          'Apa kamu yakin ingin menghapus kartu?',
          style: TextStyle(fontSize: 14),
        ),
        iconUrl: 'assets/images/trash.png',
        color: Colors.red,
        firstButtonText: 'Hapus',
        secondButtonText: 'Batal',
        secondaryColor: Colors.red,
        firstButtonOnPressed: () async {
          Get.back();
          EiduLoadingDialog.showLoadingDialog();
          await _deleteCard(id);
          await _getCard();
          cardSelectedId.value = 0;
          cardSelectedIndex.clear();
          Get.back();
        },
        secondButtonOnPressed: () => Get.back());
  }
}
