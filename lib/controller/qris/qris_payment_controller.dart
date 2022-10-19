import 'dart:convert';

import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/qris.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/extension.dart';

enum QrisType { onUs, offUs }

class QrisPaymentController extends GetxController {
  final Network _network;
  QrisPaymentController(this._network);

  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final beritaController = TextEditingController();
  final tipsController = TextEditingController();
  final datas = <dynamic>[];
  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  var balance = '0'.obs;
  var isNotEnough = false.obs;
  var isParentAccount = true.obs;
  String idTrx = '-';

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
    isParentAccount.value = checkAccountType();
    await getBalance();
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

  bool checkAccountType() => dtUser['tipe'] == 'member' ? true : false;

  // Future<InquiryQris> inquiryOffUsQris(BuildContext context, Qris qris) async {
  //   final _pref = await SharedPreferences.getInstance();
  //   final _package = await PackageInfo.fromPlatform();
  //   final header = {'Cookie': _pref.getString(kCookie) ?? ''};
  //   final body = <String, dynamic>{
  //     'idAccount': _pref.getString(kUserId),
  //     'data': qris.data,
  //     'nama': qris.nama,
  //     'tip': '0',
  //     'nominalBelanja':
  //         currencyMaskFormatter.magicMask.clearMask(amountController.text),
  //     'tipe': _pref.getString(kUserType),
  //     'packageName': _package.packageName,
  //     'lang': '',
  //     'deviceInfo': _pref.getString(kUid),
  //     'versionCode': versionCode
  //   };
  //   final response = await _network.post(
  //
  //       url: 'eidupay/qris/inquiryQRIS',
  //       header: header,
  //       body: body);
  //   final bodyResponse = await response.stream.bytesToString();
  //   final decryptedBody = _network.decrypt(bodyResponse);
  //   final decodedBody = jsonDecode(decryptedBody);
  //   try {
  //     final model = InquiryQris.fromJson(decodedBody);
  //     return model;
  //   } catch (e) {
  //     final model = DefaultModel.fromJson(decodedBody);
  //     await EiduInfoDialog.showInfoDialog(context, title: model.pesan);
  //     rethrow;
  //   }
  // }

