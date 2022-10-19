import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:io';

import 'package:eidupay/controller/auth_controller.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/forgot_pin/reset_pin_page.dart';
import 'package:eidupay/view/forgot_pin/security_question_page.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/model/login.dart';
import 'package:eidupay/view/otp_page.dart';
import 'package:eidupay/view/signup.dart';
import 'package:eidupay/view/sub_account/sub_home_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class LoginCont extends GetxController {
  final Network _network;
  LoginCont(this._network);

  String negaraSelected = '';
  final formKey = GlobalKey<FormState>();
  final contPhoneNumber = TextEditingController();
  final contPin = TextEditingController();
  var showPass = false.obs;
  var rememberMe = false.obs;
  var invalidPass = 0;
  var isUseBiometric = false.obs;
  var biometricIcon = ''.obs;

  List<String> pertanyaan = [];
  List<String> jawaban = [];

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> _sendAnalyticsEvent(String namaEvent, String pesan) async {
    await analytics.logEvent(
      name: namaEvent,
      parameters: <String, dynamic>{'pesan': pesan},
    );
    debugPrint('send event $pesan');
  }

  @override
  void onInit() async {
    super.onInit();
    negaraSelected = 'Indonesia';
    await verifyLogin();
    await checkIsUseBiometric();
    await _getLastNUmber().then((value) => {contPhoneNumber.text = value});
  }

  Future<String> _getLastNUmber() async {
    final _pref = await SharedPreferences.getInstance();
    final lastNum = _pref.getString(kLastLogin) ?? '';
    return lastNum;
  }

  Future<String> _getUid() async {
    final _pref = await SharedPreferences.getInstance();
    String _uid = _pref.getString(kUid) ?? '';
    return _uid;
  }

  Future<void> verifyLogin() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'lang': ''
    };

    final response =
        await _network.post(url: 'eidupay/login/verify', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    _network.decrypt(bodyResponse);
  }

  Future<dynamic> _getOtp(String hp, String idAccount) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'hp': hp,
      'idAccount': idAccount,
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'lang': ''
    };

    final response =
        await _network.post(url: 'eidupay/login/getOtp', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);

    return jsonDecode(decryptedBody);
  }

  Future<DefaultModel> changeDevice(LoginRest loginRest, String otp) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'otp': otp,
      'phoneExtended': loginRest.hp,
      'tipe': _pref.getString(kUserType) ?? loginRest.tipe,
      'idAccount': _pref.getString(kUserId) ?? loginRest.idAccount,
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'lang': '',
      'versionCode': versionCode
    };

    final response =
        await _network.post(url: 'eidupay/login/changeDevice', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return DefaultModel.fromJson(decodedBody);
  }

  Future<void> _getOtpTap(LoginRest loginRest) async {
    EiduLoadingDialog.showLoadingDialog();
    await _getOtp(loginRest.hp, loginRest.idAccount);
    Get.back();

    await Get.toNamed(OtpPage.route.name, arguments: loginRest);
  }

  Future<LoginRest> _signIn() async {
    final _uid = await _getUid();
    final _pref = await SharedPreferences.getInstance();
    final _body = <String, dynamic>{
      'userName': contPhoneNumber.text,
      'phoneExtended': contPhoneNumber.text,
      'pin': contPin.text,
      'deviceInfo': _uid,
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
      final pin64 = base64.encode(utf8.encode(contPin.text));
      await _pref.setString(kUserId, loginModel.idAccount);
      await _pref.setString('userName', loginModel.nama);
      await _pref.setString(kUserType, loginModel.tipe);
      await _pref.setBool(kIsLoggedIn, true);
      if (loginModel.ack == 'OK') {
        if (_pref.getString(kHp) != contPhoneNumber.text ||
            _pref.getString(kHp) == null) {
          await _pref.setString(kHp, contPhoneNumber.text);
          await _pref.setBool(kIsAlreadyPrompted, false);
        }
        await _pref.setString(kPin, pin64);
      }
      return loginModel;
    } catch (e) {
      final model = DefaultModel.fromJson(dtUser);
      Get.back();
      if (model.pesan.contains('pin atau user salah')) {
        await _sendAnalyticsEvent('login_click',
            'Login gagal, pesan : Pin salah, pastikan kembali pin anda');
        await EiduInfoDialog.showInfoDialog(
            title: 'Pin salah, pastikan kembali pin anda');
        rethrow;
      }
      if (model.pesan.contains('Akun Member/Merchant tidak ditemukan')) {
        await EiduInfoDialog.showInfoDialog(title: 'Akun tidak ditemukan');
        rethrow;
      }
      await _sendAnalyticsEvent(
          'login_click', 'Login gagal, pesan : ' + model.pesan);
      await EiduInfoDialog.showInfoDialog(title: model.pesan);
      rethrow;
    }
  }

  Future<void> signInTap() async {
    if (formKey.currentState!.validate() == true) {
      await _sendAnalyticsEvent(
          'login_click', 'Login dengan ID : ' + contPhoneNumber.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          kLastLogin, contPhoneNumber.text); //simpan no hp terakhir login
      EiduLoadingDialog.showLoadingDialog();
      var dtLogin = await _signIn();
      Get.back();
      FocusScope.of(navigatorKey.currentContext!).requestFocus(FocusNode());
      if (dtLogin.ack == 'NOK') {
        await _handleNOKLogin(dtLogin);
        return;
      }
      if (dtUser['tipe'] == 'extended') {
        await Get.offAllNamed(SubHomePage.route.name);
      } else {
        await Get.offAllNamed(Home.route.name);
      }
    }
  }

  // Forgot Password Section
  Future<AccountInfo> _getDataUserForget() async {
    final _uid = await _getUid();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'idAccount': contPhoneNumber.text,
      'packageName': _package.packageName,
      'tipe': '',
      'lang': '',
      'deviceInfo': _uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/register/getAccountInfo', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      return AccountInfo.fromJson(decodedBody);
    } catch (e) {
      final model = DefaultModel.fromJson(decodedBody);
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: model.pesan);
      rethrow;
    }
  }

  Future<dynamic> _getVerifyOtp(DataDiri dataDiri, String otp) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'tipe': dataDiri.idTipeAccount,
      'otp': otp,
      'idAccount': dataDiri.idMember,
      'packageName': _package.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'lang': ''
    };
    final response =
        await _network.post(url: 'eidupay/login/verifyOtp', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    var res = jsonDecode(decryptedBody);
    return res;
  }

  Future<void> lupaPasswordTap() async {
    if (contPhoneNumber.text.isEmpty) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'No Handphone harus diisi!');
      return;
    }
    await _sendAnalyticsEvent(
        'lupa_password_click', 'Lupa password ID ' + contPhoneNumber.text);
    EiduLoadingDialog.showLoadingDialog();
    var response = await _getDataUserForget();
    Get.back();
    if (response.dataDiri.isEmpty) {
      await EiduInfoDialog.showInfoDialog(title: 'Data tidak ditemukan!');
      return;
    }
    final dataDiri = response.dataDiri.first;

    //simpan idAccount untuk reset API password
    String? tipeAkun;
    if (dataDiri.idTipeAccount == '1') tipeAkun = 'member';
    if (dataDiri.idTipeAccount == '2') tipeAkun = 'agent';

    dtUser = {
      'idAccount': dataDiri.idMember,
      'tipe': tipeAkun,
      'hp': contPhoneNumber.text
    };

    //member premium
    if (dataDiri.idStatusVerifikasi == '1' ||
        dataDiri.idStatusVerifikasi == '3') {
      final dataRandom = [
        {
          'pertanyaan': 'Masukkan nama ibu kandung',
          'jawaban': dataDiri.namaIbuKandung
        },
        {
          'pertanyaan': 'Masukkan nama lengkap sesuai KTP',
          'jawaban': dataDiri.nama
        },
        {
          'pertanyaan': 'Masukkan tanggal lahir (YYYY-MM-DD)',
          'jawaban': dataDiri.tanggalLahir
        },
        {
          'pertanyaan': 'Masukkan tempat lahir sesuai KTP',
          'jawaban': dataDiri.tempatLahir
        },
        {
          'pertanyaan': 'Masukkan email yang terdaftar di EiduPay',
          'jawaban': dataDiri.email
        },
        {
          'pertanyaan': 'Masukkan nomor Handphone yang terdaftar di EiduPay',
          'jawaban': dataDiri.handphone
        },
        {
          'pertanyaan': 'Masukkan nomor KTP yang terdaftar di EiduPay',
          'jawaban': dataDiri.nomorKtp
        },
      ];

      int x, y, z;
      do {
        var rnd1 = Random();
        x = rnd1.nextInt(6);
        y = rnd1.nextInt(6);
        z = rnd1.nextInt(6);
      } while (x == y || x == z || y == z);

      final pertanyaan = [
        dataRandom[x]['pertanyaan'],
        dataRandom[y]['pertanyaan'],
        dataRandom[z]['pertanyaan']
      ];

      final jawaban = [
        dataRandom[x]['jawaban'],
        dataRandom[y]['jawaban'],
        dataRandom[z]['jawaban']
      ];

      await Get.toNamed(SecurityQuestionPage.route.name,
          arguments: [pertanyaan, jawaban]);
    }

    //member regular
    if (dataDiri.idStatusVerifikasi == '2') {
      //req Otp
      EiduLoadingDialog.showLoadingDialog();
      var res = await _getOtp(dataDiri.handphone, dataDiri.idMember);
      Get.back();

      //ambil inputan otp user
      LoginRest resp = LoginRest(
          hp: dtUser['hp'],
          rc: '00',
          pesan: '',
          device: '',
          nama: '',
          tipe: dtUser['tipe'],
          idAccount: dtUser['idAccount'],
          dataInitiator: [],
          ack: 'OK');
      String otp = '';
      otp = await Get.toNamed(OtpPage.route.name, arguments: resp);
      if (otp.isEmpty) return;

      EiduLoadingDialog.showLoadingDialog();
      var verifyOtpRes = await _getVerifyOtp(dataDiri, otp);
      Get.back();
      if (verifyOtpRes['ACK'] == 'NOK') {
        await EiduInfoDialog.showInfoDialog(title: verifyOtpRes['pesan']);
        return;
      }
      await Get.toNamed(ResetPinPage.route.name);
    }
  }

  Future<bool> checkIsUseBiometric() async {
    final _pref = await SharedPreferences.getInstance();
    final isUseBiometric = _pref.getBool(kIsUseBiometric);
    final isUseFingerprint = _pref.getBool(kFingerprint);
    final isUseFaceId = _pref.getBool(kFaceId);
    if ((isUseBiometric != null && isUseBiometric) &&
            (isUseFingerprint != null && isUseFingerprint) ||
        (isUseFaceId != null && isUseFaceId)) this.isUseBiometric.value = true;
    await checkActiveBiometric();
    return this.isUseBiometric.value;
  }

  Future<void> checkActiveBiometric() async {
    final _authBiometric = LocalAuthentication();
    final availableBiometrics = await _authBiometric.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      biometricIcon.value = 'assets/images/face_id.png';
      return;
    }
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      biometricIcon.value = 'assets/images/touch_id.png';
      return;
    }
  }

  Future<void> biometricLogin() async {
    final _pref = await SharedPreferences.getInstance();
    final _c = Get.put(AuthController());
    if (_pref.getBool(kIsUseBiometric) == true) {
      final authed = await _c.authenticateBiometric();
      await _sendAnalyticsEvent(
          'login_click', 'Login dengan ID : ' + contPhoneNumber.text);
      Get.back();
      if (authed) {
        final pin64 = _pref.getString(kPin);
        contPhoneNumber.text = _pref.getString(kHp) ?? '';
        contPin.text = utf8.decode(base64Decode(pin64 ?? ''));
        EiduLoadingDialog.showLoadingDialog();
        var dtLogin = await _signIn();
        Get.back();
        if (dtLogin.ack == 'NOK') {
          await _handleNOKLogin(dtLogin);
          return;
        }
        await _pref.setBool(kIsAlreadyPrompted, true);
        if (dtUser['tipe'] == 'extended') {
          await Get.offAllNamed(SubHomePage.route.name);
        } else {
          await Get.offAllNamed(Home.route.name);
        }
      }
    }
  }

  Future<void> _handleNOKLogin(LoginRest dtLogin) async {
    if (dtLogin.rc == '01') {
      //device beda
      await _sendAnalyticsEvent(
          'login_click', 'Login ganti device ID : ' + contPhoneNumber.text);
      await EiduBottomSheet.showBottomSheet(
        title: 'Perhatian',
        description: dtLogin.pesan,
        icon: Icons.warning_rounded,
        iconColor: Colors.orange,
        buttonText: 'OK',
        onPressed: () async {
          Get.back();
          await _getOtpTap(dtLogin);
        },
      );
    } else {
      await _sendAnalyticsEvent(
          'login_click', 'Login gagal, pesan: ' + dtLogin.pesan);
      await EiduBottomSheet.showBottomSheet(
          title: 'Perhatian',
          description: dtLogin.pesan,
          icon: Icons.warning_rounded,
          iconColor: Colors.orange,
          buttonText: 'Kembali',
          onPressed: () => Get.back());
    }
  }

  Future<void> signUpTap() async {
    await _sendAnalyticsEvent('signup_click', 'User menekan tombol signUp');
    await Get.offNamed(Signup.route.name);
  }
}
