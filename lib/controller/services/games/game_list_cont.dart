import 'dart:convert';

import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/model/game.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/services/games/game_detail.dart';
import 'package:eidupay/view/services/games/voucher_detail.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameListCont extends GetxController {
  final Network _network;
  GameListCont(this._network);

  final listGames = <Game>[];
  final listVoucher = <Voucher>[];

  var inProgress = false.obs;
  String cookie = '';
  String uid = '';

  @override
  void onInit() async {
    super.onInit();

    inProgress(true);
    await getCookie();
    await getUid();
    await getGamesList();
    await getVoucherList();
    inProgress(false);
  }

  Future<void> getCookie() async {
    final _pref = await SharedPreferences.getInstance();
    cookie = _pref.getString(kCookie) ?? '';
  }

  Future<void> getUid() async {
    final _pref = await SharedPreferences.getInstance();
    uid = _pref.getString(kUid) ?? '';
  }

  Future<void> getGamesList() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/game/getListInGame', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = GameResponse.fromJson(decodedBody);
      final games = model.listGame;
      if (games != null && games.isNotEmpty) listGames.assignAll(games);
    } catch (_) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Terjadi Kesalahan, coba lagi.');
      rethrow;
    }
  }

  Future<void> getVoucherList() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/game/getListVoucher', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = VoucherResponse.fromJson(decodedBody);
      final vouchers = model.listVoucher;
      if (vouchers != null && vouchers.isNotEmpty) {
        listVoucher.assignAll(vouchers);
      }
    } catch (_) {
      await EiduInfoDialog.showInfoDialog(
          title: 'Terjadi Kesalahan, coba lagi.');
      rethrow;
    }
  }

  Future<GameDetailResponse> getDetailGame(Game game) async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'gameCode': game.gameCode
    };
    final response = await _network.post(
        url: 'eidupay/game/detailInGame', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = GameDetailResponse.fromJson(decodedBody);
      return model;
    } catch (_) {
      Get.back();
      final model = DefaultModel.fromJson(decodedBody);
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: model.pesan);
      rethrow;
    }
  }

  Future<VoucherDetail> getDetailVoucher(Voucher voucher) async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': cookie.toString()};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
      'voucherCode': voucher.voucherCode
    };
    final response = await _network.post(
        url: 'eidupay/game/detailVoucher', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = VoucherDetail.fromJson(decodedBody);
      return model;
    } catch (_) {
      Get.back();
      final model = DefaultModel.fromJson(decodedBody);
      await EiduInfoDialog.showInfoDialog(
          title: 'Eidupay', description: model.pesan);
      rethrow;
    }
  }

  Future<void> gameTap(Game game) async {
    EiduLoadingDialog.showLoadingDialog();
    final response = await getDetailGame(game);
    Get.back();
    await Get.toNamed(GameDetailPage.route.name, arguments: [game, response]);
  }

  Future<void> voucherTap(Voucher voucher) async {
    EiduLoadingDialog.showLoadingDialog();
    final response = await getDetailVoucher(voucher);
    Get.back();
    await Get.toNamed(VoucherDetailPage.route.name,
        arguments: [response, voucher.iconUrl]);
  }
}
