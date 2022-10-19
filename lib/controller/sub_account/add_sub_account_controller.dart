import 'dart:convert';

import 'package:eidupay/controller/sub_account/sub_accunt_list_cont.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSubAccountController extends GetxController {
  final Network _network;
  AddSubAccountController(this._network);

  var isPasswordHide = true.obs;
  var isConfirmPasswordHide = true.obs;
  var isPinHide = true.obs;
  var isKonfirmPinHide = true.obs;
  var relationshipValue;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final schoolController = TextEditingController();
  final classController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pinController = TextEditingController();
  final konfirmPinController = TextEditingController();

  var cookie;
  var uid;
  var resAddSubAccount;
  final _contList = Get.find<SubAccountListCont>();

  @override
  void onInit() async {
    super.onInit();
    await getUid();
    await getCookie();
    relationshipValue = '';
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<dynamic> pay(dynamic, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'phoneExtended': phoneController.text,
      'nameExtended': nameController.text,
      'relationExtended': relationshipValue,
      'pinExt': pinController.text,
      'emailExtended': emailController.text,
      'tipe': dtUser['tipe'],
      'pin': pin,
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/addExtended', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> simpanTap() async {
    if (formKey.currentState!.validate()) {
      if (relationshipValue == '' || relationshipValue.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Hubungan harus diisi!');
        return;
      }
      List<dynamic>? results = await Get.to(
        () =>
            PinVerificationPage<AddSubAccountController>(pageController: this),
        arguments: null,
      );
      final bool? isSuccess = results?[0];
      final resAddSubAccount = results?[1];

      if (isSuccess != null && isSuccess) {
        await _contList.getListExtUser();
        Get.back();
        await EiduInfoDialog.showInfoDialog(
            title: resAddSubAccount['pesan'],
            icon: 'assets/lottie/success.json');
      }
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    nameController.dispose();
    emailController.dispose();
    schoolController.dispose();
    classController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
