import 'package:eidupay/tools.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricSettingCont extends GetxController {
  final _authBiometric = LocalAuthentication();
  List<BiometricType> availableBiometrics = [];
  var widgets = <Widget>[].obs;
  var fingerprint = false.obs;
  var faceId = false.obs;

  Future<void> checkBiometrics(List<BiometricType> biometrics) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    final isUseFaceId = _sharedPreference.getBool(kFaceId);
    final isUseFingerprint = _sharedPreference.getBool(kFingerprint);
    if (biometrics.contains(BiometricType.face)) {
      if (isUseFaceId != null && isUseFaceId) {
        faceId.value = true;
      }
    } else if (biometrics.contains(BiometricType.fingerprint)) {
      if (isUseFingerprint != null && isUseFingerprint) {
        fingerprint.value = true;
      }
    }
  }

  void toggleFingerprint() async {
    final _sharedPreference = await SharedPreferences.getInstance();
    if (!fingerprint.value) {
      final authed = await _authBiometric.authenticate(
        localizedReason: 'Authenticate to Continue',
        useErrorDialogs: true,
        biometricOnly: true,
      );
      if (authed) {
        await _sharedPreference.setBool(kFingerprint, authed);
        await _sharedPreference.setBool(kIsUseBiometric, authed);
        fingerprint.value = authed;
      }
    } else {
      fingerprint.value = !fingerprint.value;
      await _sharedPreference.setBool(kFingerprint, fingerprint.value);
      await _sharedPreference.setBool(kIsUseBiometric, fingerprint.value);
      await _sharedPreference.setBool(kIsAlreadyPrompted, fingerprint.value);
      await _sharedPreference.setBool(kBiometricPin, fingerprint.value);
    }
  }

  void toggleFaceId() async {
    final _sharedPreference = await SharedPreferences.getInstance();
    if (!faceId.value) {
      final authed = await _authBiometric.authenticate(
        localizedReason: 'Authenticate to Continue',
        useErrorDialogs: true,
        biometricOnly: true,
      );
      if (authed) {
        await _sharedPreference.setBool(kFaceId, authed);
        await _sharedPreference.setBool(kIsUseBiometric, authed);
        faceId.value = authed;
      }
    } else {
      faceId.value = !faceId.value;
      await _sharedPreference.setBool(kFaceId, faceId.value);
      await _sharedPreference.setBool(kIsUseBiometric, faceId.value);
      await _sharedPreference.setBool(kIsAlreadyPrompted, faceId.value);
      await _sharedPreference.setBool(kBiometricPin, faceId.value);
    }
  }
}
