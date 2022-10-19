import 'dart:convert';

import 'package:eidupay/controller/home_cont.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/sub_account/profile/sub_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubHomeCont extends HomeCont {
  final Network _network;
  SubHomeCont(this._network) : super(_network);

  late SharedPreferences _pref;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
    refreshService();
  }

  @override
  void refreshService() {
    super.refreshService();
    setDate();
  }

  Future<void> setDate() async {
    final day = DateTime.now().day;
    final savedDay = _pref.getInt(kDay) ?? 0;
    if (savedDay < day) {
      await _pref.setInt(kDay, day);
      await _resetDailyUsed();
    }
  }

  Future<void> _resetDailyUsed() async {
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': dtUser['idAccount'],
      'phoneExtended': _pref.getString(kHp) ?? '',
      'tipe': 'member',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/resetDailyUsed', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    debugPrint(decodedBody.toString());
  }

  @override
  void profileTap() {
    Get.toNamed(SubProfilePage.route.name, arguments: account)
        ?.then((value) => refreshService());
  }
}
