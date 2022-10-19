import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class KycSuccessPage extends StatefulWidget {
  static final route =
      GetPage(name: '/kyc/success', page: () => const KycSuccessPage());
  const KycSuccessPage({Key? key}) : super(key: key);

  @override
  _KycSuccessPageState createState() => _KycSuccessPageState();
}

class _KycSuccessPageState extends State<KycSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(body: _BodyKycSuccessPage()));
  }
}

class _BodyKycSuccessPage extends StatefulWidget {
  const _BodyKycSuccessPage({Key? key}) : super(key: key);

  @override
  _BodyKycSuccessPageState createState() => _BodyKycSuccessPageState();
}

class _BodyKycSuccessPageState extends State<_BodyKycSuccessPage> {
  final lorem =
      'Nisl enim elementum, et at sagittis non consectetur parturient mattis et ut';
  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          children: [
            const Image(
              height: 40,
              image: AssetImage('assets/images/logo_eidupay.png'),
            ),
            const Spacer(),
            const Expanded(
                flex: 2,
                child: Image(image: AssetImage('assets/images/kyc.png'))),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Berhasil!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25, color: blue, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data['pesan'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, color: t60, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SubmitButton(
                text: 'Kembali ke Menu Utama',
                backgroundColor: green,
                onPressed: () {
                  Get.offAllNamed(Home.route.name);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
