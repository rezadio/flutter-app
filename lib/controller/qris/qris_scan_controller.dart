import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/qris.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';

class QrisScanController extends GetxController {
  final Network _network;
  QrisScanController(this._network);

  var isFlashOn = false.obs;
  Barcode? result;

  Future<Qris> checkQris(BuildContext context, String data) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'idAgentTujuan': data,
      'tipe': _pref.getString(kUserType) ?? '',
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/qris/checkQRIS', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = Qris.fromJson(decodedBody);
      return model;
    } catch (_) {
      final model = DefaultModel.fromJson(decodedBody);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(model.pesan),
          duration: const Duration(milliseconds: 1500)));
      rethrow;
    }
  }
}
