import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/kyc/kyc_camera_page.dart';
import 'package:eidupay/view/kyc/scan_ktp_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';

import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class InstructionPage extends StatefulWidget {
  static final route =
      GetPage(name: '/kyc/', page: () => const InstructionPage());
  const InstructionPage({Key? key}) : super(key: key);

  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KYC')),
      body: const _BodyInstructionPage(),
    );
  }
}

class _BodyInstructionPage extends StatefulWidget {
  const _BodyInstructionPage({Key? key}) : super(key: key);

  @override
  _BodyInstructionPageState createState() => _BodyInstructionPageState();
}

class _BodyInstructionPageState extends State<_BodyInstructionPage> {
  PageArgument argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: Column(
          children: [
            Text('Step ${argument.title.contains('Wajah') ? 1 : 2} of 2',
                style: const TextStyle(
                    color: t60, fontSize: 16, fontWeight: FontWeight.w400)),
            SizedBox(height: h(16)),
            Text(
              argument.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h(8)),
            Text(
              argument.description ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: t60, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Image(image: AssetImage(argument.imageUrl ?? '')),
            ),
            const Spacer(),
            SubmitButton(
              text: 'Lanjut',
              backgroundColor: green,
              onPressed: () {
                argument.title.contains('Wajah')
                    ? Get.toNamed(KycCameraPage.route.name)
                    : Get.toNamed(ScanKtpPage.route.name,
                        arguments: argument.image1);
              },
            )
          ],
        ),
      ),
    );
  }
}
