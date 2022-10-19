import 'dart:io';

import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/kyc/instruction_page.dart';
import 'package:eidupay/view/kyc/kyc_camera_page.dart';
import 'package:eidupay/view/kyc/kyc_data_confirmation_page.dart';
import 'package:eidupay/view/kyc/scan_ktp_page.dart';
import 'package:get/get.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

class ImageConfirmationController extends GetxController {
  void retake({File? image1, File? image2}) {
    if (image2 != null) {
      Get.offNamed(ScanKtpPage.route.name, arguments: image1);
    } else {
      Get.offNamed(KycCameraPage.route.name);
    }
  }

  Future<void> process(BuildContext context,
      {required File image1, File? image2}) async {
    if (image2 != null) {
      EiduLoadingDialog.showLoadingDialog();
      // final textRec = GoogleMlKit.vision.textDetector();
      // final ocr = await textRec.processImage(InputImage.fromFile(image2));
      Get.back();
      await Get.offNamed(KycDataConfirmationPage.route.name,
          arguments: [image1, image2]);
    } else {
      await Get.offNamed(
        InstructionPage.route.name,
        arguments: PageArgument.kycPage2(image1),
      );
    }
  }
}
