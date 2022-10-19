import 'dart:convert';

import 'package:eidupay/model/education.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationServiceCont extends GetxController
    with SingleGetTickerProviderMixin {
  final Network _network;
  EducationServiceCont(this._network);

  var inProgress = false.obs;

  var listLength = 0.obs;
  var listData = <DataListCategory>[].obs;
  var listDataFilter = <DataListCategory>[].obs;

  var listSavedAll = [].obs;
  var listSaveSekolah = [].obs;
  var listSaveKampus = [].obs;
  var listKategori = <EducationDataCategory>[].obs;
  var cookie;
  var uid;
  late EducationCategory resCategory;
  final contCari = TextEditingController();

  late TabController tabController;

  void clear() => contCari.clear();

  @override
  void onInit() async {
    super.onInit();

    inProgress(true);
    await getCookie();
    uid = await getUid();
    await getCategoryPendidikan();
    tabController.addListener(_handleTabSelection);
    await getRandomCategory();

    //TODO: recent TRX belum bener!!
    var resRecent = await getRecentTrans();
    final recentData = resRecent['data'];
    if (recentData != null) listSavedAll.value = recentData;

    inProgress(false);
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  void loadMore() {
    if (listLength.value + 5 > listDataFilter.length) {
      listLength.value = listDataFilter.length;
      return;
    }
    listLength.value += 5;
  }

  Future<void> getCategoryPendidikan() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getCategoryPendidikan',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final educationCategory = EducationCategory.fromJson(decodedBody);
      listKategori.assign(EducationDataCategory(
          id: 0, categoryCode: 'ALL', categoryName: 'Semua'));
      listKategori.addAll(educationCategory.dataCategory);
      tabController = TabController(length: listKategori.length, vsync: this);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getRandomCategory() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getRandomCategory',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final educationList = EducationRandomList.fromJson(decodedBody);
      listData.assignAll(educationList.dataRandomCategory);
      listDataFilter.assignAll(educationList.dataRandomCategory);
      (listDataFilter.length > 5)
          ? listLength.value = 5
          : listLength.value = listDataFilter.length;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getListCategory(String noCategory) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'keyCategory': '',
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode,
      'nomorCategory': noCategory
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getListCategory', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final educationList = EducationList.fromJson(decodedBody);
      listData.assignAll(educationList.dataListCategory);
      listDataFilter.assignAll(educationList.dataListCategory);
      (listDataFilter.length > 5)
          ? listLength.value = 5
          : listLength.value = listDataFilter.length;
    } catch (_) {
      rethrow;
    }
  }

  Future<dynamic> getRecentTrans() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode,
    };

    final response = await _network.post(
        port: 9009, url: 'api/educationLastTrx', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  void _handleTabSelection() async {
    final index = tabController.index;
    if (tabController.indexIsChanging) {
      return;
    }
    if (tabController.previousIndex != tabController.index) {
      switch (index) {
        case 1:
        case 2:
        case 3:
          contCari.clear();
          listData.clear();
          listDataFilter.clear();
          inProgress(true);
          await getListCategory(index.toString());
          inProgress(false);
          break;
        default:
          listData.clear();
          listDataFilter.clear();
          inProgress(true);
          await getListCategory('');
          inProgress(false);
      }
    }
  }

  void search(String input) {
    listDataFilter.clear();
    for (final data in listData) {
      if (data.edukasiName.toLowerCase().contains(input.toLowerCase())) {
        listDataFilter.add(data);
      }
    }
    (listDataFilter.length > 5)
        ? listLength.value = 5
        : listLength.value = listDataFilter.length;
  }

  void educationTap(DataListCategory data) {
    Get.toNamed('/services/education/${data.id}/', arguments: data);
  }

  void savedListonTap(DataListCategory data) {
    Get.toNamed('/services/education/${data.id}/', arguments: data);
  }
}
