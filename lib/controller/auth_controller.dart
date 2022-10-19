import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final authBiometric = LocalAuthentication();
  String resultText = '';

  Future<bool> authenticateBiometric() async {
    final availableBiometrics = await authBiometric.getAvailableBiometrics();
    final _sharedPreference = await SharedPreferences.getInstance();
    if (availableBiometrics.contains(BiometricType.face)) {
      try {
        final authed = await authBiometric.authenticate(
          localizedReason: 'Authenticate to Continue',
          useErrorDialogs: true,
          biometricOnly: true,
        );
        if (authed) {
          await _sharedPreference.setBool(kFaceId, true);
          return authed;
        }
      } on PlatformException catch (_) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Too many attempts!',
            description: 'Please try again in 30 seconds');
      }
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      try {
        final authed = await authBiometric.authenticate(
          localizedReason: 'Authenticate to Continue',
          biometricOnly: true,
        );
        if (authed) {
          await _sharedPreference.setBool(kFingerprint, true);
          return authed;
        }
      } on PlatformException catch (_) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Too many attempts!',
            description: 'Please try again in 30 seconds');
      }
    }
    return false;
  }

  void authenticateVoice() {
    //TODO: implement once api ready
  }
}
