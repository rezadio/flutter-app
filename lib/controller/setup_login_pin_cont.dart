import 'package:eidupay/view/setup_login_pin_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetupLoginPinCont extends GetxController {
  TextEditingController contPin = TextEditingController();

  var showPin = false.obs;
  var isComplete = false.obs;

  void nextProcess(String code) {
    Get.to(() => SetupLoginPin2(prevCode: code));
  }
}
