import 'dart:convert';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/pulsa_model.dart';
import 'package:eidupay/model/recent_transaction.dart';
import 'package:eidupay/view/services/pulsa/pulsa_list_produk.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';

class PulsaCont extends GetxController {
  final Network _network;
  PulsaCont(this._network);

  final contNoHp = TextEditingController();
  final favoriteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late PulsaRest listPulsa;

  var cookie;
  var uid;
  var listData;
  var savedName = <Favorite>[].obs;
  var isChecked = false.obs;
  var recentTrx = <DataLastTrx>[].obs;
  var idMenu;
  var inProgress = false.obs;

  @override
  void onInit() async {
    super.onInit();

    inProgress(true);
    contNoHp.text = dtUser['hp'] ?? '';
    await getCookie();
    await getUid();
    await getRecentTrx(idMenu);
    await getFavorite(idMenu);
    inProgress(false);
  }

  void clear() => contNoHp.clear();

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
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

  Future<PulsaRest> getDenom() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'prefix': contNoHp.text.substring(0, 4),
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/pulsa/getDenom', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return PulsaRest.fromJson(decodedBody);
  }

  Future<DataRest> getDenomData() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'prefix': contNoHp.text.substring(0, 4),
      'packageName': _packageInfo.packageName,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': uid,
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/paketData/getDenom', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return DataRest.fromJson(decodedBody);
  }

  Future<DataFavorite> getFavorite(String idTipeTransaksi) async {
    final response = await _network.getFavorite(idTipeTransaksi);
    savedName.assignAll(response.dataFavorite);
    return response;
  }

  Future<void> continueTap(String noHp, id) async {
    if (isChecked.value) {
      if (favoriteController.text.isEmpty) {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: 'Nama Favorit belum di isi');
        return;
      }
    }
    if (formKey.currentState!.validate()) {
      EiduLoadingDialog.showLoadingDialog();
      listPulsa = await getDenom();
      listData = await getDenomData();
      Get.back();

      if (listPulsa.dataDenom.isNotEmpty) {
        await Get.toNamed(PulsaListProduk.route.name);
      }
    }
  }
}
