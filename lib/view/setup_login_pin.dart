import 'dart:ui';

import 'package:eidupay/controller/setup_login_pin_cont.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/eidu_pin_code_field.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class SetupLoginPin extends StatelessWidget {
  static final route =
      GetPage(name: '/setup-login-pin', page: () => const SetupLoginPin());

  const SetupLoginPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SetupLoginPinCont());
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
                  Text('PIN\nLogin',
                      style: TextStyle(
                          fontSize: w(30), fontWeight: FontWeight.bold)),
                  SizedBox(height: w(8)),
                  const SmallDivider(),
                  SizedBox(height: w(62)),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Masukkan 6 digit pin',
                      style: TextStyle(
                          fontSize: w(17), fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: w(32)),
                  Obx(() => EiduPinCodeTextField(
                        obscureText: !c.showPin.value,
                        animationDuration: const Duration(milliseconds: 300),
                        controller: c.contPin,
                        onChanged: (value) {
                          c.isComplete(false);
                        },
                        onCompleted: (v) {
                          c.isComplete(true);
                          c.nextProcess(c.contPin.text);
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      )),
                  SizedBox(height: w(32)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => IconButton(
                          onPressed: () {
                            c.showPin.value = !c.showPin.value;
                          },
                          icon: Icon(
                            c.showPin.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: c.showPin.value ? green : Colors.grey,
                          ))),
                    ],
                  ),
                  SizedBox(height: h(63)),
                  Obx(() => SubmitButton(
                        backgroundColor:
                            !c.isComplete.value ? disabledGreen : green,
                        text: 'Selanjutnya',
                        onPressed: !c.isComplete.value
                            ? null
                            : () => c.nextProcess(c.contPin.text),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
