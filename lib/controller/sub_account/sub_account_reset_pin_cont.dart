import 'dart:convert';

import 'package:eidupay/controller/sub_account/sub_account_detail_controller.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubAccountResetPinCont extends GetxController {
  final Network _network;
  SubAccountResetPinCont(this._network);

  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final konfirmPinController = TextEditingController();
  final pinParentController = TextEditingController();
  final _contDetail = Get.find<SubAccountDetailController>();

  var isPinHide = true.obs;
  var isKonfirmPinHide = true.obs;
  var isPinParentHide = true.obs;
  var cookie;
  var uid;

  @override
  void onInit() async {
    super.onInit();
    await getCookie();
    await getUid();
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<dynamic> updatePIN() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'phoneExtended': _contDetail.detail.phone,
      'nameExtended': _contDetail.detail.name,
      'pinExt': pinController.text,
      'tipe': dtUser['tipe'],
      'pin': pinParentController.text,
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/extended/updatePin', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> simpanTap() async {
    if (formKey.currentState!.validate()) {
      EiduLoadingDialog.showLoadingDialog();
      var resUpdatePin = await updatePIN();
      Get.back();
      if (resUpdatePin['ACK'] == 'NOK') {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: resUpdatePin['pesan']);
        return;
      } else {
        Get.back();
        await EiduInfoDialog.showInfoDialog(
            title: 'PIN sub account berhasil diperbaharui',
            icon: 'assets/lottie/success.json');
      }
    }
  }
}
