import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/topup/code_generated_success_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/model/topup_merchant.dart';
import 'package:get/get.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopupMerchantDenomController extends GetxController {
  final Network _network;
  TopupMerchantDenomController(this._network);

  var balance = 'NA'.obs;
  var denoms = <Denom>[].obs;
  var denomSelected = <Denom>[].obs;
  var isDenomSelected = false.obs;

  late String biller;

  @override
  void onInit() async {
    super.onInit();
    await getBalance();
    denoms.value = await getDenom();
  }

  Future<void> getBalance() async {
    final balanceModel = await _network.getBalance();
    balance.value = balanceModel.infoMember.lastBalance;
  }

  Future<List<Denom>> getDenom() async {
    try {
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, String>{
        'idAccount': _pref.getString(kUserId) ?? '',
        'packageName': _package.packageName,
        'tipe': _pref.getString(kUserType) ?? '',
        'lang': '',
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode
      };
      final response = await _network.post(
          url: 'eidupay/topup/getDenom', header: header, body: body);
      final bodyResponse = await response.stream.bytesToString();
      final decryptedBody = _network.decrypt(bodyResponse);
      final decodedBody = jsonDecode(decryptedBody);
      final model = DenomMerchant.fromJson(decodedBody);
      return model.denom;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> pay(Denom denom, String pin) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final idTrx = '3' +
        DateFormat('yyMMddHHmmss').format(DateTime.now()) +
        (_pref.getString(kUid) ?? '');
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'pin': pin,
      'idTrx': idTrx,
      'nominal': denom.nominal,
      'biller': biller,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/topup/getPaymentCodeMst', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> process({required Denom denom}) async {
    List<dynamic>? results = await Get.to(
      () => PinVerificationPage<TopupMerchantDenomController>(
          pageController: this),
      arguments: denom,
    );

    final bool? isSuccess = results?[0];
    final response = results?[1];
    final model = MerchantPaymentCodeResponse.fromJson(response);

    if (isSuccess != null && isSuccess) {
      await Get.toNamed(CodeGeneratedSuccessPage.route.name,
          arguments: [model.data, denom, biller]);
    }
  }
}
