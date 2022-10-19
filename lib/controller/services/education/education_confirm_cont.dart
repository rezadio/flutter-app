import 'dart:convert';

import 'package:eidupay/controller/services/education/edukasi_input_siswa_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/education.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/services/education/education_select_payment_method.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/extension.dart';

class EducationConfirmCont extends GetxController {
  final Network _network;
  EducationConfirmCont(this._network);

  var total = 0.obs;
  var totalFee = 0.obs;
  var jumBayar = 0.obs;
  var balance = '0'.obs;
  int fee = 0;
  final contJumlah = TextEditingController();
  final contNominal = TextEditingController();
  final contBerita = TextEditingController();
  final _contEdukasiInput = Get.find<EdukasiInputSiswaCont>();
  late List<InquiryListCategoryData> listPembayaran = [];
  late String cookie;
  late String uid;
  late BalanceModel balanceModel;
  late SharedPreferences _pref;
  final formKey = GlobalKey<FormState>();

  late EducationInquiry educationInquiry;
  var listCheck = <bool>[].obs;

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
    await getCookieAndUid();
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

  void setRadioValues(List<InquiryListCategoryData> datas) {
    for (var i = 0; i <= datas.length; i++) {
      listCheck.add(false);
    }
  }

  Future<void> getCookieAndUid() async {
    cookie = _pref.getString(kCookie) ?? '';
    uid = _pref.getString(kUid) ?? '';
  }

