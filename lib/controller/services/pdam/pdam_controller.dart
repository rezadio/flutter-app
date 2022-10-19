import 'dart:convert';

import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/recent_transaction.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/services/pdam/pdam_pick_area.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/extension.dart';

class PdamController extends GetxController {
  final Network _network;
  PdamController(this._network);

  var isChecked = false.obs;
  var recentTrx = <DataLastTrx>[].obs;
  var savedName = <Favorite>[].obs;

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  final formKey = GlobalKey<FormState>();
  final formKeyFavorit = GlobalKey<FormState>();
  final idController = TextEditingController();
  final areaContr = TextEditingController();
  final refreshController = RefreshController();
  final favoriteController = TextEditingController();
  var selectedArea = <String, dynamic>{};
  var cookie;
  var uid;
  var balance = '0'.obs;
  var inProccess = false.obs;
  void clear() => idController.clear();

  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

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

  Future<void> getRecentTrx(String idMenu) async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idMenu': idMenu,
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/home/getLastTrx', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final recentTrxModel = RecentTransaction.fromJson(decodedBody);
    recentTrx.addAll(recentTrxModel.dataLastTrx);
  }

  Future<DataFavorite> getFavorite(String idTipeTransaksi) async {
    final response = await _network.getFavorite(idTipeTransaksi);
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<dynamic> getInqPDAM() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idOperator': selectedArea['idOperator'],
      'idAccount': dtUser['idAccount'],
      'idTrx': '3' + uid + timeStr,
      'idPelanggan': idController.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/pdam/getInqPdam', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(inquiry, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idOperator': selectedArea['idOperator'],
      'idAccount': dtUser['idAccount'],
      'idTrx': inquiry['idTrx'],
      'idPelanggan': idController.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode,
      'pin': pin,
      if (isChecked.value == true) 'namaAlias': favoriteController.text,
    };

    final response = await _network.post(
        url: 'eidupay/pdam/bayarPdam', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  void areaTap() {
    Get.to(() => const PDAMGetArea());
  }

  Future<void> lanjutkanTap() async {
    if (isChecked.value) {
      if (favoriteController.text.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Nama Favorit belum di isi');
        return;
      }
    }
    if (areaContr.text == '') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Area belum dipilih!');
      return;
    }
    if (favoriteController.text == '' && isChecked.value) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Nama favorit belum diisi!');
      return;
    }

    if (formKey.currentState!.validate()) {
      EiduLoadingDialog.showLoadingDialog();
      var inquiryResponse = await getInqPDAM();
      Get.back();

      if (inquiryResponse['ACK'] == 'NOK') {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay',
            description:
                StringUtils.stringToErrorMessage(inquiryResponse['pesan']));
        return;
      }

      if (inquiryResponse['ACK'] == 'OK') {
        var bayar = await showCupertinoModalPopup(
            context: navigatorKey.currentContext!,
            builder: (_) => _confirmTagihan(inquiryResponse));
        if (bayar) {
          List<dynamic>? results = await Get.to(
            () => PinVerificationPage<PdamController>(pageController: this),
            arguments: inquiryResponse,
          );
          final bool? isSuccess = results?[0];
          final resBayarPDAM = results?[1];

          if (resBayarPDAM['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan Listrik',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: inquiryResponse['tagihan'],
                    total: inquiryResponse['hargaCetak'],
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'Periode : ' + ' ' + inquiryResponse['periode'],
                    biayaAdmin: inquiryResponse['biayaAdmin'],
                    trxId: ''));
          }
          if (resBayarPDAM['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan PDAM',
                    subtitle: 'Transaksi Berhasil!',
                    description: resBayarPDAM['pesan'],
                    nominal: inquiryResponse['tagihan'],
                    total: inquiryResponse['hargaCetak'],
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'Periode : ' + inquiryResponse['periode'].toString(),
                    biayaAdmin: inquiryResponse['biayaAdmin'],
                    trxId: ''));
          }
        }
      }
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    idController.dispose();
    super.dispose();
  }

  Widget _confirmTagihan(data) {
    return CupertinoActionSheet(
        message: Column(
      children: [
        Container(
          width: w(65),
          height: 5,
          color: Colors.grey[350],
        ),
        const SizedBox(height: 26),
        SizedBox(
          width: w(37),
          height: w(37),
          child: Image.asset('assets/images/ico_confirm_btm.png'),
        ),
        const SizedBox(height: 18),
        Text(
          'Konfirmasi',
          style: TextStyle(
              fontSize: w(22), fontWeight: FontWeight.w500, color: t100),
        ),
        const SizedBox(height: 20),
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
                'No. Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                idController.text,
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
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
                'Nama Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['nama'],
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
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
                'Periode Tagihan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['periode'].toString().substring(0, 1) + ' Bulan',
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
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
        SizedBox(height: w(20)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nominal',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                'Rp. ' + data['tagihan'],
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.bold, color: t90),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: w(36),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Admin',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                'Rp. ' + data['biayaAdmin'],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
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
                    fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
              ),
              Text(
                'Rp. ' + data['hargaCetak'],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        SizedBox(height: w(35)),
        SubmitButton(
          backgroundColor: green,
          text: 'Bayar',
          onPressed: () async {
            final infoExtended = balanceModel.infoExtended;
            final dailyLimit =
                int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
            final harga =
                int.parse(data['hargaCetak'].toString().numericOnly());
            final saldo = int.parse(balance.value.toString().numericOnly());
            if (saldo < harga) {
              await EiduInfoDialog.showInfoDialog(
                  title: 'Eidupay', description: 'Saldo tidak mencukupi!');
              return;
            }

            if (infoExtended != null && dailyLimit != 0) {
              final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
                  ? int.parse(infoExtended.extDailyUsed.numericOnly())
                  : 0;
              final harga =
                  int.parse(data['hargaCetak'].toString().numericOnly());
              if (dailyUsed + harga > dailyLimit) {
                await EiduInfoDialog.showInfoDialog(
                    title: 'Daily limit sudah mencapai batas!');
                return;
              }
            }
            Get.back(result: true);
          },
        ),
        SizedBox(height: w(17)),
        GestureDetector(
            onTap: () => Get.back(result: false),
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
            )),
        SizedBox(height: w(20)),
      ],
    ));
  }
}
