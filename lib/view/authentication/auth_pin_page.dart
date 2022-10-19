import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/eidu_pin_code_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPinPage extends StatefulWidget {
  static final route =
      GetPage(name: '/auth-finger-print', page: () => const AuthPinPage());

  const AuthPinPage({Key? key}) : super(key: key);

  @override
  _AuthPinPageState createState() => _AuthPinPageState();
}

class _AuthPinPageState extends State<AuthPinPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyAuthPinPage(),
    );
  }
}

class _BodyAuthPinPage extends StatelessWidget {
  const _BodyAuthPinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Expanded(
              child: Image(
                height: 50,
                image: AssetImage('assets/images/logo_eidupay.png'),
              ),
            ),
            Column(
              children: [
                const Text(
                  'Log in with pin',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55.0),
                  child: Form(
                    child: EiduPinCodeTextField(
                      obscureText: true,
                      onCompleted: (value) {
                        EiduInfoDialog.showInfoDialog(
                            icon: 'assets/lottie/success.json',
                            title: 'Authenticated',
                            description: 'dummy only, will route to HomePage');
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Problem logging in',
                    style: TextStyle(
                        color: Color(0xFF878DBA),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    child: const Text(
                      'Contact Support',
                      style: TextStyle(
                          color: Color(0xFF44CCC0),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
