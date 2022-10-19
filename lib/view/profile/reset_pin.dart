import 'package:eidupay/controller/profile/reset_pin_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class ResetPin extends StatelessWidget {
  const ResetPin({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/reset_pin', page: () => const ResetPin());
  @override
  Widget build(BuildContext context) {
    final _c = Get.put(ResetPinCont(injector.get()));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset PIN')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                SizedBox(height: h(36)),
                SizedBox(height: h(24)),
                Form(
                    key: _c.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PIN Lama',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t60),
                        ),
                        Obx(() => TextFormField(
                            controller: _c.contPinLama,
                            obscureText: _c.hidePinLama.value,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == '') {
                                return 'Pin lama harus diisi!';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: mainInputDecoration.copyWith(
                              hintText: 'Masukkan pin lama',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    _c.hidePinLama.value =
                                        !_c.hidePinLama.value;
                                  },
                                  child: Icon(
                                      (_c.hidePinLama.value)
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color:
                                          !_c.hidePinLama.value ? green : t50)),
                            ))),
                        SizedBox(height: h(40)),
                        Text(
                          'Masukan PIN BARU Anda',
                          style: TextStyle(
                              fontSize: w(18),
                              fontWeight: FontWeight.w400,
                              color: blue),
                        ),
                        SizedBox(height: h(15)),
                        Text(
                          'PIN Baru',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t60),
                        ),
                        Obx(() => TextFormField(
                            controller: _c.contPinBaru,
                            obscureText: _c.hidePinBaru.value,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == '') return 'Pin baru harus diisi!';
                              if (value!.length != 6) {
                                return 'Pin baru harus 6 digit';
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: mainInputDecoration.copyWith(
                              hintText: 'Masukkan pin baru',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    _c.hidePinBaru.value =
                                        !_c.hidePinBaru.value;
                                  },
                                  child: Icon(
                                      (_c.hidePinBaru.value)
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color:
                                          !_c.hidePinBaru.value ? green : t50)),
                            ))),
                        SizedBox(height: h(15)),
                        Text(
                          'Konfirmasi PIN Baru',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t60),
                        ),
                        Obx(() => TextFormField(
                            controller: _c.contKonfirmPinBaru,
                            obscureText: _c.hideKonfirmasiPinBaru.value,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == '') {
                                return 'Konfirmasi PIN baru harus diisi!';
                              }
                              if (value != _c.contPinBaru.text) {
                                return 'Konfirmasi salah!';
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: mainInputDecoration.copyWith(
                              hintText: 'Masukkan konfirmasi pin baru',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    _c.hideKonfirmasiPinBaru.value =
                                        !_c.hideKonfirmasiPinBaru.value;
                                  },
                                  child: Icon(
                                      (_c.hideKonfirmasiPinBaru.value)
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: !_c.hideKonfirmasiPinBaru.value
                                          ? green
                                          : t50)),
                            ))),
                        SizedBox(height: h(50)),
                        SubmitButton(
                          backgroundColor: green,
                          text: 'Reset PIN',
                          onPressed: () => _c.resetTap(),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
