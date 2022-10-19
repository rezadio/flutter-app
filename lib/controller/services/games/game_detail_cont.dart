import 'dart:convert';

import 'package:eidupay/extension.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/game.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameDetailCont extends GetxController {
  final Network _network;
  GameDetailCont(this._network);

  final contUserId = TextEditingController();
  final contZoneId = TextEditingController();
  final contUserName = TextEditingController();
  final contServer = TextEditingController();
  late GameDetailResponse gameDetail;
  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  var hasZondeId = false.obs;
  var hasUserId = false.obs;
  var hasUserName = false.obs;
  var hasServer = false.obs;
  var cookie;
  var uid;
  var balance = '0'.obs;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

    await getCookie();
    await getUid();
    for (var field in gameDetail.fields) {
      if (field.nameField == 'zoneid') hasZondeId(true);
      if (field.nameField == 'userid') hasUserId(true);
      if (field.nameField == 'username') hasUserName(true);
      if (field.nameField == 'server') hasServer(true);
    }
    await getBalance();
  }

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    uid = _pref.getString(kUid) ?? '';
  }

  Future<void> getBalance() async {
    balanceModel = await _network.getBalance();
    final infoExtended = balanceModel.infoExtended;
    final lastBalance = balanceModel.infoMember.lastBalance;
    if (infoExtended != null) {
      if (int.parse(lastBalance.numericOnly()) <
          int.parse(infoExtended.extLimit.numericOnly())) {
        balance.value = lastBalance;
        return;
      }
      final limitInt = (int.parse(infoExtended.extLimit.numericOnly()) -
          int.parse(infoExtended.extUsed.numericOnly()));
      balance.value = limitInt.amountFormat;
      return;
    }
    balance.value = balanceModel.infoMember.lastBalance;
  }

  Future<GameInquiry> getInqGame(GameDenom denom) async {
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'gameCode': gameDetail.game.code,
      'userid': contUserId.text,
      'zoneid': contZoneId
          .text, // Optional jika pada fields detail tidak ada zoneId di isi 0 saja
      'server': contServer
          .text, // Optional jika pada fields detail tidak ada zoneId di isi 0 saja
      'username': contUserName
          .text, // Optional jika pada fields detail tidak ada zoneId di isi 0 saja

      'gameName': gameDetail.game.nameGame,
      'denomId': denom.id.toString(),
      'denomName': denom.nameDenom,
      'amount': denom.amount
    };

    final response = await _network.post(
        url: 'eidupay/game/inquiryInGame', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = GameInquiry.fromJson(decodedBody);
      return model;
    } catch (_) {
      Get.back();
      final model = DefaultModel.fromJson(decodedBody);
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: model.pesan);
      rethrow;
    }
  }

  Future<dynamic> pay(GameInquiry inquiry, String pin) async {
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idTrx': '3' + uid + timeStr,
      'pin': pin,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'idAccount': dtUser['idAccount'],
      'token': inquiry.token,
    };

    final response = await _network.post(
        url: 'eidupay/game/paymentInGame', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> gameDetailTap(GameDenom dataDetailDenom) async {
    if (hasUserId.value && contUserId.text == '') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'User ID harus diisi!');
      return;
    }
    if (hasZondeId.value && contZoneId.text == '') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Zone ID harus diisi!');
      return;
    }
    if (hasUserName.value && contUserName.text == '') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'User Name harus diisi!');
      return;
    }
    if (hasServer.value && contServer.text == '') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Server harus diisi!');
      return;
    }

    if (!hasServer.value) contServer.text = '0';
    if (!hasUserId.value) contUserId.text = '0';
    if (!hasZondeId.value) contZoneId.text = '0';
    if (!hasUserName.value) contUserName.text = '0';

    EiduLoadingDialog.showLoadingDialog();
    final resInqGame = await getInqGame(dataDetailDenom);
    Get.back();
    final bayar = await EiduConfirmationBottomSheet.showBottomSheet(
      title: 'Konfirmasi',
      iconUrl: 'assets/images/ico_confirm_btm.png',
      body: confirm(denom: dataDetailDenom, inquiry: resInqGame),
      secondButtonText: 'Bayar',
      secondaryColor: green,
      firstButtonOnPressed: () {
        Get.back(result: false);
      },
      secondButtonOnPressed: () {
        final infoExtended = balanceModel.infoExtended;
        final dailyLimit =
            int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
        if (infoExtended != null && dailyLimit != 0) {
          final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
              ? int.parse(infoExtended.extDailyUsed.numericOnly())
              : 0;
          if (dailyUsed + int.parse(dataDetailDenom.amount.numericOnly()) >
              dailyLimit) {
            EiduInfoDialog.showInfoDialog(
                title: 'Daily limit sudah mencapai batas!');
            return;
          }
        }
        Get.back(result: true);
      },
    );
    if (bayar) {
      final int lastBalance = int.parse(balance.value.numericOnly());
      final int hrg = int.parse(dataDetailDenom.amount
          .substring(0, dataDetailDenom.amount.length - 3));
      if (lastBalance < hrg) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Saldo tidak mencukupi!');
        return;
      }

      List<dynamic>? results = await Get.to(
        () => PinVerificationPage<GameDetailCont>(pageController: this),
        arguments: resInqGame,
      );

      final bool? isSuccess = results?[0];
      final resPaymentGame = results?[1];

      if (isSuccess != null && isSuccess) {
        await Get.offAllNamed(TransactionSuccessPage.route.name,
            arguments: PageArgument(
                title: 'Sukses!',
                description: resPaymentGame['pesan'],
                nominal: (int.parse(dataDetailDenom.amount
                        .substring(0, dataDetailDenom.amount.length - 3)))
                    .amountFormat,
                total: (int.parse(dataDetailDenom.amount
                        .substring(0, dataDetailDenom.amount.length - 3)))
                    .amountFormat,
                ket1: 'Game : ' + resInqGame.gameName,
                ket2: 'Jenis : ' + resInqGame.denominationName,
                trxId: ''));
      }
    }
  }

  Widget confirm({required GameDenom denom, required GameInquiry inquiry}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inquiry.gameName,
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        SizedBox(height: h(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inquiry.denominationName,
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.w400, color: t70),
              ),
            ],
          ),
        ),
        SizedBox(height: h(20)),
        (inquiry.userId != 'null' && inquiry.userId != '0')
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Useri ID',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    Text(
                      inquiry.userId,
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: h(10)),
        (inquiry.username != 'null' && inquiry.username != '0')
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    Text(
                      inquiry.username,
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: h(10)),
        inquiry.zoneId != 'null' && inquiry.zoneId != '0'
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Zone ID',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    Text(
                      inquiry.zoneId,
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: h(10)),
        inquiry.server != null && inquiry.server != '0'
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Server',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    Text(
                      inquiry.server!,
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: w(20)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nominal',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' +
                    (int.parse(
                            denom.amount.substring(0, denom.amount.length - 3)))
                        .amountFormat,
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Admin',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. 0',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        const SizedBox(
            width: double.infinity,
            height: 30,
            child: DashLineDivider(height: 1)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' +
                    (int.parse(
                            denom.amount.substring(0, denom.amount.length - 3)))
                        .amountFormat,
                style: TextStyle(
                    fontSize: w(18), fontWeight: FontWeight.w400, color: green),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
