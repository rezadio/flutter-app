import 'package:eidupay/model/data_initiator.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/toupup_bank_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopupBankIslamiCont extends GetxController {
  final balance = dtUser;
  late Map<String, dynamic> vaBanks;

  void bankInfo(Map<String, dynamic> bank) {
    var data = <String, dynamic>{};
    debugPrint(bank['va'].toString());
    vaBanks = Map.from(dtUser)
      ..removeWhere((key, value) => !(key.contains(bank['va'])));
    final a = List.from(dtUser['dataInitiator'])
        .map((e) => DataInitiator.fromJson(e))
        .where((element) =>
            element.initiatorName.contains(bank['va'].toString().substring(2)))
        .forEach((element) => data.addAll(element.toJson()));
    data..addAll(vaBanks)..addAll(bank);
    Get.toNamed(TopupBankInfo.route.name, arguments: data);
  }

  final bankList = [
    {
      'name': 'Bank BSI',
      'icon': 'assets/images/logo_bank_bsi.png',
      'va': 'vabsi'
    },
    {
      'name': 'Bank Muamalat',
      'icon': 'assets/images/logo_bank_muamalat.png',
      'va': 'vamuamalat'
    },
  ];
}
