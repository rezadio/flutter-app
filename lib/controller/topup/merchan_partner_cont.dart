import 'package:eidupay/controller/topup/topup_bank_cont.dart';
import 'package:eidupay/view/topup/topup_merchant_denom_page.dart';
import 'package:get/get.dart';

class MerchantPartnerCont extends GetxController {
  final merchantList = [
    {
      'name': 'alfamart',
      'img': [
        'assets/images/logo_alfamart.png',
        'assets/images/logo_alfamidi.png',
        'assets/images/logo_dan-dan.png',
        'assets/images/logo_lawson.png'
      ]
    },
    {
      'name': 'indomaret',
      'img': ['assets/images/logo_indomaret.png']
    },
    {
      'name': 'BRI Link',
      'img': ['assets/images/logo_bank_brilink.png'],
      'va': 'vabri'
    },
    {
      'name': 'agen 46',
      'img': ['assets/images/logo_agen46.png'],
      'va': 'vabni'
    },
  ];

  void merchantTap(Map<String, Object> merchant) {
    final merchantName = merchant['name'].toString();
    if (merchantName == 'BRI Link' || merchantName == 'agen 46') {
      final topupBankCont = Get.put(TopupBankCont());
      topupBankCont.bankInfo(merchant);
      return;
    }
    Get.toNamed(TopupMerchantDenomPage.route.name, arguments: merchantName);
  }
}
