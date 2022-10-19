import 'dart:convert';

import 'package:eidupay/model/education.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EdukasiInputSiswaCont extends GetxController {
  final Network _network;
  EdukasiInputSiswaCont(this._network);

  final contNoInduk = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String cookie = '';
  String uid = '';
  late DataListCategory data;

  @override
  void onInit() async {
    super.onInit();
    uid = await getUid();
    await _getCookie();
  }

  Future<void> _getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<dynamic> _getInqEdukasi() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'].toString();
    final header = {'Cookie': cookie};
    final body = <String, String>{
      'merchantPhone': data.id,
      'payerNumber': dtUser['idAccount'],
      'customerNumber': contNoInduk.text,
      'idAccount': dtUser['idAccount'],
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'packageName': _packageInfo.packageName,
      'deviceInfo': uid,
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getInquiryEdukasi',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> lanjutTap() async {
    if (formKey.currentState!.validate()) {
      EiduLoadingDialog.showLoadingDialog();
      var res = await _getInqEdukasi();
      Get.back();

      if (res['ACK'] == 'NOK') {
        await EiduInfoDialog.showInfoDialog(title: res['pesan']);
        return;
      }
      // if (res['rc'] == '04') {
      //   final educationInquiryData = EducationInquiry.fromJson(res);
      //   await Get.toNamed(
      //       '/services/educationsuka/${educationInquiryData.inquiryListCategory.merchantPhone}/confirm/',
      //       arguments: educationInquiryData);
      // }

      if (res['ACK'] == 'OK') {
        final educationInquiryData = EducationInquiry.fromJson(res);
        await Get.toNamed(
            '/services/education/${educationInquiryData.inquiryListCategory.merchantPhone}/confirm/',
            arguments: educationInquiryData);
      }
    }
  }
}
