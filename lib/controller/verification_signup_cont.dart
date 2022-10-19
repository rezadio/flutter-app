import 'dart:async';
import 'package:eidupay/controller/signup_cont.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';

class VerificationSignupCont extends GetxController {
  var isComplete = false.obs;
  var waktuResend = 20;
  var tm = 20.obs;
  var phoneNumber;

  final _signUpController = Get.find<SignupCont>();
  late OTPTextEditController otpController;
  late OTPInteractor otpInteractor;

  @override
  void onInit() {
    super.onInit();
    starTimer();
    phoneNumber = _signUpController.contPhoneNumber.text;
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

  void resendCode() {
    tm.value = 20;
    starTimer();
  }

  void nextProcess(String nextPage) =>
      Get.toNamed(nextPage, arguments: const PageArgument(title: 'Top-up'));

  @override
  void dispose() {
    otpController.stopListen();
    otpController.dispose();
    super.dispose();
  }
}
