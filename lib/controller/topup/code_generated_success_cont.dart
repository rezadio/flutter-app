import 'package:flutter/material.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class CodeGeneratedSuccessCont extends GetxController {
  final screenshotController = ScreenshotController();
  final merchantList = [
    {'name': 'alfamart', 'img': 'assets/images/logo_alfamart.png'},
    {'name': 'indomaret', 'img': 'assets/images/logo_indomaret.png'}
  ];

  void copyData(String va) {
    Clipboard.setData(ClipboardData(text: va));
    Get.snackbar(
      'Eidupay',
      'Data has been copied to the clipboard',
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toHome() => Get.offAllNamed(Home.route.name);

  List<String> logoUrl(String merchantName) {
    if (merchantName == 'alfamart') {
      return [
        'assets/images/logo_alfamart.png',
        'assets/images/logo_alfamidi.png',
        'assets/images/logo_dan-dan.png',
        'assets/images/logo_lawson.png'
      ];
    }
    return ['assets/images/logo_indomaret.png'];
  }

  List<String> getInstruction(String merchantName) => [
        (merchantName == 'alfamart')
            ? 'Datang ke gerai Alfamart, Alfamidi, Dan+Dan, atau Lawson terdekat'
            : 'Datang ke gerai ${merchantName.capitalizeFirst} terdekat',
        (merchantName == 'alfamart')
            ? 'Informasikan ke kasir ingin membayar token Eidupay'
            : 'Informasikan ke kasir ingin membayar token Eduprime',
        'Berikan kode token ke kasir',
        'Ikuti arahan kasir untuk menyelesaikan transaksi'
      ];
}
