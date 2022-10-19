import 'package:eidupay/controller/signup_cont.dart';
import 'package:eidupay/controller/verification_signup_cont.dart';
import 'package:eidupay/view/signup.dart';
import 'package:eidupay/view/success_signup.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetupLoginPinCont2 extends GetxController {
  final _contVerificationCode = Get.find<VerificationSignupCont>();
  final _signUpController = Get.find<SignupCont>();

  TextEditingController pinController = TextEditingController();

  var showPin = false.obs;
  var isComplete = false.obs;

  void selanjutnyaTap() async {
    EiduLoadingDialog.showLoadingDialog();
    final response = await _signUpController.register(
        _contVerificationCode.otpController.text, pinController.text);
    Get.back();
    if (response.ack == 'NOK') {
      // ignore: unawaited_futures
      Get.offAllNamed(Signup.route.name);
      await EiduInfoDialog.showInfoDialog(title: response.message);
      return;
    }
    _signUpController.contPin.text = pinController.text;
    await Get.toNamed(SuccessSignUp.route.name);
  }
}
