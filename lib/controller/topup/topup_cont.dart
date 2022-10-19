import 'package:eidupay/view/topup/merchant_partner.dart';
import 'package:eidupay/view/topup/topup_bank_islami.dart';
import 'package:eidupay/view/topup/topup_instant.dart';
import 'package:eidupay/view/topup/topup_bank.dart';
import 'package:get/get.dart';

class TopupCont extends GetxController {
  final bankList = [
    {
      'name': 'Bank BRI',
      'icon': 'assets/images/logo_bank_bri.png',
      'va': 'vabri'
    },
    {
      'name': 'Bank BNI',
      'icon': 'assets/images/logo_bank_bni.png',
      'va': 'vabni'
    },
    {
      'name': 'Bank Mandiri',
      'icon': 'assets/images/logo_bank_mandiri.png',
      'va': 'vamandiri'
    },
    {
      'name': 'Bank BCA',
      'icon': 'assets/images/logo_bank_bca.png',
      'va': 'vabca'
    },
  ];

  void bank() {
    Get.toNamed(TopupBank.route.name);
  }

  void instantTopup() {
    Get.to(TopupInstant.route.name);
  }

  void directDebit() {
    Get.toNamed(TopupInstant.route.name);
  }

  void islamicBank() {
    Get.toNamed(TopupBankIslami.route.name);
  }

  void merchant() {
    Get.toNamed(MerchantPartner.route.name);
  }
}
