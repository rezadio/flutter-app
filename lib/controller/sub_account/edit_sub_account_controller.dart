import 'dart:convert';

import 'package:eidupay/controller/sub_account/sub_account_detail_controller.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/sub_account/sub_account_reset_pin.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSubAccountController extends GetxController {
  final Network _network;
  EditSubAccountController(this._network);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final confirmPinController = TextEditingController();

  var isPasswordHide = true.obs;
  var isConfirmPasswordHide = true.obs;
  var isPinHide = true.obs;
  var isConfirmPinHide = true.obs;
  var relationshipValue;
  var cookie;
  var uid;

  final _detailCont = Get.find<SubAccountDetailController>();
  var hasChange = false.obs;

  @override
  void onInit() async {
    super.onInit();
    nameController.text = _detailCont.detail.name;
    emailController.text = _detailCont.detail.email;
    relationshipValue = _detailCont.detail.relation;
    phoneController.text = _detailCont.detail.phone;
    await getUid();
    await getCookie();
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<dynamic> pay(inquiry, String pin) async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'phoneExtended': phoneController.text,
      'nameExtended': nameController.text,
      'relationExtended': relationshipValue,
      'idExt': _detailCont.detail.idExt.toString(),
      'emailExtended': emailController.text,
      'tipe': dtUser['tipe'],
      'pin': pin,
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/extended/updatePersonal', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> simpanTap() async {
    if (formKey.currentState?.validate() == true) {
      List<dynamic>? results = await Get.to(
        () =>
            PinVerificationPage<EditSubAccountController>(pageController: this),
        arguments: null,
      );

      final bool? isSuccess = results?[0];

      if (isSuccess != null && isSuccess) {
        FocusScope.of(navigatorKey.currentContext!).requestFocus(FocusNode());
        Get.back();
        await EiduInfoDialog.showInfoDialog(
            title: 'Data sub account berhasil diperbaharui',
            icon: 'assets/lottie/success.json');
      }
    }
  }

  void resetPin() {
    Get.toNamed(SubAccountResetPin.route.name);
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
