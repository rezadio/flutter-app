import 'package:eidupay/controller/topup/topup_cont.dart';
import 'package:eidupay/model/data_initiator.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/toupup_bank_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopupBankCont extends GetxController {
  final topupCont = Get.find<TopupCont>();
  final balance = dtUser;
  late Map<String, dynamic> vaBanks;

  void bankInfo(Map<String, dynamic> bank) {
    var data = <String, dynamic>{};
    debugPrint(bank['va'].toString());
    vaBanks = Map.from(dtUser)
      ..removeWhere((key, value) => !(key.contains(bank['va'])));
    List.from(dtUser['dataInitiator'])
        .map((e) => DataInitiator.fromJson(e))
        .where((element) =>
            element.initiatorName.contains(bank['va'].toString().substring(2)))
        .forEach((element) => data.addAll(element.toJson()));
    data..addAll(vaBanks)..addAll(bank);
    Get.toNamed(TopupBankInfo.route.name, arguments: data);
  }
}
