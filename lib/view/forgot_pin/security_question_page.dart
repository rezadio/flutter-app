import 'package:eidupay/controller/forgot_password_controller.dart';
import 'package:eidupay/controller/login_cont.dart';
import 'package:eidupay/view/forgot_pin/reset_pin_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_bottom_sheet.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class SecurityQuestionPage extends StatefulWidget {
  static final route = GetPage(
      name: '/security-question', page: () => const SecurityQuestionPage());
  const SecurityQuestionPage({Key? key}) : super(key: key);

  @override
  _SecurityQuestionPageState createState() => _SecurityQuestionPageState();
}

class _SecurityQuestionPageState extends State<SecurityQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(body: _BodySecurityQuestionPage()),
    );
  }
}

class _BodySecurityQuestionPage extends StatefulWidget {
  const _BodySecurityQuestionPage({Key? key}) : super(key: key);

  @override
  __BodySecurityQuestionPageState createState() =>
      __BodySecurityQuestionPageState();
}

class __BodySecurityQuestionPageState extends State<_BodySecurityQuestionPage> {
  final _forgotPasswordController = Get.put(ForgotPasswordController());
  var contLogin = Get.find<LoginCont>();
  List questions = Get.arguments[0];
  List answers = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              height: 38,
              image: AssetImage('assets/images/logo_eidupay.png'),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Lupa\nPIN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                SmallDivider(),
              ],
            ),
            const SizedBox(height: 32),
            Form(
              key: _forgotPasswordController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pertanyaan Keamanan (${_forgotPasswordController.questionNumber.value + 1}/${questions.length})',
                          style: const TextStyle(color: Color(0xFFD5D5DC)),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              border:
                                  Border.all(color: const Color(0xFFEAEAEA))),
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            questions[
                                _forgotPasswordController.questionNumber.value],
                            style: const TextStyle(fontSize: 16, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _forgotPasswordController.answerController,
                        decoration:
                            mainInputDecoration.copyWith(labelText: 'Jawaban'),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _forgotPasswordController.isButtonDisable.value =
                                false;
                          }
                          if (value.isEmpty) {
                            _forgotPasswordController.isButtonDisable.value =
                                true;
                          }
                        },
                        validator: (value) {
                          if (value!.toLowerCase() !=
                              answers[_forgotPasswordController
                                      .questionNumber.value]
                                  .toLowerCase()) {
                            return 'Jawaban salah';
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 52),
                  Obx(
                    () => SubmitButton(
                      text: 'Lanjutkan',
                      backgroundColor:
                          _forgotPasswordController.isButtonDisable.value
                              ? const Color(0xFFC8F0EC)
                              : const Color(0xFF44CCC0),
                      onPressed: _forgotPasswordController.isButtonDisable.value
                          ? null
                          : () {
                              if (_forgotPasswordController.formKey.currentState
                                      ?.validate() ==
                                  true) {
                                if (_forgotPasswordController
                                            .questionNumber.value +
                                        1 ==
                                    questions.length) {
                                  Get.offNamed(ResetPinPage.route.name);
                                  return;
                                }
                                _forgotPasswordController
                                    .questionNumber.value++;
                                _forgotPasswordController.answerController
                                    .clear();
                                _forgotPasswordController
                                    .isButtonDisable.value = true;
                              } else {
                                EiduBottomSheet.showBottomSheet(
                                    title: 'Gagal',
                                    description:
                                        'Silahkan periksa kembali jawaban anda',
                                    icon: Icons.warning,
                                    iconColor: Colors.orange,
                                    buttonText: 'Okay',
                                    onPressed: () {
                                      Get.back();
                                    });
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
