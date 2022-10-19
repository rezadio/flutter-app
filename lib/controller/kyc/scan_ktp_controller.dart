import 'dart:io';

import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/kyc/image_confirmation_page.dart';
import 'package:eidupay/widget/eidu_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eidupay/tools.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ScanKtpController extends GetxController {
  final EiduCameraController eiduCameraController = EiduCameraController();
  late List<CameraDescription> cameras;
  var flashIcon = Icons.flash_off.obs;
  final imagePicker = ImagePicker();

  void toggleFlash() {
    final iconData = eiduCameraController.toggleFlash(flashIcon.value);
    flashIcon.value = iconData ?? Icons.flash_off;
  }

  Future<void> capture(File image1) async {
    late File image2;
    final image = await eiduCameraController.takePicture();
    if (image != null) {
      final compressedImage = await compressFile(File(image.path));
      final gambar = img.decodeJpg(await compressedImage.readAsBytes());
      final rotatedGambar = img.copyRotate(gambar, -90);
      final encodedImage = img.encodeJpg(rotatedGambar);
      if (Platform.isIOS) {
        final url = await getApplicationDocumentsDirectory();
        image2 = await File('${url.path}/camera/pictures/${image.name}')
            .writeAsBytes(encodedImage);
      } else {
        image2 = await File(image.path).writeAsBytes(encodedImage);
      }
      final compressedImage2 = await compressFile(image2);

      // Save the thumbnail as a PNG.
      var croppedImages = img.copyCrop(
          img.decodeJpg(File(compressedImage2.path).readAsBytesSync()),
          300,
          100,
          770,
          530);
      File(compressedImage2.path)
          .writeAsBytesSync(img.encodePng(croppedImages));

      await Get.offNamed(ImageConfirmationPage.route.name,
          arguments: PageArgument(
              title: 'Konfirmasi',
              image1: image1,
              image2: File(compressedImage2.path)));
    }
  }
}
