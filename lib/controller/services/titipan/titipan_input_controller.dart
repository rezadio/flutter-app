import 'dart:convert';

import 'package:eidupay/model/category_data.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/inquiry_tabungan.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitipanInputController extends GetxController {
  final Network _network;
  TitipanInputController(this._network);

  final formKey = GlobalKey<FormState>();
  final nomorIndukController = TextEditingController();

  Future<InquiryTabungan> getInquiryTabungan(String merchantPhone) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'merchantPhone': merchantPhone,
      'payerNumber': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'customerNumber': nomorIndukController.text,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getInquiryTabungan',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = InquiryTabungan.fromJson(decodedBody);
      return model;
    } catch (e) {
      Get.back();
      final defaultModel = DefaultModel.fromJson(decodedBody);
      await EiduInfoDialog.showInfoDialog(title: defaultModel.pesan);
      rethrow;
    }
  }

  Future<void> process({required DataCategory dataCategory}) async {
    if (formKey.currentState?.validate() == true) {
      EiduLoadingDialog.showLoadingDialog();
      final response = await getInquiryTabungan(dataCategory.id);
      Get.back();
      await Get.toNamed(
          '/sevices/titipan/input-siswa/${nomorIndukController.text}',
          arguments: response);
    }
  }
}
