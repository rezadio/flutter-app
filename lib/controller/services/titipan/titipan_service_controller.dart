import 'dart:convert';

import 'package:eidupay/model/category_data.dart';
import 'package:eidupay/model/category_list.dart';
import 'package:eidupay/model/category_pendidikan.dart';
import 'package:eidupay/model/category_random.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitipanServiceController extends GetxController
    with SingleGetTickerProviderMixin {
  final Network _network;
  TitipanServiceController(this._network);

  final searchController = TextEditingController();

  var dataCategory = <CategoryData>[].obs;
  var dataRandomCategory = <DataCategory>[].obs;
  final _dataListCategory = <DataCategory>[].obs;
  var filteredDataListCategory = <DataCategory>[].obs;
  var savedList = [].obs;
  var listLength = 5.obs;

  late TabController tabController;

  @override
  void onInit() async {
    super.onInit();
    await getCategoryPendidikan();
    tabController.addListener(_handleTab);
    await getListCategory('');
  }

  void _handleTab() async {
    if (tabController.indexIsChanging) {
      return;
    }
    if (tabController.previousIndex != tabController.index) {
      switch (tabController.index) {
        case 1:
          _dataListCategory.clear();
          filteredDataListCategory.clear();
          EiduLoadingDialog.showLoadingDialog();
          await getListCategory('1');
          Get.back();
          break;
        case 2:
          _dataListCategory.clear();
          filteredDataListCategory.clear();
          EiduLoadingDialog.showLoadingDialog();
          await getListCategory('2');
          Get.back();
          break;
        case 3:
          _dataListCategory.clear();
          filteredDataListCategory.clear();
          EiduLoadingDialog.showLoadingDialog();
          await getListCategory('3');
          Get.back();
          break;
        default:
          _dataListCategory.clear();
          filteredDataListCategory.clear();
          EiduLoadingDialog.showLoadingDialog();
          await getListCategory('');
          Get.back();
      }
    }
  }

  void clear() => searchController.clear();

  void loadMore() {
    if (listLength.value + 5 > filteredDataListCategory.length) {
      listLength.value = filteredDataListCategory.length;
      return;
    }
    listLength.value += 5;
  }

  Future<void> getCategoryPendidikan() async {
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
        url: 'eidupay/pendidikan/getCategoryPendidikan',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = CategoryPendidikan.fromJson(decodedBody);
      dataCategory.clear();
      dataCategory
          .add(CategoryData(id: 0, categoryCode: 'ALL', categoryName: 'Semua'));
      dataCategory.addAll(model.dataCategory);
      tabController = TabController(length: dataCategory.length, vsync: this);
    } catch (e) {
      Get.back();
      final defaultModel = DefaultModel.fromJson(decodedBody);
      rethrow;
    }
  }

  Future<void> getRandomCategory() async {
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
        url: 'eidupay/pendidikan/getRandomCategory',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = CategoryRandom.fromJson(decodedBody);
      dataRandomCategory.assignAll(model.dataRandomCategory);
    } catch (e) {
      Get.back();
      final defaultModel = DefaultModel.fromJson(decodedBody);
      rethrow;
    }
  }

  Future<void> getListCategory(String nomorCategory) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'keyCategory': '',
      'nomorCategory': nomorCategory.toString(),
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getListCategory', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = CategoryList.fromJson(decodedBody);
      _dataListCategory.assignAll(model.dataListCategory);
      filteredDataListCategory.assignAll(model.dataListCategory);
      (filteredDataListCategory.length > 5)
          ? listLength.value = 5
          : listLength.value = filteredDataListCategory.length;
    } catch (e) {
      Get.back();
      final defaultModel = DefaultModel.fromJson(decodedBody);
      rethrow;
    }
  }

  void search(String input) {
    filteredDataListCategory.clear();
    for (final data in _dataListCategory) {
      if (data.edukasiName.toLowerCase().contains(input.toLowerCase())) {
        filteredDataListCategory.add(data);
      }
    }
  }
}
