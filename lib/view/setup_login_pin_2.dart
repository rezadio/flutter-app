import 'package:eidupay/controller/setup_login_pin_cont_2.dart';
import 'package:eidupay/widget/buttomWarning.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/eidu_pin_code_field.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class SetupLoginPin2 extends StatelessWidget {
  static final route =
      GetPage(name: '/setup-login-pin-2', page: () => SetupLoginPin2());

  SetupLoginPin2({Key? key, this.prevCode = ''}) : super(key: key);
  final String prevCode;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SetupLoginPinCont2());
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
                  Text('Konfirmasi PIN Login',
                      style: TextStyle(
                          fontSize: w(30), fontWeight: FontWeight.bold)),
                  SizedBox(height: w(8)),
                  const SmallDivider(),
                  SizedBox(height: w(62)),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Masukkan PIN kembali',
                      style: TextStyle(
                          fontSize: w(17), fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: w(32)),
                  Obx(() => EiduPinCodeTextField(
                        obscureText: !c.showPin.value,
                        animationDuration: const Duration(milliseconds: 300),
                        controller: c.pinController,
                        onChanged: (value) {
                          c.isComplete(false);
                        },
                        onCompleted: (v) async {
                          c.isComplete(true);
                          if (prevCode != c.pinController.text) {
                            await showCupertinoModalPopup(
                                context: context,
                                builder: (context) => warning);
                            return;
                          }

                          c.selanjutnyaTap();
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
                  Obx(
                    () => SubmitButton(
                        text: 'Selanjutnya',
                        backgroundColor:
                            !c.isComplete.value ? disabledGreen : green,
                        onPressed: !c.isComplete.value
                            ? null
                            : () async {
                                if (prevCode != c.pinController.text) {
                                  await showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) => warning);
                                  return;
                                }
                                c.selanjutnyaTap();
                              }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final warning = BtmWarning(
    icon: Icons.warning,
    title: 'Perhatian!',
    message: 'PIN tidak sama, mohon cek kembali',
    buttonTittle: 'OK',
  );
}
