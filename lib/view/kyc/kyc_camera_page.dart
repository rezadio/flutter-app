import 'package:eidupay/controller/kyc/kyc_camera_controller.dart';
import 'package:eidupay/widget/eidu_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class KycCameraPage extends StatefulWidget {
  static final route =
      GetPage(name: '/kyc/camera', page: () => const KycCameraPage());
  const KycCameraPage({Key? key}) : super(key: key);

  @override
  _KycCameraPageState createState() => _KycCameraPageState();
}

class _KycCameraPageState extends State<KycCameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Foto Selfie & KTP',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const _BodyCameraPage(),
    );
  }
}

class _BodyCameraPage extends StatefulWidget {
  const _BodyCameraPage({Key? key}) : super(key: key);

  @override
  _BodyCameraPageState createState() => _BodyCameraPageState();
}

class _BodyCameraPageState extends State<_BodyCameraPage> {
  final _getController = Get.put(KycCameraController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EiduCamera(
              controller: _getController.eiduCameraController,
              defaultCameraType: CameraType.front),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _getController.capture(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
