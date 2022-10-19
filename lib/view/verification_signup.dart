import 'dart:io' show Platform;

import 'package:eidupay/controller/verification_signup_cont.dart';
import 'package:eidupay/view/setup_login_pin.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/eidu_pin_code_field.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:otp_autofill/otp_autofill.dart';

class VerificationSignUp extends StatefulWidget {
  const VerificationSignUp({Key? key, required this.nextPage})
      : super(key: key);
  final String nextPage;

  static final route = GetPage(
      name: '/verification-signup',
      page: () => VerificationSignUp(nextPage: SetupLoginPin.route.name));

  @override
  _VerificationSignUpState createState() => _VerificationSignUpState();
}

class _VerificationSignUpState extends State<VerificationSignUp> {
  final _c = Get.put(VerificationSignupCont());

  @override
  void initState() {
    super.initState();

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 33, right: 33),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kode\nVerifikasi',
                  style:
                      TextStyle(fontSize: w(30), fontWeight: FontWeight.bold)),
              SizedBox(height: h(8)),
              SmallDivider(),
              SizedBox(height: w(13)),
              Text('Kami sudah mengirim kode verifikasi ke',
                  style: TextStyle(fontSize: w(14), color: t70)),
              SizedBox(height: h(8)),
              Row(
                children: [
                  Text(_c.phoneNumber,
                      style: TextStyle(fontSize: w(14), color: blue)),
                  SizedBox(width: w(15)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                    child: Text(
                      'Ubah',
                      style: TextStyle(
                          fontSize: w(14),
                          color: green,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h(62)),
              EiduPinCodeTextField(
                animationDuration: const Duration(milliseconds: 300),
                controller: _c.otpController,
                onChanged: (value) async {
                  _c.isComplete(false);
                },
                onCompleted: (v) {
                  _c.isComplete(true);
                  _c.nextProcess(widget.nextPage);
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              // PinFieldAutoFill(
              //   onCodeChanged: (value) {
              //     if (value != null && value.length == 6) {
              //       FocusScope.of(context).requestFocus(FocusNode());
              //     }
              //   },
              // ),
              SizedBox(height: h(63)),
              Obx(() => SubmitButton(
                    backgroundColor:
                        !_c.isComplete.value ? disabledGreen : green,
                    text: 'Selanjutnya',
                    onPressed: !_c.isComplete.value
                        ? null
                        : () => _c.nextProcess(widget.nextPage),
                  )),
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
    );
  }
}