  Future<InquiryQris> inquiryOnUsQris(String qrisString) async {
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'qrisString': qrisString,
      'amount': int.parse(
          currencyMaskFormatter.magicMask.clearMask(amountController.text)),
      'idAccount': _pref.getString(kUserId),
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'packageName': _package.packageName,
      'lang': '',
      'deviceInfo': _pref.getString(kUid),
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/qrisOnUsInq', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = InquiryQris.fromJson(decodedBody['data']);
      return model;
    } catch (e) {
      Get.back();
      final model = DefaultModel.fromJson(decodedBody);
      await EiduInfoDialog.showInfoDialog(title: model.pesan);
      rethrow;
    }
  }

  // Future<DefaultModel> paymentQris(InquiryQris inquiryQris) async {
  //   final _pref = await SharedPreferences.getInstance();
  //   final _package = await PackageInfo.fromPlatform();
  //   final mappedData = jsonDecode(inquiryQris.data);
  //   idTrx.value = '3' +
  //       (_pref.getString(kUid) ?? '') +
  //       DateFormat('yyMMddHHmmss').format(DateTime.now());
  //   final header = {'Cookie': _pref.getString(kCookie) ?? ''};
  //   final body = <String, dynamic>{
  //     'idAccount': _pref.getString(kUserId) ?? '',
  //     'data': inquiryQris.data,
  //     'dataQris': inquiryQris.data,
  //     'nama': inquiryQris.nama,
  //     'tip': '0',
  //     'nominalBelanja': inquiryQris.nominalBelanja,
  //     'biaya': inquiryQris.biaya,
  //     'idTrx': idTrx.value,
  //     'MPAN': mappedData['MPAN'],
  //     'merchantCriteria': mappedData['Criteria'],
  //     'merchantId': mappedData['MID'],
  //     'pin': pin.value,
  //     'tipe': _pref.getString(kUserType) ?? '',
  //     'packageName': _package.packageName,
  //     'lang': '',
  //     'deviceInfo': _pref.getString(kUid) ?? '',
  //     'versionCode': versionCode
  //   };
  //   final response = await _network.post(
  //
  //       url: 'eidupay/qris/paymentQRIS',
  //       header: header,
  //       body: body);
  //   final bodyResponse = await response.stream.bytesToString();
  //   final decryptedBody = _network.decrypt(bodyResponse);
  //   final decodedBody = jsonDecode(decryptedBody);
  //   final model = DefaultModel.fromJson(decodedBody);
  //   return model;
  // }

  Future<dynamic> pay(List<dynamic> datas, String pin) async {
    late InquiryQris inquiryQris;
    late QrisType qrisType;
    late StreamedResponse response;
    final _package = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    idTrx = '3' +
        (_pref.getString(kUid) ?? '') +
        DateFormat('yyMMddHHmmss').format(DateTime.now());

    for (final data in datas) {
      if (data is InquiryQris) {
        inquiryQris = data;
      } else if (data is QrisType) {
        qrisType = data;
      }
    }

    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'merchantCode': inquiryQris.merchantCode,
      'berita': beritaController.text,
      'idTrx': idTrx,
      'namaToko': inquiryQris.merchantName,
      'nominalBelanja': inquiryQris.amount,
      'idAgentTujuan': inquiryQris.merchantCode,
      'pin': pin,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'packageName': _package.packageName,
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    switch (qrisType) {
      case QrisType.onUs:
        response = await _network.post(
            url: 'eidupay/belanja/belanjaPay', header: header, body: body);
        break;
      case QrisType.offUs:
        // TODO: Handle this case.
        break;
    }
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> process({required Qris qris, required String qrisString}) async {
    if (formKey.currentState?.validate() == true) {
      final qrisData = QrisData.fromJson(jsonDecode(qris.data));
      final infoExtended = balanceModel.infoExtended;

      EiduLoadingDialog.showLoadingDialog();
      if (qrisData.globallyUniqueIdentifier == 'COM.EIDUPAY.WWW') {
        final response = await inquiryOnUsQris(qrisString);
        final dailyLimit =
            int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');

        Get.back();

        if (infoExtended != null && dailyLimit != 0) {
          final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
              ? int.parse(infoExtended.extDailyUsed.numericOnly())
              : 0;
          if (dailyUsed + response.amount > dailyLimit) {
            await EiduInfoDialog.showInfoDialog(
                title: 'Daily limit sudah mencapai batas!');
            return;
          }
        }
        datas.assign(QrisType.onUs);
        datas.add(response);
        await _bottomSheetProcessOnUs(qris: qris, response: response);
      } else {
        //TODO: Off Us belum fix!
        // final response = await inquiryOffUsQris(qris);
        // datas.assign(QrisType.offUs);
        Get.back();
        await EiduInfoDialog.showInfoDialog(
            title: 'Layanan dalam pengembangan. Akan segera hadir.');
      }
    }
  }

  Future<void> _bottomSheetProcessOnUs({
    required Qris qris,
    required InquiryQris response,
  }) async {
    final total = response.fee + response.amount;
    await EiduConfirmationBottomSheet.showBottomSheet(
      title: 'Konfirmasi Pembayaran',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 58,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xFFFCFBFC),
                borderRadius: BorderRadius.all(Radius.circular(14))),
            child: Text(
              qris.nama,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w400, color: t80),
            ),
          ),
          const SizedBox(height: 8),
          CustomSingleRowCard(
              title: 'Nominal', value: 'Rp ${response.amount.amountFormat}'),
          CustomSingleRowCard(
              title: 'Fee', value: 'Rp ${response.fee.amountFormat}'),
          CustomSingleRowCard(
              title: 'Berita',
              value: beritaController.text.isNotEmpty
                  ? beritaController.text
                  : '-'),
          const SizedBox(
            height: 16,
            child: DashLineDivider(color: Color(0xFFB8B8B8)),
          ),
          CustomSingleRowCard(
              title: 'Total Pembayaran',
              value: 'Rp ${total.amountFormat}',
              valueColor: green,
              valueSize: 18),
        ],
      ),
      color: green,
      secondaryColor: green,
      secondButtonText: 'Bayar',
      secondButtonOnPressed: () async {
        Get.back();
        List<dynamic>? results = await Get.to(
          () =>
              PinVerificationPage<QrisPaymentController>(pageController: this),
          arguments: datas,
        );

        final bool? isSuccess = results?[0];

        if (isSuccess != null && isSuccess) {
          await Get.toNamed(
            TransactionSuccessPage.route.name,
            arguments: PageArgument(
              title: 'BAYAR',
              ket1: response.merchantName,
              ket2: '',
              trxId: idTrx,
              biayaAdmin: 'Rp 0',
              nominal: 'Rp ${response.amount}',
              total: 'Rp $total',
            ),
          )?.then((_) => getBalance());
        }
      },
    );
  }
}
