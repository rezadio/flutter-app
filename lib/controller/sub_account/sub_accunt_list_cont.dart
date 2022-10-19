import 'dart:convert';

import 'package:eidupay/model/sub_account.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubAccountListCont extends GetxController {
  final Network _network;
  SubAccountListCont(this._network);

  var cookie;
  var uid;
  var inProgress = false.obs;
  ListSubAcc? dataExtUser;
  var listSubAcc = <ListSubAcc>[].obs;

  final notificationRefreshController = RefreshController();

  @override
  void onInit() async {
    super.onInit();
    await getUid();
    await getCookie();
    inProgress(true);
    await getListExtUser();
    inProgress(false);
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<void> getListExtUser() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/getListExt', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);

    final resGetList = ResSubAccList.fromJson(decodedBody);
    listSubAcc.assignAll(resGetList.listAcc);
  }

  void toExtDetail(String idExt) {
    Get.toNamed('/sub_account/$idExt', parameters: {'id': idExt})
        ?.then((value) async {
      await getListExtUser();
    });
  }
}
