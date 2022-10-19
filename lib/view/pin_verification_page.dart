import 'package:eidupay/controller/pin_verification_controller.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/eidu_pin_code_field.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class PinVerificationPage<T> extends StatefulWidget {
  final T? pageController;
  static final route = GetPage(
      name: '/pin-verification/', page: () => const PinVerificationPage());
  const PinVerificationPage({Key? key, this.pageController}) : super(key: key);

  @override
  _PinVerificationPageState createState() => _PinVerificationPageState();
}

class _PinVerificationPageState extends State<PinVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: _BodyPinVerificationPage(pageController: widget.pageController),
      ),
    );
  }
}

class _BodyPinVerificationPage<T> extends StatefulWidget {
  final T? pageController;

  const _BodyPinVerificationPage({Key? key, this.pageController})
      : super(key: key);

  @override
  __BodyPinVerificationPageState createState() =>
      __BodyPinVerificationPageState();
}

class __BodyPinVerificationPageState extends State<_BodyPinVerificationPage> {
  final _getController = Get.put(PinVerificationController());
  final _inquiry = Get.arguments;

  @override
  void initState() {
    super.initState();
    _getController.biometric();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = widget.pageController;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pin\nVerifikasi',
              style: TextStyle(fontSize: w(24), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SmallDivider(),
            SizedBox(height: h(56)),
            Column(
              children: [
                const Text('Masukkan 6 digit pin'),
                SizedBox(height: h(32)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27.0),
                  child: Form(
                    key: _getController.formKey,
                    child: Obx(
                      () => EiduPinCodeTextField(
                        controller: _getController.pinController,
                        obscureText: _getController.isHide.value,
                        onCompleted: (value) {
                          _getController.pin.value = value;
                          _getController.process(
                            pageController: pageController,
                            inquiry: _inquiry,
                            pin: value,
                          );
                        },
                        validator: (value) {
                          if (value != null && value.length < 6) {
                            return '';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(
                        _getController.isHide.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color:
                            _getController.isHide.value ? Colors.grey : green),
                    onPressed: () {
                      _getController.isHide.value =
                          !_getController.isHide.value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: h(24)),
            SubmitButton(
              text: 'Verifikasi',
              backgroundColor: green,
              onPressed: () {
                if (_getController.formKey.currentState?.validate() == true) {
                  _getController.process(
                    pageController: pageController,
                    inquiry: _inquiry,
                    pin: _getController.pinController.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
