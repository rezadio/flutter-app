import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:eidupay/app_config.dart';
import 'package:eidupay/model/account.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/material.dart' as material;
import 'package:eidupay/tools.dart' as tools;
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/favorite.dart';
import 'package:eidupay/model/balance.dart';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/sub_account.dart';

final _aesKey = injector.get<AppConfig>().aesKey;
final _aesIv = injector.get<AppConfig>().aesIv;

class Network {
  static Network create() => Network();
  Future<http.StreamedResponse> post({
    int? port,
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    try {
      String debugLog = '\nPOST';
      port ??= tools.port;
      const oauthMethodHash = 'HMAC-SHA1';
      const oauthVersion = '1.0';
      var sharedSecret = 'true';
      final timeNow = DateTime.now().millisecondsSinceEpoch;
      final randomNum = math.Random().nextDouble();
      final subRandomNum = randomNum.toString().substring(2);
      final oauthNonce =
          int.parse(subRandomNum).toRadixString(36).toString().substring(1);
      material.debugPrint('oauthNonce: $oauthNonce');
      final oauthTimeStamp = (timeNow / 1000).floor();
      material.debugPrint('oauthTimeStamp: $oauthTimeStamp');
      final reqObject = <String, dynamic>{
        'oauth_consumer_key': sharedSecret,
        'oauth_nonce': oauthNonce,
        'oauth_signature_method': oauthMethodHash,
        'oauth_timestamp': oauthTimeStamp,
        'oauth_version': oauthVersion,
      };

      var paramString = '';
      reqObject.forEach((key, value) {
        paramString += '&$key=$value';
      });
      material.debugPrint('paramString: $paramString');

      paramString = paramString.substring(1);
      material.debugPrint('paramString: $paramString');

      final _baseUrl = injector.get<AppConfig>().baseUrl;
      final _fatSecretRestUrl = '$_baseUrl:$port/$url';

      final baseUrl = 'POST&' +
          Uri.encodeComponent(_fatSecretRestUrl) +
          '&' +
          Uri.encodeComponent(paramString);
      sharedSecret += '&';
      material.debugPrint(sharedSecret);
      material.debugPrint(baseUrl);

      // using crypto
      final hmac = crypto.Hmac(crypto.sha1, utf8.encode(sharedSecret));
      final hashedBaseString = hmac.convert(utf8.encode(baseUrl));
      final hashed64 = base64.encode(hashedBaseString.bytes);
      material.debugPrint('hashedBaseString: $hashedBaseString');
      material.debugPrint('hashed64: $hashed64');

      final bodyJson = jsonEncode(body);

      material.debugPrint('url: $_fatSecretRestUrl');
      material.debugPrint('body: $bodyJson');

      // Using Encrypt Package
      final key = Key.fromUtf8(_aesKey);
      final iv = IV.fromUtf8(_aesIv);
      final aesEncrypt =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final encryptedData = aesEncrypt.encrypt(bodyJson, iv: iv);
      material.debugPrint('Encrypted Request Data: ${encryptedData.base64}');

      final _body = <String, String>{
        'action': encryptedData.base64,
        'oauth_nonce': oauthNonce,
        'oauth_signature': hashed64,
        'oauth_consumer_key': 'true',
        'oauth_timestamp': oauthTimeStamp.toString(),
        'oauth_signature_method': oauthMethodHash,
        'oauth_version': oauthVersion,
        'secretKeyHeader': 'true',
      };

      var request = http.MultipartRequest('POST', Uri.parse(_fatSecretRestUrl))
        ..fields.addAll(_body);

      if (header != null) request.headers.addAll(header);

      http.StreamedResponse response = await request.send().timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw TimeoutException('Connection Timed Out!'));

      return response;
    } on SocketException catch (_) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(
          title: 'Terjadi masalah saat menghubungkan ke server');
      rethrow;
    } on TimeoutException catch (e) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: e.message!);
      rethrow;
    } on HandshakeException catch (_) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: 'Terjadi masalah, coba lagi');
      rethrow;
    } catch (e) {
      material.debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<String> post2({
    int? port,
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    try {
      String debugLog = '\nPOST';
      port ??= tools.port;
      const oauthMethodHash = 'HMAC-SHA1';
      const oauthVersion = '1.0';
      var sharedSecret = 'true';
      final timeNow = DateTime.now().millisecondsSinceEpoch;
      final randomNum = math.Random().nextDouble();
      final subRandomNum = randomNum.toString().substring(2);
      final oauthNonce =
          int.parse(subRandomNum).toRadixString(36).toString().substring(1);
      // material.debugPrint('oauthNonce: $oauthNonce');
      final oauthTimeStamp = (timeNow / 1000).floor();
      // material.debugPrint('oauthTimeStamp: $oauthTimeStamp');

      final reqObject = <String, dynamic>{
        'oauth_consumer_key': sharedSecret,
        'oauth_nonce': oauthNonce,
        'oauth_signature_method': oauthMethodHash,
        'oauth_timestamp': oauthTimeStamp,
        'oauth_version': oauthVersion,
      };

      var paramString = '';
      reqObject.forEach((key, value) {
        paramString += '&$key=$value';
      });
      // material.debugPrint('paramString: $paramString');

      paramString = paramString.substring(1);
      // material.debugPrint('paramString: $paramString');

      final _baseUrl = injector.get<AppConfig>().baseUrl;
      final _fatSecretRestUrl = '$_baseUrl:$port/$url';

      final baseUrl = 'POST&' +
          Uri.encodeComponent(_fatSecretRestUrl) +
          '&' +
          Uri.encodeComponent(paramString);
      sharedSecret += '&';
      // material.debugPrint(sharedSecret);
      // material.debugPrint(baseUrl);

      // using crypto
      final hmac = crypto.Hmac(crypto.sha1, utf8.encode(sharedSecret));
      final hashedBaseString = hmac.convert(utf8.encode(baseUrl));
      final hashed64 = base64.encode(hashedBaseString.bytes);
      // material.debugPrint('hashedBaseString: $hashedBaseString');
      // material.debugPrint('hashed64: $hashed64');

      final bodyJson = jsonEncode(body);
      debugLog += _fatSecretRestUrl;
      debugLog += '\n[REQUEST]\n' + bodyJson;
      // material.debugPrint('url: $_fatSecretRestUrl');
      // material.debugPrint('body: $bodyJson');

      // Using Encrypt Package
      final key = Key.fromUtf8(_aesKey);
      final iv = IV.fromUtf8(_aesIv);
      final aesEncrypt =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final encryptedData = aesEncrypt.encrypt(bodyJson, iv: iv);
      // material.debugPrint('Encrypted Request Data: ${encryptedData.base64}');

      final _body = <String, String>{
        'action': encryptedData.base64,
        'oauth_nonce': oauthNonce,
        'oauth_signature': hashed64,
        'oauth_consumer_key': 'true',
        'oauth_timestamp': oauthTimeStamp.toString(),
        'oauth_signature_method': oauthMethodHash,
        'oauth_version': oauthVersion,
        'secretKeyHeader': 'true',
      };

      var request = http.MultipartRequest('POST', Uri.parse(_fatSecretRestUrl))
        ..fields.addAll(_body);

      if (header != null) request.headers.addAll(header);

      http.StreamedResponse response = await request.send().timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw TimeoutException('Connection Timed Out!'));
      String respString = decrypt(await response.stream.bytesToString());
      debugLog += '\n[RESPONSE]\n' + respString;
      //  material.debugPrint('response: ' + respString);
      material.debugPrint(debugLog);
      return respString;
    } on SocketException catch (_) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(
          title: 'Terjadi masalah saat menghubungkan ke server');
      rethrow;
    } on TimeoutException catch (e) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: e.message!);
      rethrow;
    } on HandshakeException catch (_) {
      Get.back();
      await EiduInfoDialog.showInfoDialog(title: 'Terjadi masalah, coba lagi');
      rethrow;
    } catch (e) {
      material.debugPrint(e.toString());
      throw Exception(e);
    }
  }

  String decrypt(String cipherText) {
    try {
      final key = Key.fromUtf8(_aesKey);
      final iv = IV.fromUtf8(_aesIv);
      final aes = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      return aes.decrypt(Encrypted.fromBase64(cipherText), iv: iv);
    } catch (e) {
      Get.back();
      EiduInfoDialog.showInfoDialog(title: 'Terjadi masalah, coba lagi');
      rethrow;
    }
  }

  Future<DataFavorite> getFavorite(String idTipeTransaksi) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(tools.kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(tools.kUserId) ?? '',
      'idTipeTransaksi': idTipeTransaksi,
      'packageName': _package.packageName,
      'tipe': _pref.getString(tools.kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(tools.kUid) ?? '',
      'versionCode': tools.versionCode
    };
    final response = await post(
        port: tools.port,
        url: 'eidupay/favorite/getListFavorite',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    try {
      final model = DataFavorite.fromJson(decodedBody);
      return model;
    } catch (e) {
      final defaultModel = DefaultModel.fromJson(decodedBody);
      rethrow;
    }
  }

  Future<BalanceModel> getBalance() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(tools.kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(tools.kUserId) ?? '',
      'tipe': _pref.getString(tools.kUserType) ?? '',
      'deviceInfo': _pref.getString(tools.kUid) ?? '',
      'versionCode': tools.versionCode,
      'phoneExtended': tools.dtUser['hp'],
    };
    final response =
        await post(url: 'eidupay/home/getBalance', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final balanceModel = BalanceModel.fromJson(decodedBody);
    if (_pref.getString(kIsUpdate) != 'true') {
      if (_pref.getString(kIsPushVersion) != 'true') {
        await EiduInfoDialog.showInfoDialog(
            title:
                'EiduPay versi terbaru telah tersedia, silahkan lakukan update',
            icon: 'assets/lottie/warning.json');

        await LaunchReview.launch(
            androidAppId: 'id.co.eidu.mobile', iOSAppId: 'id.co.eidu.mobile');
      }
    }

    return balanceModel;
  }

  Future<SubAccountDetail> getExt() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(tools.kCookie) ?? ''};
    final _package = await PackageInfo.fromPlatform();
    final body = <String, String>{
      'idExt': _pref.getString(tools.kHp) ?? '',
      'idAccount': _pref.getString(tools.kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(tools.kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(tools.kUid) ?? '',
      'versionCode': tools.versionCode,
    };
    final response =
        await post(url: 'eidupay/extended/getExt', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);

    final subDetail = SubAccountDetail.fromJson(decodedBody);
    return subDetail;
  }

  Future<AccountModel> getAccountInfo() async {
    final _pref = await SharedPreferences.getInstance();
    final header = {'Cookie': _pref.getString(tools.kCookie) ?? ''};
    final _package = await PackageInfo.fromPlatform();
    final body = <String, dynamic>{
      'phoneExtended': _pref.getString(tools.kUserType) == 'extended'
          ? _pref.getString(tools.kHp)
          : null,
      'idAccount': _pref.getString(tools.kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(tools.kUserType) ?? '',
      'deviceInfo': _pref.getString(tools.kUid) ?? '',
      'versionCode': tools.versionCode,
    };
    final response = await post(
        url: 'eidupay/account/getAccountInfo', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final account = AccountModel.fromJson(decodedBody);

    return account;
  }
}
