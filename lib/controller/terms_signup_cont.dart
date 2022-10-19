import 'package:eidupay/controller/signup_cont.dart';
import 'package:eidupay/view/setup_login_pin.dart';
import 'package:eidupay/view/verification_signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermSignupCont extends GetxController {
  final _signUpController = Get.find<SignupCont>();
  var termsAgree = false.obs;

  Future<void> buatAkunTap(BuildContext context) async {
    try {
      await _signUpController.getOtpRegister();
      await Get.to(
        () => VerificationSignUp(nextPage: SetupLoginPin.route.name),
      );
    } catch (e) {
      rethrow;
    }
  }
}
