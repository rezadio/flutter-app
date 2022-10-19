import 'dart:io';

import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/kyc/image_confirmation_page.dart';
import 'package:eidupay/widget/eidu_camera.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class KycCameraController extends GetxController {
  final EiduCameraController eiduCameraController = EiduCameraController();

  Future<void> capture() async {
    final image = await eiduCameraController.takePicture();
    if (image != null) {
      final compressedImage = await compressFile(File(image.path));
      await Get.offNamed(ImageConfirmationPage.route.name,
          arguments:
              PageArgument(title: 'Konfirmasi', image1: compressedImage));
    }
  }
}
