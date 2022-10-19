import 'package:eidupay/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFaceIdPage extends StatefulWidget {
  static final route =
      GetPage(name: '/auth-face-id', page: () => const AuthFaceIdPage());

  const AuthFaceIdPage({Key? key}) : super(key: key);

  @override
  _AuthFaceIdPageState createState() => _AuthFaceIdPageState();
}

class _AuthFaceIdPageState extends State<AuthFaceIdPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BodyAuthFaceIdPage(),
    );
  }
}

class _BodyAuthFaceIdPage extends StatelessWidget {
  final authController = Get.find<AuthController>();

  _BodyAuthFaceIdPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Column(
              children: [
                const Text(
                  'Log In dengan Face ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  child: const Image(
                    height: 116,
                    image: AssetImage('assets/images/face_id.png'),
                  ),
                  onTap: () async {
                    await authController.authenticateBiometric();
                  },
                ),
                const SizedBox(height: 40),
                const Text(
                  'Pindai Wajah kamu untuk melanjutkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
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
            //         height: 14
            //       ),
            //       TextButton(
            //         child: Text(
            //           'Use login pin',
            //           style: TextStyle(
            //               color: Color(0xFF004B84),
            //               fontWeight: FontWeight.bold,
            //               fontSize: 20),
            //         ),
            //         onPressed: () {
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
