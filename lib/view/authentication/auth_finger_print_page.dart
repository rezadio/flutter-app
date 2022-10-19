import 'package:eidupay/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFingerPrintPage extends StatefulWidget {
  static final route = GetPage(
      name: '/auth-finger-print', page: () => const AuthFingerPrintPage());

  const AuthFingerPrintPage({Key? key}) : super(key: key);

  @override
  _AuthFingerPrintPageState createState() => _AuthFingerPrintPageState();
}

class _AuthFingerPrintPageState extends State<AuthFingerPrintPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BodyAuthFingerPrintPage(),
    );
  }
}

class _BodyAuthFingerPrintPage extends StatelessWidget {
  final authController = Get.find<AuthController>();

  _BodyAuthFingerPrintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            const Expanded(
              child: Text(
                'Pindai sidik jari kamu untuk\nmelanjutkan',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: const Image(
                  height: 103,
                  image: AssetImage('assets/images/touch_id.png'),
                ),
                onTap: () async {
                  await authController.authenticateBiometric();
                },
              ),
            ),
            const Spacer(),
            // Expanded(
            //   child: Column(
            //     children: [
            //       Text(
            //         'or',
            //         style: TextStyle(
            //             color: Color(0xFF878DBA),
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20),
            //       ),
            //       SizedBox(
            //         height: 12,
            //       ),
            //       TextButton(
            //         child: Text(
            //           'Use login pin',
            //           style: TextStyle(
            //               color: Color(0xFF004B84),
            //               fontWeight: FontWeight.bold,
            //               fontSize: 20),
            //         ),
            //         onPressed: () async {
            //           Get.to(() => AuthPinPage());
            //         },
            //       )
            //     ],
            //   ),
            // ),
            const Expanded(
              child: Image(
                width: 113,
                image: AssetImage('assets/images/logo_eidupay.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
