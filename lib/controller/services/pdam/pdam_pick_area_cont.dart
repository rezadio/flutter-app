import 'dart:convert';

import 'package:eidupay/controller/services/pdam/pdam_controller.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdamGetAreaCont extends GetxController {
  final Network _network;
  PdamGetAreaCont(this._network);

  var listArea = [].obs;
  var listAreaFilter = [].obs;
  var inProgress = false.obs;
  var searchTxt = '';
  final _contPDAM = Get.find<PdamController>();

  @override
  void onInit() async {
    super.onInit();

    inProgress(true);
    var res = await getKodeArea();
    listArea.value = res['kodeArea'];
    listAreaFilter.value = res['kodeArea'];
    inProgress(false);
  }

  Future<dynamic> getKodeArea() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'search': '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/pdam/getKodeArea', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  void onSearch(String txt) {
    listAreaFilter.value = [];
    for (var i in listArea) {
      if (i['namaOperator']
          .toString()
          .toLowerCase()
          .contains(txt.toLowerCase())) {
        listAreaFilter.add(i);
      }
    }
  }

  void areaTap(Map<String, dynamic> areaSelected) {
    _contPDAM.areaContr.text = areaSelected['namaOperator'];
    _contPDAM.selectedArea = areaSelected;
    Get.back();
  }
}
