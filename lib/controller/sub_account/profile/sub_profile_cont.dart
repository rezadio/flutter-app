import 'dart:convert';

import 'package:eidupay/controller/profile/profile_cont.dart';
import 'package:eidupay/model/login.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/tools.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubProfileCont extends ProfileCont {
  final Network _network;
  SubProfileCont(this._network) : super(_network);

  late LoginRest subAccount;
  var limit = '0'.obs;

  Future<void> getSubBalance() async {
    final balanceModel = await _network.getBalance();
    final infoExtended = balanceModel.infoExtended;
    final balance = balanceModel.infoMember.lastBalance;
    if (infoExtended != null) {
      if (int.parse(balance.numericOnly()) <
          int.parse(infoExtended.extLimit.numericOnly())) {
        limit.value = balance;
        return;
      }
      final limitInt = (int.parse(infoExtended.extLimit.numericOnly()) -
          int.parse(infoExtended.extUsed.numericOnly()));
      limit.value = limitInt.amountFormat;
    }
  }

  Future<bool> getSubAccount() async {
    final _pref = await SharedPreferences.getInstance();
    final dtUserString = _pref.getString(kDtUser);
    if (dtUserString != null) {
      final decoded = jsonDecode(dtUserString);
      subAccount = LoginRest.fromJson(decoded);
      return true;
    }
    return false;
  }
}
