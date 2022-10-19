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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';

class ListrikCont extends GetxController {
  final Network _network;
  ListrikCont(this._network);

  late BalanceModel balanceModel;
  late SharedPreferences _pref;

  final contNoPelanggan = TextEditingController();
  final contNominal = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final refreshController = RefreshController();
  final favoriteController = TextEditingController();

  var favorite = false.obs;
  var nom = 0.obs;
  var val = 'token'.obs;
  var adminFee = 5000.obs;
  var inProccess = false.obs;
  var listRecent = [].obs;
  var savedName = <Favorite>[].obs;
  var cookie;
  var uid;
  var dataDenomListrik;
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
    dataDenomListrik = await getDenomToken();
    await getBalance();
    inProccess(false);
  }

  void clear() => contNoPelanggan.clear();
  void clearNominal() => contNominal.clear();

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

  Future<DataFavorite> getFavorite(String idTipeTransaksi) async {
    final response = await _network.getFavorite(idTipeTransaksi);
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<dynamic> getDenomToken() async {
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
        url: 'eidupay/listrik/getDenom', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getInqToken() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idDenom': denomSelected['idDenom'],
      'idAccount': dtUser['idAccount'],
      'idTrx': '3' + uid + timeStr,
      'idPelanggan': contNoPelanggan.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/listrik/getInqPlnToken', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getPayToken(dataDenom, dataInq, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': dataInq['idTrx'],
      'reffId': dataInq['reffid'],
      'idPelanggan': dataInq['idPelanggan'],
      'deviceInfo': uid,
      'versionCode': versionCode,
      'idDenom': dataDenom['idDenom'],
      'nominal': dataDenom['nominal'],
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'pin': pin,
      if (favorite.value == true) 'namaAlias': favoriteController.text,
    };
    final response = await _network.post(
        url: 'eidupay/listrik/bayarPlnToken', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getInqTagihan() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final timeNow = DateTime.now();
    final timeStr = DateFormat('yyMMddHHmmss').format(timeNow);
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': '3' + uid + timeStr,
      'idPelanggan': contNoPelanggan.text,
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/listrik/getInqPlnTagihan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> getPayTagihan(dataInq, String pin) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'];
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'idTrx': dataInq['idTrx'],
      'idPelanggan': dataInq['idPelanggan'],
      'packageName': _packageInfo.packageName,
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode,
      'pin': pin,
      if (favoriteController.text.isNotEmpty)
        'namaAlias': favoriteController.text,
    };
    final response = await _network.post(
        url: 'eidupay/listrik/bayarPlnTagihan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<dynamic> pay(inquiry, String pin) async {
    if (val.value == 'token') {
      return await getPayToken(inquiry[0], inquiry[1], pin);
    } else if (val.value == 'tagihan') {
      return await getPayTagihan(inquiry, pin);
    }
  }

  void nominalTap(BuildContext context, dataDenom) {
    nom.value = int.parse(dataDenom['nominal'].toString().numericOnly());
    denomSelected = dataDenom;
    contNominal.text = dataDenom['nominal'];
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<void> continueTap() async {
    if (favorite.value) {
      if (favoriteController.text.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Nama Favorit belum di isi');
        return;
      }
    }
    if (formKey.currentState!.validate()) {
      if (val.value == 'token') {
        await _token();
      } else if (val.value == 'tagihan') {
        await _tagihan();
      }
    }
  }

  Future<void> _token() async {
    //cek saldo apakah cukup
    final int lastBalance = int.parse(balance.value.numericOnly());
    final int hrg =
        int.parse(denomSelected['hargaCetak'].toString().numericOnly());
    if (lastBalance < hrg) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: 'Saldo tidak mencukupi!');
      return;
    }

    final infoExtended = balanceModel.infoExtended;
    final dailyLimit =
        int.parse(infoExtended?.extDailyLimit.numericOnly() ?? '0');
    if (infoExtended != null && dailyLimit != 0) {
      final dailyUsed = infoExtended.extDailyUsed.isNotEmpty
          ? int.parse(infoExtended.extDailyUsed.numericOnly())
          : 0;
      final harga =
          int.parse(denomSelected['hargaCetak'].toString().numericOnly());
      if (dailyUsed + harga > dailyLimit) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Daily limit sudah mencapai batas!');
        return;
      }
    }

    EiduLoadingDialog.showLoadingDialog();
    var inquiryResponse = await getInqToken();
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
          builder: (_) => confirmToken(inquiryResponse));
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<ListrikCont>(pageController: this),
          arguments: [denomSelected, inquiryResponse],
        );

        final bool? isSuccess = results?[0];
        final payResponse = results?[1];

        if (isSuccess != null && isSuccess) {
          if (payResponse['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Token Listrik',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: 'Rp. ' + denomSelected['hargaCetak'],
                    total: 'Rp. ' + denomSelected['hargaCetak'],
                    ket1:
                        'Nama Pelanggan : ' + inquiryResponse['namapelanggan'],
                    ket2: 'No Pelanggan : ' + contNoPelanggan.text,
                    ket3: 'Nominal : ' + denomSelected['nominal'],
                    trxId: inquiryResponse['idTrx']));
          } else if (payResponse['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Token Listrik',
                    description: 'Pembelian Token Listrik  Berhasil!',
                    nominal: 'Rp. ' + denomSelected['hargaCetak'],
                    total: 'Rp. ' + denomSelected['hargaCetak'],
                    ket1:
                        'Nama Pelanggan : ' + inquiryResponse['namapelanggan'],
                    ket2: 'No Pelanggan : ' + contNoPelanggan.text,
                    ket3: 'Token Listrik : ' +
                        payResponse['pesan'].toString().substring(0, 24),
                    trxId: inquiryResponse['idTrx']));
          }
        }
      }
    }
  }

  Future<void> _tagihan() async {
    EiduLoadingDialog.showLoadingDialog();
    var inquiryResponse = await getInqTagihan();
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
          builder: (_) => confirmTagihan(inquiryResponse));
      if (bayar) {
        List<dynamic>? results = await Get.to(
          () => PinVerificationPage<ListrikCont>(pageController: this),
          arguments: inquiryResponse,
        );

        final bool? isSuccess = results?[0];
        final resPayTagihan = results?[1];

        if (isSuccess != null && isSuccess) {
          if (resPayTagihan['ACK'] == 'PENDING') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan Listrik',
                    description: 'Transaksi anda sedang di proses.',
                    nominal: 'Rp. ' + inquiryResponse['tagihan'],
                    total: 'Rp. ' + inquiryResponse['hargaCetak'],
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'No Pelanggan : ' + contNoPelanggan.text,
                    ket3: 'Periode : ' + ' ' + inquiryResponse['periode'],
                    biayaAdmin: 'Rp. ' + inquiryResponse['biayaAdmin'],
                    trxId: ''));
          } else if (resPayTagihan['ACK'] == 'OK') {
            await Get.offAllNamed(TransactionSuccessPage.route.name,
                arguments: PageArgument(
                    title: 'Tagihan Listrik',
                    subtitle: 'Transaksi Berhasil!',
                    description: resPayTagihan['pesan'],
                    nominal: 'Rp. ' + inquiryResponse['tagihan'],
                    total: 'Rp. ' + inquiryResponse['hargaCetak'],
                    ket1: 'Nama Pelanggan : ' + inquiryResponse['nama'],
                    ket2: 'No Pelanggan : ' + contNoPelanggan.text,
                    ket3: 'Periode : ' + ' ' + inquiryResponse['periode'],
                    biayaAdmin: 'Rp. ' + inquiryResponse['biayaAdmin'],
                    trxId: ''));
          }
        }
      }
    }
  }

  Widget confirmToken(data) {
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
                'No. Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['idPelanggan'],
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w700, color: t90),
              ),
            ],
          ),
        ),
        SizedBox(height: h(10)),
        SizedBox(height: h(10)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              SizedBox(
                width: 120.0,
                child: Text(
                  data['namapelanggan'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.right,
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
                'Rp. ' +
                    (int.parse(data['hargaCetak']))
                        .amountFormat
                        .replaceAll(',', '.'),
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
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
                'Total Pembayaran',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
              ),
              Text(
                'Rp. ' +
                    (int.parse(data['hargaCetak']))
                        .amountFormat
                        .replaceAll(',', '.'),
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.bold, color: green),
              ),
            ],
          ),
        ),
        SizedBox(height: w(35)),
        SubmitButton(
          backgroundColor: green,
          text: 'Bayar',
          onPressed: () => Get.back(result: true),
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

  Widget confirmTagihan(data) {
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
                'No. Pelanggan',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['idPelanggan'],
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
                'Tagihan Listrik Periode',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w600, color: t70),
              ),
              Text(
                data['periode'],
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
              SizedBox(
                width: 120.0,
                child: Text(
                  data['nama'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
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
                    fontSize: w(14), fontWeight: FontWeight.bold, color: t100),
              ),
              Text(
                'Rp. ' + data['hargaCetak'],
                style: TextStyle(
                    fontSize: w(16), fontWeight: FontWeight.bold, color: green),
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
    ));
  }
}
