import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MerchantInfoCont extends GetxController {
  void copyData(String va) {
    Get.snackbar(
      'Eidupay',
      'Data has been copied to the clipboard',
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
