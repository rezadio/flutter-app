import 'dart:convert';

import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/model/balance.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/model/recent_transaction.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';

class EsamsatCont extends GetxController {
  final Network _network;
  EsamsatCont(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  final contKodeBayar = TextEditingController();
  final contInfo = TextEditingController();
  final contPenyedia = TextEditingController();
  final contNominal = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final refreshController = RefreshController();
  final favoriteController = TextEditingController();

  var favorite = false.obs;
  var nom = 0.obs;
  var idBiller = ''.obs;
  var infoSamsat = ''.obs;
  var val = 'token'.obs;
  var adminFee = 5000.obs;
  var biayaAdmin = '0'.obs;
  var hargaCetak = '0'.obs;
  var periodeTagihan = ''.obs;
  var inProccess = false.obs;
  var listRecent = [].obs;
  var savedName = <Favorite>[].obs;
  var cookie;
  var uid;
  var listProductEsamsat;
  var recentTrx = <DataLastTrx>[].obs;
  var balance = '0'.obs;
  Map<String, dynamic> denomSelected = {};
  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();

    inProccess(true);
    await getCookie();
    await getUid();
    listProductEsamsat = await getProductEsamsat();
    await getBalance();
    inProccess(false);
  }

  void clear() => contKodeBayar.clear();

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

  Future<void> getCookie() async {
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    uid = _pref.getString(kUid) ?? '';
  }

  Future<dynamic> getInqEsamsat() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idOperator': idBiller.value,
      'idAccount': dtUser['idAccount'],
      'idTrx': '3' + uid + timeStr,
      'idPelanggan': contKodeBayar.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/samsat/inqSamsat', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getProductEsamsat() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/samsat/getBiller', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> getRecentTrx(String idMenu) async {
    final header = {'Cookie': cookie.toString()};
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

  Future<void> continueTap() async {
    if (formKey.currentState!.validate()) {
      if (idBiller.value != null) {
        await _esamsat();
      }
    }
  }

  Future<dynamic> getPaySamsat(dataDenom, dataInq, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': dataInq['idTrx'],
      'idPelanggan': contKodeBayar.text,
      'deviceInfo': uid,
      'idOperator': idBiller.value,
      'versionCode': versionCode,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'pin': pin,
      if (favorite.value == true) 'namaAlias': favoriteController.text,
    };
    final response = await _network.post(
        url: 'eidupay/samsat/paySamsat', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(inquiry, String pin) async {
    return await getPaySamsat(inquiry[0], inquiry[1], pin);
  }

  Future<void> _esamsat() async {
    EiduLoadingDialog.showLoadingDialog();
    var inquiryResponse = await getInqEsamsat();
    Get.back();

    if (inquiryResponse['ACK'] == 'NOK') {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay',  description:
                StringUtils.stringToErrorMessage(inquiryResponse['pesan']));
      return;
    }

    if (inquiryResponse['ACK'] == 'OK') {
      hargaCetak.value = inquiryResponse['hargaCetak']!;
      biayaAdmin.value = inquiryResponse['biayaAdmin']!;
      var bayar = await showCupertinoModalPopup(
          context: navigatorKey.currentContext!,
          builder: (_) => confirmEsamsat(inquiryResponse));
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<EsamsatCont>(pageController: this),
          arguments: [idBiller.value, inquiryResponse],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          if (payResponse['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan E-Samsat',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: 'Rp. ' + hargaCetak.value,
                    total: 'Rp. ' + hargaCetak.value,
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    ket1: 'Nama Pemilik : ' + inquiryResponse['namaPemilik'],
                    ket2: 'Nomor Identitas : ' +
                        inquiryResponse['nomorIdentitas'],
                    ket3: 'Nomor Polisi : ' + inquiryResponse['nomorPolisi'],
                    trxId: inquiryResponse['idTrx']));
          } else if (payResponse['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan E-Samsat',
                    description: 'Pembayaran tagihan E-Samsat Berhasil!',
                    biayaAdmin: 'Rp. ' + biayaAdmin.value,
                    nominal: 'Rp. ' + inquiryResponse['tagihan'],
                    total: 'Rp. ' + hargaCetak.value,
                    ket1: 'Nama Pemilik : ' + inquiryResponse['namaPemilik'],
                    ket2: 'Nomor Identitas : ' +
                        inquiryResponse['nomorIdentitas'],
                    ket3: 'Nomor Polisi : ' + inquiryResponse['nomorPolisi'],
                    trxId: inquiryResponse['idTrx']));
          }
        }
      }
    }
  }

  Widget confirmEsamsat(data) {
    return Material(
      child: CupertinoActionSheet(
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
          const SizedBox(height: 18),
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
                  'Kode Bayar',
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
                ),
                Text(
                  contKodeBayar.text,
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
                ),
              ],
            ),
          ),
          SizedBox(height: w(10)),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: ExpandableNotifier(
              child: ExpandablePanel(
                header: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Detail',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: t100),
                  ),
                ),
                collapsed: Container(
                  child: const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  ),
                ),

                // ignore: avoid_unnecessary_containers
                expanded: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nomor Polisi',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              data['nomorPolisi'],
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Pemilik',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              data['namaPemilik'],
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alamat',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Expanded(
                              child: Text(
                                StringUtils.stringToSecureHalfText(data['alamatPemilik']),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: w(11),
                                    fontWeight: FontWeight.w700,
                                    color: t90),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Merek Kendaraan',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              data['namaMerekKb'],
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Model Kendaraan',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              data['namaModelKb'],
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nomor Mesin',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              StringUtils.stringToSecureHalfText(data['nomorMesin']),
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nomor Krangka',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              StringUtils.stringToSecureHalfText(data['nomorRangka']),
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w(10)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tahun Pembuatan',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w600,
                                  color: t70),
                            ),
                            Text(
                              data['tahunBuatan'],
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w700,
                                  color: t90),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                theme: const ExpandableThemeData(
                  tapHeaderToExpand: true,
                  tapBodyToExpand: false,
                  tapBodyToCollapse: false,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: true,
                ),
              ),
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
          SizedBox(height: w(10)),
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
                      fontSize: w(14), fontWeight: FontWeight.w700, color: t90),
                ),
              ],
            ),
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
                      fontSize: w(14),
                      fontWeight: FontWeight.bold,
                      color: t100),
                ),
                Text(
                  'Rp. ' + data['hargaCetak'],
                  style: TextStyle(
                      fontSize: w(16),
                      fontWeight: FontWeight.bold,
                      color: green),
                ),
              ],
            ),
          ),
          SizedBox(height: w(35)),
          SubmitButton(
            backgroundColor: green,
            text: 'Bayar',
            onPressed: () {
              final infoExtended = balanceModel.infoExtended;
              final dailyLimit =
                  int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
              final harga =
                  int.parse(data['hargaCetak'].toString().numericOnly());
              final saldo = int.parse(balance.value.toString().numericOnly());
              if (saldo < harga) {
                EiduInfoDialog.showInfoDialog(
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
                  EiduInfoDialog.showInfoDialog(
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
      )),
    );
  }
}
