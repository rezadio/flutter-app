import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/komunitas.dart';
import 'package:eidupay/model/login.dart';
import 'package:eidupay/model/register.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/komunitas_list.dart';
import 'package:eidupay/view/signup.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:eidupay/tools.dart';

class SignupCont extends GetxController {
  final Network _network;
  SignupCont(this._network);

  String negaraSelected = '';
  final formKey = GlobalKey<FormState>();
  final contName = TextEditingController();
  final contPhoneNumber = TextEditingController();
  final contRefID = TextEditingController();
  final contVerificationCode = TextEditingController();
  final contPin = TextEditingController();
  var showPass = false.obs;
  var listKomunitas = <DataKomunitas>[].obs;
  var otpRegister = Register(message: '', ack: '', idReg: '');
  String picPhone = '';

  @override
  void onInit() async {
    super.onInit();

    negaraSelected = 'Indonesia';
    await getIdKomunitas();
  }

  Future<Register> getOtpRegister() async {
    final _pref = await SharedPreferences.getInstance();
    final _packageInfo = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'noHp': contPhoneNumber.text,
      'packageName': _packageInfo.packageName,
      'prefixMsisdn': '62',
      'deviceInfo': _pref.getString(kUid),
      'lang': negaraSelected,
    };
    final response = await _network.post(
        url: 'eidupay/register/getOtpRegistrasi', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    otpRegister = Register.fromJson(jsonDecode(decryptedBody));
    return otpRegister;
  }

  Future<void> getIdKomunitas() async {
    final _pref = await SharedPreferences.getInstance();
    final _packageInfo = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'search': '',
      'packageName': _packageInfo.packageName,
      'deviceInfo': _pref.getString(kUid),
      'lang': negaraSelected,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/register/getListKomunitas', body: _body);
    final bodyResponse = await response.stream.bytesToString();

    final decryptedBody = _network.decrypt(bodyResponse);
    var res = jsonDecode(decryptedBody);
    if (res['ACK'] == 'OK') {
      final model = Komunitas.fromJson(jsonDecode(decryptedBody));
      listKomunitas.assignAll(model.dataKomunitas);
    }
  }

  Future<Register> register(String otp, String pin) async {
    final _pref = await SharedPreferences.getInstance();
    final _packageInfo = await PackageInfo.fromPlatform();
    final body = <String, dynamic>{
      'otpInput': otp,
      'pin': pin,
      'noHp': contPhoneNumber.text,
      'packageName': _packageInfo.packageName,
      'prefixMsisdn': '62',
      'lang': negaraSelected,
      'namaLengkap': contName.text,
      'referralCode': picPhone,
      'deviceInfo': _pref.getString(kUid),
      'idReg': otpRegister.idReg,
    };
    final response =
        await _network.post(url: 'eidupay/register/getRegister', body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    try {
      otpRegister = Register.fromJson(jsonDecode(decryptedBody));
      return otpRegister;
    } catch (e) {
      await Get.offAllNamed(Signup.route.name);
      await EiduInfoDialog.showInfoDialog(title: 'OTP salah, coba lagi');
      rethrow;
    }
  }

  Future<void> signIn() async {
    final _pref = await SharedPreferences.getInstance();
    final _body = <String, dynamic>{
      'userName': contPhoneNumber.text,
      'phoneExtended': contPhoneNumber.text,
      'pin': contPin.text,
      'deviceInfo': _pref.getString(kUid),
      'versionCode': versionCode,
    };
    final response =
        await _network.post(url: 'eidupay/login/signIn', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final cookie =
        response.headers['set-cookie']?.split(';').first.substring(18);
    await _pref.setString(kCookie, cookie ?? '');
    await _pref.setString(kDtUser, decryptedBody);
    final decodedBody = jsonDecode(decryptedBody);
    dtUser = decodedBody;
    try {
      final loginModel = LoginRest.fromJson(decodedBody);
      await _pref.setString(kUserId, loginModel.idAccount);
      await _pref.setString('userName', loginModel.nama);
      await _pref.setString(kUserType, loginModel.tipe);
      await _pref.setBool(kIsLoggedIn, true);
    } catch (e) {
      final model = DefaultModel.fromJson(dtUser);
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: model.pesan);
      rethrow;
    }
  }

  Future<void> komunitasTap() async {
    final komunitas =
        await Get.toNamed(KomunitasList.route.name, arguments: listKomunitas)
            as DataKomunitas?;
    if (komunitas != null) {
      contRefID.text = '${komunitas.communityId} - ${komunitas.communityName}';
      picPhone = komunitas.picPhone;
    } else {
      contRefID.clear();
    }
    return;
  }
}
