import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/sedekah.dart';
import 'package:get/get.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SedekahController extends GetxController {
  final Network _network;
  SedekahController(this._network);

  var dataList = <DataSedekah>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getList();
  }

  Future<Sedekah> getList() async {
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
        url: 'eidupay/donasi/getList', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final sedekahModel = Sedekah.fromJson(decodedBody);
      dataList.assignAll(sedekahModel.dataList);
      return sedekahModel;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }

  Future<Sedekah> getListDetail(int id) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'programId': id,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/donasi/getListDetail', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final sedekahModel = Sedekah.fromJson(decodedBody);
      return sedekahModel;
    } catch (e) {
      Get.back();
      final defaultModel = DefaultModel.fromJson(decodedBody);
      rethrow;
    }
  }
}
