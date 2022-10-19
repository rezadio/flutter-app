import 'dart:io';

import 'package:eidupay/controller/kyc/scan_ktp_controller.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/eidu_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanKtpPage extends StatefulWidget {
  static final route =
      GetPage(name: '/kyc/scan', page: () => const ScanKtpPage());

  const ScanKtpPage({Key? key}) : super(key: key);

  @override
  _ScanKtpPageState createState() => _ScanKtpPageState();
}

class _ScanKtpPageState extends State<ScanKtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: const _BodyScanKtpPage(),
    );
  }
}

class _BodyScanKtpPage extends StatefulWidget {
  const _BodyScanKtpPage({Key? key}) : super(key: key);

  @override
  _BodyScanKtpPageState createState() => _BodyScanKtpPageState();
}

class _BodyScanKtpPageState extends State<_BodyScanKtpPage> {
  final _getController = Get.put(ScanKtpController());
  final File faceImage = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EiduCamera(
              controller: _getController.eiduCameraController,
              defaultCameraType: CameraType.back),
          RotatedBox(
            quarterTurns: 1,
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset('assets/images/frame_ktp.png')),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () async => _getController.toggleFlash(),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        _getController.flashIcon.value,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async => await _getController.capture(faceImage),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      shape: BoxShape.circle,
                      color: t60,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.image, color: Colors.transparent),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
