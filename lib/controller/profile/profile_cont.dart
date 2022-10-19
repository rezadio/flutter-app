import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eidupay/model/account.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/kyc/instruction_page.dart';
import 'package:eidupay/view/login.dart';
import 'package:eidupay/view/profile/about.dart';
import 'package:eidupay/view/profile/biometric_setting.dart';
import 'package:eidupay/view/profile/edit_profile.dart';
import 'package:eidupay/view/profile/faqs.dart';
import 'package:eidupay/view/profile/reset_pin.dart';
import 'package:eidupay/view/profile/support.dart';
import 'package:eidupay/view/profile/term_condition.dart';
import 'package:eidupay/view/sub_account/sub_account_list_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/app_config.dart';

class ProfileCont extends GetxController {
  final Network _network;
  ProfileCont(this._network);

  var nama = '';
  var noHp = '';
  late String cookie;
  late String uid;
  var inProccess = false.obs;
  var fotoProfile = ''.obs;
  var photoWidget = <ImageProvider>[].obs;
  BalanceModel? balance;
  late Account account;

  @override
  void onInit() async {
    super.onInit();
    inProccess(true);

    nama = dtUser['nama'];
    noHp = dtUser['hp'];
    await getCookie();
    await getUid();
    balance = await getBalance();

    inProccess(false);
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<BalanceModel> getBalance() async => await _network.getBalance();

  void subAccountTap() => Get.toNamed(SubAccountListPage.route.name);

  void getProfilePicture(String fotoProfile) {
    final baseUrl = injector.get<AppConfig>().baseUrl;
    if (fotoProfile.isNotEmpty) {
      try {
        photoWidget.assign(CachedNetworkImageProvider(
            '$baseUrl:$port/eidupay/home/getPicProfile/' + fotoProfile));
      } catch (_) {
        photoWidget
            .assign(const AssetImage('assets/images/default_profile.png'));
        rethrow;
      }
    } else {
      photoWidget.assign(const AssetImage('assets/images/default_profile.png'));
    }
  }

  Future<void> getAccountInfo() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/account/getAccountInfo', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final accountModel = AccountModel.fromJson(decodedBody);
    dtUser = jsonDecode(_pref.getString(kDtUser) ?? '');
    account = accountModel.data.first;
  }

  void verifyTap(BuildContext context) =>
      Get.toNamed(InstructionPage.route.name,
          arguments: PageArgument.kycPage1());

  Future<void> biometricTap() async {
    try {
      final _authBiometric = LocalAuthentication();
      final availableBiometrics = await _authBiometric.getAvailableBiometrics();
      await Get.toNamed(BiometricSettingPage.route.name,
          arguments: availableBiometrics);
    } catch (_) {
      await EiduInfoDialog.showInfoDialog(title: 'Terjadi kendala, coba lagi.');
    }
  }

  void termTap() {
    Get.to(() => const TermsCondition());
  }

  void aboutTap() {
    Get.to(() => const AboutPage());
  }

  Future<void> editTap(Account account) async {
    await Get.toNamed(EditProfile.route.name, arguments: account)
        ?.then((value) async {
      await getAccountInfo();
      getProfilePicture(this.account.fotoProfile);
    });
  }

  void resetPin() {
    Get.to(() => const ResetPin());
  }

  void faqTap() {
    Get.to(() => const Faqs());
  }

  void support() async {
    await Get.toNamed(SupportPage.route.name);
  }

  void deleteTap(BuildContext context) {
    showCupertinoModalPopup(
        context: context, builder: (context) => warningDelete(context));
  }

  void logoutTap(BuildContext context) {
    warningLogout(context);
  }

  Widget warningDelete(BuildContext context) => CupertinoActionSheet(
        message: Column(
          children: [
            Container(
              width: w(65),
              height: 5,
              color: Colors.grey[350],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: w(82),
              height: w(82),
              child: Image.asset('assets/images/ico_delete_btm.png'),
            ),
            const SizedBox(height: 22),
            Text(
              'Hapus akun ?',
              style: TextStyle(
                  fontSize: w(20), fontWeight: FontWeight.w700, color: blue),
            ),
            const SizedBox(height: 10),
            Text(
              'Apakah anda yakin akan menghapus akun ini ?',
              style: TextStyle(
                  fontSize: w(18), fontWeight: FontWeight.w400, color: t70),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                SizedBox(width: w(30)),
                GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Hapus',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    )),
                SizedBox(width: w(30)),
                Expanded(
                    child: SubmitButton(
                  backgroundColor: green,
                  text: 'Batal',
                  onPressed: () => Get.back(),
                ))
              ],
            )
          ],
        ),
      );

  void warningLogout(BuildContext context) =>
      EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Keluar dari akun?',
        description: 'Apakan anda yakin akan keluar dari akun ini?',
        imageUrl: 'assets/images/ico_logout_btm.png',
        firstButtonText: 'Keluar',
        firstButtonOnPressed: () async {
          final _pref = await SharedPreferences.getInstance();
          await _pref.setBool(kIsLoggedIn, false);
          await Get.offAllNamed(Login.route.name);
        },
        secondButtonText: 'Batal',
        secondaryColor: green,
        secondButtonOnPressed: () {
          Get.back();
        },
      );

  Future<dynamic> getDataUserForget() async {
    await getUid();
    final _package = await PackageInfo.fromPlatform();
    await getCookie();
    final header = {'Cookie': cookie.toString()};
    final _body = <String, dynamic>{
      'idAccount': noHp,
      'packageName': _package.packageName,
      'tipe': '',
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/account/getAccountInfo', header: header, body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    return decryptedBody;
  }
}
