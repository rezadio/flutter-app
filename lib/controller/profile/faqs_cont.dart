import 'dart:convert';

import 'package:eidupay/model/faq.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';

class FaqsCont extends GetxController {
  final Network _network;
  FaqsCont(this._network);

  var faqs = <Faq>[].obs;
  var idx = 0.obs;
  var isLoaded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getFaq();
    isLoaded.value = true;
  }

  Future<void> getFaq() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId),
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType),
      'deviceInfo': _pref.getString(kUid),
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/faqs', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = FaqResponse.fromJson(decodedBody);
    faqs.assignAll(model.data);
  }

  void faqsTap(int index) {
    idx.value = index;
  }
}
