import 'package:eidupay/controller/profile/biometric_setting_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BiometricSettingPage extends StatelessWidget {
  const BiometricSettingPage({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/profile/biometric', page: () => BiometricSettingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Biometric')),
        body: _BodyBiometricSettingPage());
  }
}

class _BodyBiometricSettingPage extends StatefulWidget {
  _BodyBiometricSettingPage({Key? key}) : super(key: key);

  @override
  __BodyBiometricSettingPageState createState() =>
      __BodyBiometricSettingPageState();
}

class __BodyBiometricSettingPageState extends State<_BodyBiometricSettingPage> {
  final _c = Get.put(BiometricSettingCont());
  final List<BiometricType> availableBiometrics = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.checkBiometrics(availableBiometrics);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Obx(() => Column(children: buildBiometricWidget())),
      ),
    );
  }

  List<Widget> buildBiometricWidget() {
    if (availableBiometrics.isNotEmpty) {
      if (availableBiometrics.contains(BiometricType.face))
        _c.widgets.assign(
          _BiometricToggleWidget(
            text: 'Face ID',
            value: _c.faceId.value,
            onToggle: (value) => _c.toggleFaceId(),
          ),
        );
      _c.widgets.add(SizedBox(height: 10));
      if (availableBiometrics.contains(BiometricType.fingerprint))
        _c.widgets.assign(
          _BiometricToggleWidget(
            text: 'Fingerprint',
            value: _c.fingerprint.value,
            onToggle: (value) => _c.toggleFingerprint(),
          ),
        );
      _c.widgets.add(SizedBox(height: 10));
    } else {
      _c.widgets.assign(Text('Tidak ada biometric tersedia.'));
    }
    return _c.widgets;
  }
}

class _BiometricToggleWidget extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool) onToggle;
  const _BiometricToggleWidget(
      {Key? key,
      required this.text,
      required this.value,
      required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(text)),
        FlutterSwitch(
          value: value,
          onToggle: onToggle,
          duration: Duration(milliseconds: 150),
        ),
      ],
    );
  }
}
