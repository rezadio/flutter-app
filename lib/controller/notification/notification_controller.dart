import 'dart:convert';

import 'package:eidupay/controller/transaction_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/message.dart';
import 'package:eidupay/model/mutasi.dart';
import 'package:eidupay/model/notification.dart';
import 'package:eidupay/model/swiff.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';

class NotificationController extends GetxController {
  final Network _network;
  NotificationController(this._network);

  var isNotifLoaded = false.obs;
  var isMessageLoaded = false.obs;
  var notificationDatas = <NotificationData>[].obs;
  var dataMessages = <DataMessage>[].obs;

  final notificationRefreshController = RefreshController();
  final messageRefreshController = RefreshController();
  final datas = <Mutasi>[];

  Future<void> refreshAll() async {
    await refreshNotification();
    await refreshMessage();
  }

  Future<void> refreshNotification() async {
    isNotifLoaded.value = false;
    await _getMutasi();
    await _getNotification();
    isNotifLoaded.value = true;
    notificationRefreshController.refreshCompleted();
  }

  Future<void> refreshMessage() async {
    isMessageLoaded.value = false;
    await _getMessage();
    isMessageLoaded.value = true;
    messageRefreshController.refreshCompleted();
  }

  Future<void> _getMutasi() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'offset': '0',
      'limit': '999',
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
    try {
      final mutasiModel = MutasiModel.fromJson(decodedBody);
      datas.assignAll(mutasiModel.dataMutasi);
    } catch (e) {
      datas.clear();
      rethrow;
    }
  }

  Future<void> _getNotification() async {
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
        port: 9009, url: 'api/getInbox', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = NotificationModel.fromJson(decodedBody);
      notificationDatas.assignAll(model.data.list);
    } catch (e) {
      notificationDatas.clear();
      rethrow;
    }
  }

  Future<NotifInfo> _getNotificationInfoDetail(
      NotificationData notificationData) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'detailReff': notificationData.detailReff,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getInboxDetail', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = NotifInfoResponse.fromJson(decodedBody);
      return model.data;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }

  Future<void> notifTap(NotificationData notificationData) async {
    final detailType = notificationData.detailType;
    final detailReff = notificationData.detailReff;
    _updateNotif(notificationData);
    switch (detailType) {
      case 'INFO':
        EiduLoadingDialog.showLoadingDialog();
        final data = await _getNotificationInfoDetail(notificationData);
        Get.back();
        await Get.toNamed('/notification/info/${data.id}', arguments: data);
        break;
      case 'TRX':
        if (detailReff != null) {
          EiduLoadingDialog.showLoadingDialog();
          final _trxCont = Get.put(TransactionController(injector.get()));
          final data = await _trxCont.getNotificationTrxDetail(detailReff);
          final Mutasi mutasi =
              datas.firstWhere((value) => value.idStock == detailReff);
          Get.back();
          await Get.toNamed('/transaction/detail/$detailReff',
              arguments: {'notifDetail': data.first, 'mutasi': mutasi});
        }
        break;
      case 'SWF':
        if (detailReff != null) {
          EiduLoadingDialog.showLoadingDialog();
          final response = await _inqMerchantSwiff(detailReff);
          Get.back();
          await Get.toNamed('/swiff/payment/$detailReff', arguments: response);
        }
        break;
      default:
        return;
    }
  }

  Future<Message> _getMessage() async {
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
        url: 'eidupay/notifikasi/getPesan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = Message.fromJson(decodedBody);
      dataMessages.assignAll(model.dataMessage);
      return model;
    } catch (e) {
      dataMessages.clear();
      rethrow;
    }
  }

  void _updateNotif(NotificationData notificationData) async {
    if (notificationData.read) {
      return;
    }
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'id': notificationData.id,
      'detailType': notificationData.detailType,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/readMessage', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    await _getNotification();
  }

  Future<SwiffInquiry> _inqMerchantSwiff(String payCode) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'payCode': payCode,
      'idAccount': _pref.getString(kUserId),
      'tipe': _pref.getString(kUserType),
      'packageName': _package.packageName,
      'lang': '',
      'deviceInfo': _pref.getString(kUid),
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/belanja/inqMerchantSwiff', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = SwiffInquiry.fromJson(decodedBody);
      return model;
    } catch (e) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: decodedBody['pesan']);
      rethrow;
    }
  }

  @override
  void dispose() {
    notificationRefreshController.dispose();
    messageRefreshController.dispose();
    super.dispose();
  }
}
