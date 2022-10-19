import 'dart:convert';

import 'package:eidupay/controller/auth_controller.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinVerificationController extends GetxController {
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var pin = ''.obs;
  var isHide = true.obs;

  Future<void> biometric() async {
    final _c = Get.put(AuthController());
    final _pref = await SharedPreferences.getInstance();

    final isUseBiometric = _pref.getBool(kIsUseBiometric) ?? false;
    final biometricPin = _pref.getBool(kBiometricPin) ?? false;

    if (isUseBiometric) {
      if (!biometricPin) {
        final isConfirm = await EiduConfirmationBottomSheet.showBottomSheet(
            title: 'Biometric',
            description:
                'Apakah ingin mengaktifkan biometric untuk mengisi PIN?',
            secondaryColor: green,
            firstButtonText: 'Tidak',
            secondButtonText: 'Iya',
            firstButtonOnPressed: () {
              Get.back(result: false);
            },
            secondButtonOnPressed: () {
              Get.back(result: true);
            });
        if (isConfirm) {
          final biometric = await _c.authenticateBiometric();
          if (biometric) {
            await _pref.setBool(kBiometricPin, biometric);
            await EiduInfoDialog.showInfoDialog(
                title: 'Berhasil!', icon: 'assets/lottie/success.json');
            final pin64 = _pref.getString(kPin);
            final pin = utf8.decode(base64Decode(pin64 ?? ''));
            pinController.text = pin;
          }
        }
      } else {
        final biometric = await _c.authenticateBiometric();
        if (biometric) {
          final pin64 = _pref.getString(kPin);
          final pin = utf8.decode(base64Decode(pin64 ?? ''));
          pinController.text = pin;
        }
      }
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    pinController.dispose();
    super.dispose();
  }

  Future<void> process({
    required dynamic pageController,
    required dynamic inquiry,
    required String pin,
  }) async {
    try {
      EiduLoadingDialog.showLoadingDialog();
      final payResponse = await pageController.pay(inquiry, pin);

      Get.back();
      if (payResponse['ACK'] == 'NOK') {
        //if transfer failed.
        pinController.clear();
        await EiduInfoDialog.showInfoDialog(title: payResponse['pesan']);
        return;
      }
      Get.back(result: [true, payResponse]);
    } catch (_) {
      debugPrint(_.toString());
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: 'Terjadi kesalahan.');
      rethrow;
    }
  }
}
