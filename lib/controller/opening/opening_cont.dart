import 'package:eidupay/tools.dart';
import 'package:eidupay/view/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningCont extends GetxController {
  Future<void> continueTap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnBoarding, false);
    await prefs.setBool(kIsAlreadyPrompted, false);
    await prefs.setBool(kIsLoggedIn, false);
    await prefs.setString(kHp, '');
    await Get.offAllNamed(Login.route.name);
  }
}
