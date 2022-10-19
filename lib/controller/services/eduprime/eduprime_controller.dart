import 'dart:convert';

import 'package:eidupay/model/recent_transaction.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';

class EduprimeController extends GetxController {
  final Network _network;
  EduprimeController(this._network);

  late SharedPreferences _pref;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  var recentTrx = <DataLastTrx>[].obs;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
  }

  void clear() => usernameController.clear();

  Future<void> getRecentTrx(String idMenu) async {
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idMenu': idMenu,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/home/getLastTrx', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final recentTrxModel = RecentTransaction.fromJson(decodedBody);
    recentTrx.addAll(recentTrxModel.dataLastTrx);
  }

  Future<dynamic> getPaket() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'username': usernameController.text,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': dtUser['tipe'],
      'lang': '',
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/eduprime/getPaket', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getAktivasiSiswa() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final idTrx = '3' +
        DateFormat('yyMMddHHmmss').format(DateTime.now()) +
        (_pref.getString(kUid) ?? '');
    final body = <String, String>{
      'idTrx': idTrx,
      'username': usernameController.text, //still hardcoded
      'ID_PAKET_PROGRAM': '02447', //still hardcoded
      'NAMA_PROGRAM': 'TOO Tutorial & Teori', //still hardcoded
      'HARGA': '50000', //still hardcoded
      'BiayaAdmin': '0', //still hardcoded

      'namaSiswa': 'Nama Siswa', //still hardcoded
      'EXPIRED_PAKET_PROGRAM': 'Date', //still hardcoded
      'namaSekolah': 'SMA Prime Generation', //still hardcoded
      'OPEN_PAKET_PROGRAM': 'Date', //still hardcoded
      'kelas': '12', //still hardcoded
      'ID_KELAS': '19', //still hardcoded

      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'packageName': _package.packageName,
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/eduprime/getAktivasiSiswa', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getCekTagihan() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'username': usernameController.text,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': dtUser['tipe'],
      'lang': '',
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/eduprime/getCekTagihan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(dynamic data, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idTrx': 'idTrx',
      'username': usernameController.text,
      'nominal': '100',
      'biaya_admin': '100',
      'nama_siswa': 'mae',
      'nama_sekolah': 'sekolah',
      'pin': pin,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': dtUser['tipe'],
      'lang': '',
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/eduprime/getBayarTagihan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> continueTap() async {
    if (formKey.currentState?.validate() == true) {
      EiduLoadingDialog.showLoadingDialog();
      final response = await getPaket();
      Get.back();
      if (response['ACK'] == 'NOK') {
        await EiduInfoDialog.showInfoDialog(title: response['pesan']);
        return;
      } else {
        // TODO: handle ACK OK
      }
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
