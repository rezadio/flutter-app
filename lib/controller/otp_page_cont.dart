import 'dart:async';
import 'dart:convert';

import 'package:eidupay/controller/login_cont.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/login.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/forgot_pin/reset_pin_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPageCont extends GetxController {
  final Network _network;
  OtpPageCont(this._network);

  final _loginCont = Get.find<LoginCont>();
  String noHp = '';
  var isComplete = false.obs;
  var waktuResend = 60;
  var tm = 60.obs;

  late LoginRest loginRest;
  late OTPTextEditController otpController;
  late OTPInteractor otpInteractor;

  @override
  void onInit() {
    super.onInit();
    starTimer();
  }

  void starTimer() {
    Timer _tm = Timer.periodic(const Duration(), (timer) {});
    _tm = Timer.periodic(const Duration(seconds: 1), (timer) {
      tm = tm - 1;
      if (tm.value == 0) {
        _tm.cancel();
      }
    });
  }

  Future<dynamic> getOtp() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'hp': loginRest.hp,
      'idAccount': loginRest.idAccount,
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'lang': '',
    };

    final response =
        await _network.post(url: 'eidupay/login/getOtp', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    return decryptedBody;
  }

  Future<String> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    String _uid = _pref.getString(kUid) ?? '';
    return _uid;
  }

  Future<void> resendCode() async {
    await getOtp();
    tm.value = 60;
    starTimer();
  }

  Future<void> onComplete(LoginRest loginRest, String otp) async {
    final _pref = await SharedPreferences.getInstance();
    EiduLoadingDialog.showLoadingDialog();
    final otpResponse = await _verifyOtp(loginRest, otp);
    Get.back();
    otpController.clear();

    if (otpResponse.ack == 'NOK' && otpResponse.pesan == 'not valid otp') {
      await EiduBottomSheet.showBottomSheet(
          title: 'Perhatian',
          icon: Icons.warning_rounded,
          iconColor: Colors.orange,
          description:
              'Kode verifikasi salah. Pastikan anda memasukkan kode verifikasi sesuai dengan kode yang telah kami kirim ke nomor anda.',
          buttonText: 'Coba lagi',
          onPressed: () => Get.back());
      return;
    } else if (otpResponse.ack == 'NOK') {
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: otpResponse.pesan);
      return;
    }

    EiduLoadingDialog.showLoadingDialog();
    final res = await _loginCont.changeDevice(loginRest, otp);
    Get.back();
    if (res.ack == 'NOK') {
      await EiduBottomSheet.showBottomSheet(
          title: 'Perhatian',
          icon: Icons.warning_rounded,
          iconColor: Colors.orange,
          description: res.pesan,
          buttonText: 'Kembali',
          onPressed: () => Get.back());
      return;
    }
    await _pref.setBool(kIsUseBiometric, false);
    await _pref.setBool(kIsAlreadyPrompted, false);
    if (loginRest.nama != '') {
      await _loginCont.signInTap();
    } else {
      Get.back();
      await Get.toNamed(ResetPinPage.route.name);
    }
  }

  Future<DefaultModel> _verifyOtp(LoginRest loginRest, String otp) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'otp': otp,
      'phoneExtended': loginRest.hp,
      'tipe': _pref.getString(kUserType) ?? '',
      'idAccount': loginRest.idAccount,
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'lang': '',
      'versionCode': versionCode
    };
    final response =
        await _network.post(url: 'eidupay/login/verifyOtp', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    var otpResponse = DefaultModel.fromJson(jsonDecode(decryptedBody));
    return otpResponse;
  }

  void cobaLagi() {
    Get.back();
  }

  @override
  void dispose() {
    otpController.stopListen();
    otpController.dispose();
    super.dispose();
  }
}
