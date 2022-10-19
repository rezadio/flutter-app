import 'package:get/get.dart';

class EducationSelectPaymentMethodCont extends GetxController {
  final paymentMethod = <String>[
    'assets/images/logo_eidupay.png',
    'assets/images/logo_indomaret.png',
    'assets/images/logo_alfamart.png',
  ];
  var methodSelectedNumber = 0.obs;
  var isMethodSelected = false.obs;
}
