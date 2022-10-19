import 'package:eidupay/controller/sub_account/sub_account_reset_pin_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SubAccountResetPin extends StatelessWidget {
  const SubAccountResetPin({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/sub_account_reset_pin', page: () => const SubAccountResetPin());

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(SubAccountResetPinCont(injector.get()));
    return Scaffold(
      appBar: AppBar(title: const Text('Reset PIN Sub Account')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomTextFormField(
                        controller: _controller.pinController,
                        title: 'Log In PIN',
                        hintText: 'Masukkan PIN',
                        obscureText: _controller.isPinHide.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        suffixIcon: GestureDetector(
                          child: _controller.isPinHide.value
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.visibility, color: green),
                          onTap: () {
                            _controller.isPinHide.value =
                                !_controller.isPinHide.value;
                          },
                        ),
                        validator: pinValidator,
                      ),
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: _controller.konfirmPinController,
                        title: 'Konfirmasi Log In PIN',
                        hintText: 'Masukkan PIN',
                        obscureText: _controller.isKonfirmPinHide.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        suffixIcon: GestureDetector(
                          child: _controller.isKonfirmPinHide.value
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.visibility, color: green),
                          onTap: () {
                            _controller.isKonfirmPinHide.value =
                                !_controller.isKonfirmPinHide.value;
                          },
                        ),
                        validator: (val) {
                          if (_controller.pinController.text != val) {
                            return 'Konfirmasi PIN tidak sesuai!';
                          }
                        },
                      ),
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: _controller.pinParentController,
                        title: 'PIN Parent',
                        hintText: 'Masukkan PIN',
                        obscureText: _controller.isPinParentHide.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        suffixIcon: GestureDetector(
                          child: _controller.isPinParentHide.value
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.visibility, color: green),
                          onTap: () {
                            _controller.isPinParentHide.value =
                                !_controller.isPinParentHide.value;
                          },
                        ),
                        validator: pinValidator,
                      ),
                    ),
                    SubmitButton(
                      backgroundColor: green,
                      text: 'Simpan',
                      onPressed: () => _controller.simpanTap(),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
