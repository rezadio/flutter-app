import 'dart:convert';

import 'package:eidupay/model/mutasi.dart';
import 'package:eidupay/model/notification.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  final Network _network;
  TransactionController(this._network);

  final refreshController = RefreshController();

  var isLoaded = false.obs;
  var datas = <Mutasi>[].obs;

  @override
  void onInit() async {
    super.onInit();

    await _getMutasi(5);
    isLoaded.value = true;
  }

  Future<void> _getMutasi(int limit) async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'offset': '0',
      'limit': limit.toString(),
      'tgl': '',
      'lang': '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/home/getMutasi', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final mutasiModel = MutasiModel.fromJson(decodedBody);
    datas.assignAll(mutasiModel.dataMutasi);
  }

  Future<List<NotifDetail>> getNotificationTrxDetail(String id) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'detailReff': id,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getDetailHistory', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final models = NotifDetailResponse.fromJson(decodedBody);
      return models.data;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }

  Future<void> transactionCardTapped(Mutasi data) async {
    EiduLoadingDialog.showLoadingDialog();
    final response = await getNotificationTrxDetail(data.idStock);
    Get.back();
    await Get.toNamed(
      '/transaction/detail/${data.idStock}',
      arguments: {'notifDetail': response.first, 'mutasi': data},
    );
  }

  Future<void> refreshService() async {
    try {
      isLoaded.value = false;
      await _getMutasi(5);
      isLoaded.value = true;
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      rethrow;
    }
  }

  Future<void> loadMore() async {
    try {
      final newLimit = datas.length + 5;
      await _getMutasi(newLimit);
      refreshController.loadComplete();
    } catch (e) {
      refreshController.loadFailed();
      rethrow;
    }
  }
}
