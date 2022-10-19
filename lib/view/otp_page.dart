import 'dart:io' show Platform;

import 'package:eidupay/controller/otp_page_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/login.dart';
import 'package:eidupay/widget/eidu_pin_code_field.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:otp_autofill/otp_autofill.dart';

class OtpPage extends StatefulWidget {
  static final route = GetPage(name: '/otp_page', page: () => const OtpPage());
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _c = Get.put(OtpPageCont(injector.get()));
  final LoginRest loginRest = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.loginRest = loginRest;

    if (Platform.isIOS) {
      _c.otpController = OTPTextEditController(
        codeLength: 6,
        onCodeReceive: (code) => debugPrint('Received code - $code'),
      );
    } else {
      _c.otpInteractor = OTPInteractor();
      _c.otpInteractor
          .getAppSignature()
          .then((value) => debugPrint('signature - $value'));

      _c.otpController = OTPTextEditController(
        codeLength: 6,
        onCodeReceive: (code) => debugPrint('Received code - $code'),
        otpInteractor: _c.otpInteractor,
      )..startListenUserConsent(
          (code) {
            final exp = RegExp(r'(\d{6})');
            return exp.stringMatch(code ?? '') ?? '';
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 33, right: 33),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode\nVerifikasi',
                    style: TextStyle(
                        fontSize: w(30), fontWeight: FontWeight.bold)),
                SizedBox(height: h(8)),
                const SmallDivider(),
                SizedBox(height: w(13)),
                Text('Kami sudah mengirim kode verifikasi ke',
                    style: TextStyle(fontSize: w(14), color: t70)),
                SizedBox(height: h(8)),
                Row(
                  children: [
                    Text(loginRest.hp,
                        style: TextStyle(fontSize: w(14), color: blue)),
                    SizedBox(width: w(15)),
                  ],
                ),
                SizedBox(height: h(62)),
                EiduPinCodeTextField(
                  animationDuration: const Duration(milliseconds: 300),
                  controller: _c.otpController,
                  onChanged: (value) async {},
                  onCompleted: (value) {
                    _c.isComplete(true);
                    _c.onComplete(loginRest, value);
                  },
                ),
                // PinFieldAutoFill(),
                SizedBox(height: h(63)),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => _c.tm.value > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Kirim ulang kode pada 0:',
                              style: TextStyle(fontSize: w(14), color: t70),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              _c.tm.value.toString().padLeft(2, '0'),
                              style: TextStyle(fontSize: w(14), color: t70),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () => _c.resendCode(),
                          child: Text(
                            'Kirim ulang kode',
                            style: TextStyle(
                                fontSize: w(14),
                                color: green,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,
                          ),
                        )),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
