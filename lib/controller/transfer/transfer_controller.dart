import 'package:eidupay/tools.dart';
import 'package:eidupay/view/transfer/transfer_to_bank_page.dart';
import 'package:eidupay/view/transfer/transfer_to_emoney_page.dart';
import 'package:eidupay/view/transfer/transfer_to_wallet_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_kyc_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferController extends GetxController {
  var idVerifyStatus = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getIdVerifyStatus();
  }

  Future<void> getIdVerifyStatus() async {
    final _pref = await SharedPreferences.getInstance();
    idVerifyStatus.value = _pref.getString(kIdVerifyStatus) ?? '';
  }

  Future<void> toWalletTap() async {
    if (idVerifyStatus.value == '3') {
      return EiduInfoDialog.showInfoDialog(
          title: 'KYC dalam proses verifikasi');
    }
    if (idVerifyStatus.value == '2') {
      return EiduKycBottomSheet.showBottomSheet();
    }
    return Get.toNamed(TransferToWalletPage.route.name);
  }

  Future<void> toBankTap() async {
    if (idVerifyStatus.value == '3') {
      return EiduInfoDialog.showInfoDialog(
          title: 'KYC dalam proses verifikasi');
    }
    if (idVerifyStatus.value == '2') {
      return EiduKycBottomSheet.showBottomSheet();
    }
    return Get.toNamed(TransferToBankPage.route.name);
  }

  Future<void> toEMoneyTap() async {
    if (idVerifyStatus.value == '3') {
      return EiduInfoDialog.showInfoDialog(
          title: 'KYC dalam proses verifikasi');
    }
    if (idVerifyStatus.value == '2') {
      return EiduKycBottomSheet.showBottomSheet();
    }
    return Get.toNamed(TransferToEMoneyPage.route.name);
  }
}
