import 'package:eidupay/view/services/belanja/belanja_service.dart';
import 'package:eidupay/view/services/esamsat/esamsat_service.dart';
import 'package:eidupay/view/services/games/games_list.dart';
import 'package:eidupay/view/services/telkom/telkom_service.dart';
import 'package:eidupay/view/services/tv/tv_service.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/view/services/bpjs/bpjs_service.dart';
import 'package:eidupay/view/services/education/education_services.dart';
import 'package:eidupay/view/services/eduprime/eduprime_page.dart';
import 'package:eidupay/view/services/listrik/listrik_service.dart';
import 'package:eidupay/view/services/pascabayar/pascabayar_service.dart';
import 'package:eidupay/view/services/pdam/pdam_page.dart';
import 'package:eidupay/view/services/pulsa/pulsa_service.dart';
import 'package:eidupay/view/services/sedekah/sedekah_page.dart';
import 'package:eidupay/view/services/titipan/titipan_service.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:get/get.dart';

class ServiceCont extends GetxController {
  void serviceTap(String serviceName, String idMenu) {
    debugPrint(serviceName);
    switch (serviceName) {
       case 'Belanja':
        Get.toNamed(BelanjaService.route.name, arguments: idMenu);
        break;
      case 'Bpjs':
        Get.toNamed(BPJS.route.name, arguments: idMenu);
        break;
      case 'Edukasi':
        Get.toNamed(EducationService.route.name, arguments: idMenu);
        break;
      case 'Pascabayar':
        Get.toNamed(PascabayarService.route.name, arguments: idMenu);
        break;
      case 'Token Listrik':
        Get.toNamed(ListrikService.route.name, arguments: [idMenu, 'token']);
        break;
      case 'Listrik PLN':
        Get.toNamed(ListrikService.route.name, arguments: [idMenu, 'tagihan']);
        break;
      case 'Eduprime':
        Get.toNamed(EduprimePage.route.name, arguments: idMenu);
        break;
      case 'Pdam':
        Get.toNamed(PdamPage.route.name, arguments: idMenu);
        break;
      case 'Titipan':
        Get.toNamed(TitipanService.route.name, arguments: idMenu);
        break;
      case 'Sedekah':
        Get.toNamed(SedekahPage.route.name, arguments: idMenu);
        break;
      case 'Pulsa':
        Get.toNamed(PulsaService.route.name, arguments: idMenu);
        break;
      case 'Games':
        Get.toNamed(GameListPage.route.name, arguments: idMenu);
        break;
      case 'E-Samsat':
        Get.toNamed(EsamsatService.route.name, arguments: idMenu);
        break;
      case 'Tv Kabel':
        Get.toNamed(TvService.route.name, arguments: idMenu);
        break;
      case 'Telkom':
        Get.toNamed(TelkomService.route.name, arguments: idMenu);
        break;
      default:
        EiduInfoDialog.showInfoDialog(title: 'Akan segera hadir');
    }
  }
}
