import 'dart:convert';

import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/controller/services/pulsa/pulsa_cont.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/pulsa_model.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PulsaService { pulsa, data }

class PulsaListCont extends GetxController {
  final Network _network;
  PulsaListCont(this._network);

  final _contPulsa = Get.find<PulsaCont>();
  late PulsaRest lsPulsa;
  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  var noHp = ''.obs;
  var lsData;
  var cookie;
  var uid;
  var balance = '0'.obs;
  var idMenu;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

    noHp.value = _contPulsa.contNoHp.text;
    await getCookie();
    await getUid();
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

  Future<dynamic> getPayPulsa(Pulsa dataDenom, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idOperator': dataDenom.idOperator,
      'idAccount': dtUser['idAccount'],
      'idPrefix': dataDenom.idPrefix,
      'idTrx': '3' + uid + timeStr,
      'deviceInfo': uid,
      'versionCode': versionCode,
      'idDenom': dataDenom.idDenom,
      'nominal': dataDenom.nominal,
      'idSupplier': dataDenom.idSupplier,
      'hargaCetak': dataDenom.hargaCetak,
      'noHp': noHp.value,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'namaOperator': dataDenom.namaOperator,
      'pin': pin,
      if (_contPulsa.isChecked.value == true)
        'namaAlias': _contPulsa.favoriteController.text,
    };
    final response = await _network.post(
        url: 'eidupay/pulsa/getPayPulsa', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getPayData(PaketData dataDenom, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idOperator': dataDenom.idOperator,
      'idAccount': dtUser['idAccount'],
      'idPrefix': dataDenom.idPrefix,
      'idTrx': '3' + uid + timeStr,
      'deviceInfo': uid,
      'versionCode': versionCode,
      //"idDenom": dataDenom['idDenom'],
      'nominal': dataDenom.nominal,
      //"idSupplier": dataDenom['idSupplier'],
      'hargaCetak': dataDenom.hargaCetak,
      'noHp': noHp.value,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'namaOperator': dataDenom.namaOperator,
      'pin': pin,
      if (_contPulsa.isChecked.value == true) 'namaAlias': noHp.value,
    };
    final response = await _network.post(
        url: 'eidupay/paketData/getPayPaketData', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(inquiry, String pin) async {
    final PulsaService service = inquiry[0];
    switch (service) {
      case PulsaService.pulsa:
        final Pulsa pulsa = inquiry[1];
        return await getPayPulsa(pulsa, pin);
      case PulsaService.data:
        final PaketData data = inquiry[1];
        return await getPayData(data, pin);
    }
  }

  Future<void> pulsaTap(PulsaService service, Pulsa dataDenom) async {
    final int lastBalance = int.parse(balance.value.numericOnly());
    final int hrg = int.parse(dataDenom.hargaCetak.numericOnly());

    final infoExtended = balanceModel.infoExtended;
    final dailyLimit =
        int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');

    if (lastBalance < hrg) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Saldo tidak mencukupi!');
    } else {
      if (infoExtended != null && dailyLimit != 0) {
        final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
            ? int.parse(infoExtended.extDailyUsed.numericOnly())
            : 0;
        if (dailyUsed + hrg > dailyLimit) {
          await EiduInfoDialog.showInfoDialog(
              title: 'Daily limit sudah mencapai batas!');
          return;
        }
      }
      var bayar = await EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Konfirmasi',
        body: _confirmPulsa(dataDenom, noHp.value),
        secondaryColor: green,
        secondButtonText: 'Bayar',
        firstButtonOnPressed: () => Get.back(result: false),
        secondButtonOnPressed: () => Get.back(result: true),
      );
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<PulsaListCont>(pageController: this),
          arguments: [service, dataDenom],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          await Get.offAllNamed(TransactionSuccessPage.route.name,
              arguments: PageArgument(
                  title: 'Pulsa / Paket Data',
                  description: 'Transaksi anda sedang di proses.',
                  nominal: 'Rp. ' + dataDenom.hargaCetak,
                  total: 'Rp. ' + dataDenom.hargaCetak,
                  ket1: 'No Hp : ' + noHp.value,
                  ket2: 'Pembelian pulsa ' +
                      dataDenom.namaOperator +
                      ' ' +
                      dataDenom.nominal,
                  ket3: '',
                  trxId: payResponse['idTrx'] ?? ''));
        }
      }
    }
  }

  Future<void> dataTap(PulsaService service, PaketData dataDenom) async {
    final int lastBalance = int.parse(balance.value.numericOnly());
    final int hrg = int.parse(dataDenom.hargaCetak.numericOnly());

    final infoExtended = balanceModel.infoExtended;
    final dailyLimit =
        int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');

    if (lastBalance < hrg) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Saldo tidak mencukupi!');
    } else {
      if (infoExtended != null && dailyLimit != 0) {
        final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
            ? int.parse(infoExtended.extDailyUsed.numericOnly())
            : 0;
        if (dailyUsed + hrg > dailyLimit) {
          await EiduInfoDialog.showInfoDialog(
              title: 'Daily limit sudah mencapai batas!');
          return;
        }
      }
      var bayar = await EiduConfirmationBottomSheet.showBottomSheet(
        title: 'Konfirmasi',
        body: _confirmData(dataDenom, noHp.value),
        secondaryColor: green,
        secondButtonText: 'Bayar',
        firstButtonOnPressed: () => Get.back(result: false),
        secondButtonOnPressed: () => Get.back(result: true),
      );
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<PulsaListCont>(pageController: this),
          arguments: [service, dataDenom],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          await Get.offAllNamed(TransactionSuccessPage.route.name,
              arguments: PageArgument(
                  title: 'Pulsa / Paket Data',
                  description: 'Transaksi anda sedang di proses.',
                  nominal: StringUtils.stringToIdr(dataDenom.hargaCetak),
                  total: StringUtils.stringToIdr(dataDenom.hargaCetak),
                  ket1: 'No Hp : ' + noHp.value,
                  ket2: 'Data ' +
                      dataDenom.namaOperator +
                      ' ' +
                      dataDenom.nominal,
                  trxId: payResponse['idTrx'] ?? ''));
        }
      }
    }
  }

  Widget _confirmPulsa(Pulsa data, String noHp) {
    final adminFee = int.parse(data.hargaCetak.numericOnly()) -
        int.parse(data.nominal.numericOnly());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informasi Pelanggan',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        SizedBox(height: w(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No Handphone',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                noHp,
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
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
                'Nominal',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data.nominal,
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        SizedBox(height: w(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informasi Pembayaran',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Colors.grey[200],
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Harga',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                'Rp. ' + data.hargaCetak,
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
                'Total Pembayaran',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + data.hargaCetak,
                style: TextStyle(
                    fontSize: w(18), fontWeight: FontWeight.w400, color: green),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirmData(PaketData data, String noHp) {
    final adminFee = int.parse(data.hargaCetak.numericOnly()) -
        int.parse(data.nominal.numericOnly());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informasi Pelanggan',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        SizedBox(height: w(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No Handphone',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                noHp,
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        SizedBox(height: h(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deskripsi',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Expanded(
                child: Text(
                  data.nominal,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
                ),
              ),
            ],
          ),
        ),
       
        SizedBox(height: w(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informasi Pembayaran',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Colors.grey[200],
          height: w(36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Harga',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                'Rp. ' + data.hargaCetak,
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
                'Total Pembayaran',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + data.hargaCetak,
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
