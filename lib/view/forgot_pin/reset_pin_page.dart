import 'package:eidupay/controller/forgot_password_controller.dart';
import 'package:eidupay/controller/profile/reset_password_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResetPinPage extends StatefulWidget {
  static final route =
      GetPage(name: '/reset-pin', page: () => const ResetPinPage());
  const ResetPinPage({Key? key}) : super(key: key);

  @override
  _ResetPinPageState createState() => _ResetPinPageState();
}

class _ResetPinPageState extends State<ResetPinPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(body: _BodyResetPasswordPage()),
    );
  }
}

class _BodyResetPasswordPage extends StatelessWidget {
  _BodyResetPasswordPage({Key? key}) : super(key: key);
  final _forgotPasswordController = Get.put(ForgotPasswordController());
  final _c = Get.put(ResetPasswordCont(injector.get()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
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
                'Reset\nPIN',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SmallDivider(),
            ],
          ),
          const SizedBox(height: 32),
          Form(
            key: _c.formKey,
            child: Column(
              children: [
                Obx(
                  () => TextFormField(
                    controller: _c.passwordController,
                    maxLength: 6,
                    obscureText: _forgotPasswordController.isPasswordHide.value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Password baru harus diisi.';
                      }
                      if (value!.length != 6) return 'Password harus 6 digit';
                    },
                    decoration: InputDecoration(
                      labelText: 'Masukkan password baru',
                      labelStyle: const TextStyle(color: Color(0xFFD5D5DC)),
                      filled: true,
                      fillColor: const Color(0xFFF6F7F8),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _forgotPasswordController.isPasswordHide.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: _forgotPasswordController.isPasswordHide.value
                              ? const Color(0xFF8F92A1)
                              : const Color(0xFF44CCC0),
                        ),
                        onTap: () {
                          _forgotPasswordController.isPasswordHide.value =
                              !_forgotPasswordController.isPasswordHide.value;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextFormField(
                    controller: _c.confirmPasswordController,
                    maxLength: 6,
                    obscureText:
                        _forgotPasswordController.isConfirmPasswordHide.value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Konfirmasi password harus diisi.';
                      }
                      if (value != null &&
                          _c.passwordController.text !=
                              _c.confirmPasswordController.text) {
                        return 'Konfirmasi password tidak sesuai';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi password baru',
                      labelStyle: const TextStyle(color: Color(0xFFD5D5DC)),
                      filled: true,
                      fillColor: const Color(0xFFF6F7F8),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _forgotPasswordController.isConfirmPasswordHide.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: _forgotPasswordController
                                  .isConfirmPasswordHide.value
                              ? const Color(0xFF8F92A1)
                              : const Color(0xFF44CCC0),
                        ),
                        onTap: () {
                          _forgotPasswordController
                                  .isConfirmPasswordHide.value =
                              !_forgotPasswordController
                                  .isConfirmPasswordHide.value;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 52),
                SubmitButton(
                    backgroundColor: const Color(0xFF44CCC0),
                    onPressed: () => _c.resetTap(),
                    text: 'Reset'),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
