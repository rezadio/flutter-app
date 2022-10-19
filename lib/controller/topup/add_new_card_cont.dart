import 'dart:convert';

import 'package:easy_mask/easy_mask.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';

class AddNewCardCont extends GetxController {
  final Network _network;
  AddNewCardCont(this._network);

  final expDateMask = TextInputMask(mask: '99/99');
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cardNumController = TextEditingController();
  final expDateController = TextEditingController();
  final cvvController = TextEditingController();

  Future<dynamic> pay(inquiry, String pin) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final expDate = expDateController.text.replaceAll('/', '20');
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'pin': pin,
      'cardNum': cardNumFormatter.magicMask.clearMask(cardNumController.text),
      'expiredDate': expDate,
      'cvv': cvvController.text,
      'nameHolder': nameController.text,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/addDebitCard', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  void selectBank(Map<String, dynamic> bank) => bank.assignAll(bank);

  bool checkCard() {
    String cardNo =
        cardNumFormatter.magicMask.clearMask(cardNumController.text);
    var sum = 0;
    for (var i = 0; i < cardNo.length; i++) {
      var digit = int.parse(cardNo.substring(i, i + 1));
      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) {
          digit = 1 + (digit % 10);
        }
      }
      sum += digit;
    }
    return sum % 10 == 0;
  }

  Future<void> saveTap() async {
    if (formKey.currentState?.validate() == true) {
      List<dynamic>? results = await Get.to(
          () => PinVerificationPage<AddNewCardCont>(pageController: this),
          arguments: null);

      final bool? isSuccess = results?[0];
      final response = results?[1];

      if (isSuccess != null && isSuccess) {
        final isCardCorrect = checkCard();
        if (isCardCorrect) {
          if (response['ACK'] == 'NOK') {
            await EiduInfoDialog.showInfoDialog(title: response['pesan']);
            return;
          }
          Get.back();
          await EiduInfoDialog.showInfoDialog(
              title: response['pesan'], icon: 'assets/lottie/success.json');
        } else {
          await EiduInfoDialog.showInfoDialog(title: 'Nomor Kartu Salah');
        }
      }
    }
  }
}
