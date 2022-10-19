import 'dart:convert';
import 'package:eidupay/model/sub_account.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubAccountDetailController extends GetxController {
  final Network _network;
  SubAccountDetailController(this._network);

  late SubAccountDetail detail;
  var isLoaded = false.obs;
  var isChecked = false.obs;
  var dailyLimitValue = 0.0.obs;
  var limitValue = 0.0.obs;
  var toggleLockFund = false.obs;
  var toggleDeleteAccount = false.obs;
  var toggleDeactivateAccount = false.obs;
  var maxValue = 2000000.0;
  var maxDailyLimit = '0'.obs;
  var amountUsed = '0'.obs;

  var idExt;
  final formKey = GlobalKey<FormState>();
  final amountDailyLimitController = TextEditingController();
  final amountLimitController = TextEditingController();
  final amountNotifierController = TextEditingController();
  var cookie;
  var uid;
  var isChange = false.obs;
  var isDailyLimitChecked = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCookie();
    await getUid();
    await getExt();
    isLoaded.value = true;

    amountLimitController.text = detail.limit;
    amountDailyLimitController.text = detail.limitDaily;
    limitValue.value = double.parse(detail.limit);
    dailyLimitValue.value = double.parse(detail.limitDaily);
    maxDailyLimit.value = amountLimitController.text;
    toggleLockFund.value = detail.lockFund;
    toggleDeactivateAccount.value = detail.deactive;
    isDailyLimitChecked.value = double.parse(detail.limitDaily) > 0;
  }

  void toggleDailyCheck() {
    isChange.value = true;
    isDailyLimitChecked.value = !isDailyLimitChecked.value;
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<void> getExt() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idExt': idExt,
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/getExt', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);

    final subDetail = SubAccountDetail.fromJson(decodedBody);
    detail = subDetail;
    // detail = SubAccountDetail.fromJson(
    //     jsonDecode(subDetail.dataExtended) as Map<String, dynamic>);
    amountUsed.value = detail.used;
  }

  Future<dynamic> updateTransaction() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'limit': limitValue.round().toString(),
      'dailyLimit':
          isDailyLimitChecked.value ? dailyLimitValue.round().toString() : '0',
      'lockFund': toggleLockFund.value.toString(),
      'deactive': toggleDeactivateAccount.value.toString(),
      'idExt': idExt.toString(),
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/updateTransaction', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> _resetUsed() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': dtUser['idAccount'],
      'idExt': idExt.toString(),
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/resetUsed', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    debugPrint(decodedBody.toString());
  }

  Future<dynamic> pay(inquiry, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'idExt': idExt.toString(),
      'pin': pin,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/deleteExt', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  void topupTap() {
    Get.toNamed(Topup.route.name);
  }

  Future<void> resetUsedTap() async {
    await EiduConfirmationBottomSheet.showBottomSheet(
      title: 'Reset Penggunaan',
      body: const Text(
          'Yakin ingin me-reset penggunaan yang sudah dilakukan oleh sub akun ini?'),
      secondaryColor: green,
      secondButtonText: 'Ya',
      secondButtonOnPressed: () async {
        EiduLoadingDialog.showLoadingDialog();
        await _resetUsed().then((_) => getExt());
        Get.back();
      },
    );
  }

  Future<void> simpanTap() async {
    EiduLoadingDialog.showLoadingDialog();
    var resSimpan = await updateTransaction();
    if (resSimpan['ACK'] == 'NOK') {
      Get.back();
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: resSimpan['pesan']);
      return;
    }
    Get.back();
    Get.back();
  }

  Future<void> deleteTap() async {
    debugPrint('asd');
    Get.back();
    toggleDeleteAccount.value = true;
    List<dynamic>? results = await Get.to(
      () =>
          PinVerificationPage<SubAccountDetailController>(pageController: this),
      arguments: null,
    );

    final bool? isSuccess = results?[0];
    final resDelete = results?[1];

    if (isSuccess != null && isSuccess) {
      await Get.defaultDialog(
          title: 'Eidupay',
          barrierDismissible: false,
          content: Column(
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                color: green,
                size: 80,
              ),
              Text(
                resDelete['pesan'],
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SubmitButton(
                  backgroundColor: green,
                  text: 'Kembali',
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ));
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    amountLimitController.dispose();
    amountDailyLimitController.dispose();
    amountNotifierController.dispose();
    super.dispose();
  }
}