  Future<dynamic> pay(int paymentValue, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final dataListCategory = educationInquiry.inquiryListCategory;
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    var url = '';
    var body;
    if (contNominal.text.isEmpty) {
      url = 'eidupay/pendidikan/getPaymentEdukasi';
      body = <String, dynamic>{
        'pin': pin,
        'idTrx': '3' + uid + timeStr,
        'payerNumber': dtUser['idAccount'],
        'customerNumber': _contEdukasiInput.contNoInduk.text,
        'tagihan': totalFee.toString(),
        'totalEduBeli': totalFee.toString(),
        'reffNum': dataListCategory.reffNum,
        'hargaJual': educationInquiry.hargaJual.toString(),
        'hargaBeli': educationInquiry.hargaBeli.toString(),
        'merchantPhone': dataListCategory.merchantPhone,
        'merchantName': dataListCategory.merchantName,
        'customerName': dataListCategory.customerName,
        'kelas': dataListCategory.kelas,
        'bayar': (int.parse(contJumlah.text) - fee).toString(),
        'totalEduJual': contJumlah.text,
        'dataBill': listPembayaran.map((bill) => bill.toJson()).toList(),
        'deviceInfo': uid,
        'packageName': _packageInfo.packageName,
        'versionCode': versionCode,
        'tipe': type,
        if (type == 'extended') 'phoneExtended': dtUser['hp'],
        'idAccount': dtUser['idAccount'],
        'lang': '',
        if (paymentValue == 2) 'biller': 'indomart',
      };
    } else {
      url = 'eidupay/pendidikan/getPaymentEdukasiSukaSuka';
    }
    body = <String, dynamic>{
      'pin': pin,
      'idTrx': '3' + uid + timeStr,
      'payerNumber': dtUser['idAccount'],
      'customerNumber': _contEdukasiInput.contNoInduk.text,
      'amount': contJumlah.text,
      'biaya': '0',
      'reffNum': '3' + uid + timeStr,
      'total': contJumlah.text,
      'merchantPhone': dataListCategory.merchantPhone,
      'merchantName': dataListCategory.merchantName,
      'customerName': dataListCategory.customerName,
      'kelas': dataListCategory.kelas,
      'bayar': (int.parse(contJumlah.text) - fee).toString(),
      'billName': contBerita.text,
      'deviceInfo': uid,
      'packageName': _packageInfo.packageName,
      'versionCode': versionCode,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'idAccount': dtUser['idAccount'],
      'lang': '',
      if (paymentValue == 2) 'biller': 'indomart',
    };

    final response = await _network.post(url: url, header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  void checklistTap(int idx, InquiryListCategoryData data) {
    final dataListCategory = educationInquiry.inquiryListCategory;
    final fee = dataListCategory.serviceFee;
    final caraBayar = dataListCategory.caraBayar;
    var amt =
        data.amount.toString().substring(0, data.amount.toString().length - 2);

    final int _amount = int.parse(amt);

    listCheck[idx] = !listCheck[idx];
    if (listCheck[idx] == true) {
      total.value = total.value + _amount;
      listPembayaran.add(data);
    }
    if (listCheck[idx] == false) {
      total.value = total.value - _amount;
      listPembayaran.remove(data);
    }

    if (total.value == 0) {
      jumBayar.value = 0;
      totalFee.value = 0;
      contJumlah.text = '';
    } else {
      totalFee.value = total.value + fee;
    }

    if (caraBayar != 'partial') {
      jumBayar.value = totalFee.value;
      contJumlah.text = totalFee.value.toString();
    }
  }

  Future<void> continueTap() async {
    final infoExtended = balanceModel.infoExtended;
    final bayar = await EiduConfirmationBottomSheet.showBottomSheet(
      title: 'Konfirmasi Pembayaran',
      description: StringUtils.toTitleCase(
              educationInquiry.inquiryListCategory.customerName) +
          ' - ' +
          educationInquiry.inquiryListCategory.customerNumber,
      body: confirmBody(),
      firstButtonText: 'Batal',
      secondButtonText: 'Bayar',
      secondaryColor: green,
      firstButtonOnPressed: () {
        Get.back(result: false);
      },
      secondButtonOnPressed: () async {
        final dailyLimit =
            int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
        final jumlah = int.parse(contJumlah.text.numericOnly());
        final isBalanceEnough = int.parse(balance.value.numericOnly()) > jumlah;

        if (isBalanceEnough && infoExtended != null && dailyLimit != 0) {
          final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
              ? int.parse(infoExtended.extDailyUsed.numericOnly())
              : 0;
          if (dailyUsed + jumlah > dailyLimit) {
            await EiduInfoDialog.showInfoDialog(
                title: 'Daily limit sudah mencapai batas!');
            return;
          }
        } else if (!isBalanceEnough) {
          await EiduInfoDialog.showInfoDialog(title: 'Saldo anda tidak cukup');
          return;
        }
        Get.back(result: true);
      },
    );

    if (bayar) {
      final int paymentValue =
          await Get.toNamed(EducationSelectPaymentMethod.route.name);
      List<dynamic>? results = await Get.to(
        () => PinVerificationPage<EducationConfirmCont>(pageController: this),
        arguments: paymentValue,
      );
      final bool? isSuccess = results?[0];
      final response = results?[1];
      if (isSuccess != null && isSuccess) {
        await Get.offAllNamed(TransactionSuccessPage.route.name,
            arguments: PageArgument(
                title: 'Pembayaran Edukasi',
                subtitle: 'Transaksi Berhasil!',
                description: '',
                nominal: 'Rp. ' + (jumBayar.value - fee).amountFormat,
                total: 'Rp. ' + jumBayar.value.amountFormat,
                ket1: educationInquiry.inquiryListCategory.merchantName,
                ket2: 'Siswa : ' +
                    educationInquiry.inquiryListCategory.customerName,
                biayaAdmin: 'Rp. ' + fee.amountFormat,
                trxId: ''));
      }
    }
  }

  Future<void> continueSukaTap() async {
    final infoExtended = balanceModel.infoExtended;
    contJumlah.value = contNominal.value;
    fee = 0;
    if (formKey.currentState!.validate()) {}
    final bayar = await EiduConfirmationBottomSheet.showBottomSheet(
      title: 'Konfirmasi Pembayaran',
      description: educationInquiry.inquiryListCategory.customerNumber +
          ' - ' +
          StringUtils.toTitleCase(
              educationInquiry.inquiryListCategory.customerName),
      body: confirmBody(),
      firstButtonText: 'Batal',
      secondButtonText: 'Bayar',
      secondaryColor: green,
      firstButtonOnPressed: () {
        Get.back(result: false);
      },
      secondButtonOnPressed: () async {
        final dailyLimit =
            int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
        final jumlah = int.parse(contJumlah.text.numericOnly());
        final isBalanceEnough = int.parse(balance.value.numericOnly()) > jumlah;

        if (isBalanceEnough && infoExtended != null && dailyLimit != 0) {
          final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
              ? int.parse(infoExtended.extDailyUsed.numericOnly())
              : 0;
          if (dailyUsed + jumlah > dailyLimit) {
            await EiduInfoDialog.showInfoDialog(
                title: 'Daily limit sudah mencapai batas!');
            return;
          }
        } else if (!isBalanceEnough) {
          await EiduInfoDialog.showInfoDialog(title: 'Saldo anda tidak cukup');
          return;
        }
        Get.back(result: true);
      },
    );

    if (bayar) {
      final int paymentValue =
          await Get.toNamed(EducationSelectPaymentMethod.route.name);
      List<dynamic>? results = await Get.to(
        () => PinVerificationPage<EducationConfirmCont>(pageController: this),
        arguments: paymentValue,
      );
      final bool? isSuccess = results?[0];
      final response = results?[1];
      if (isSuccess != null && isSuccess) {
        await Get.offAllNamed(TransactionSuccessPage.route.name,
            arguments: PageArgument(
                title: 'Pembayaran Edukasi',
                subtitle: 'Transaksi Berhasil!',
                description: '',
                nominal:
                    'Rp. ' + (int.parse(contJumlah.text) - fee).amountFormat,
                total: 'Rp. ' + contJumlah.text,
                ket1: educationInquiry.inquiryListCategory.merchantName,
                ket2: 'Siswa : ' +
                    educationInquiry.inquiryListCategory.customerName,
                ket3: 'Berita : ' + contBerita.text,
                biayaAdmin: 'Rp. ' + fee.amountFormat,
                trxId: ''));
      }
    }
  }

  Widget confirmBody() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jumlah',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + (int.parse(contJumlah.text) - fee).amountFormat,
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Admin',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + fee.amountFormat,
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
                'Total ',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t70),
              ),
              Text(
                'Rp. ' + (int.parse(contJumlah.text)).amountFormat,
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
