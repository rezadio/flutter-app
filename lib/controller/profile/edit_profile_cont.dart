import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eidupay/model/account.dart';
import 'package:eidupay/model/default_model.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/app_config.dart';

class ProfileEditCont extends GetxController {
  final Network _network;
  ProfileEditCont(this._network);

  var nameCont = TextEditingController();
  var phoneCont = TextEditingController();
  var emailCont = TextEditingController();
  var dateOfBirthCont = TextEditingController();
  var inProgress = false.obs;
  var userInfo;
  var photoWidget = <ImageProvider>[].obs;

  late Account account;

  @override
  void onInit() async {
    super.onInit();
    inProgress(true);
    userInfo = json.decode(await getDataUser());

    nameCont.text = dtUser['nama'];
    phoneCont.text = dtUser['hp'];
    emailCont.text = userInfo['dataDiri'][0]['Email'] ?? '';
    dateOfBirthCont.text = userInfo['dataDiri'][0]['TanggalLahir'] ?? '';
    inProgress(false);
  }

  Future<String> getDataUser() async {
    final _uid = await getUid();
    final _package = await PackageInfo.fromPlatform();
    final _body = <String, dynamic>{
      'idAccount': dtUser['idAccount'],
      'packageName': _package.packageName,
      'phoneExtended': dtUser['hp'],
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': _uid,
      'versionCode': versionCode
    };

    final response = await _network.post(
        url: 'eidupay/register/getAccountInfo', body: _body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    return decryptedBody;
  }

  Future<void> getAccountInfo() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/account/getAccountInfo', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final accountModel = AccountModel.fromJson(decodedBody);
    dtUser = jsonDecode(_pref.getString(kDtUser) ?? '');
    account = accountModel.data.first;
  }

  Future<void> profilePictureTap() async {
    final _picker = ImagePicker();
    final xFile = await _picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      final image = File(xFile.path);
      EiduLoadingDialog.showLoadingDialog();
      final response = await _getUpdateProfile(image);
      Get.back();
      await EiduInfoDialog.showInfoDialog(
          title: response.pesan, icon: 'assets/lottie/success.json');
      await getAccountInfo();
      getProfilePicture(account.fotoProfile);
    }
  }

  Future<DefaultModel> _getUpdateProfile(File photo) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'id_memberaccount': _pref.getString(kUserId) ?? '',
      'fotoFaceBase64': base64Encode(await photo.readAsBytes()),
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/account/getUpdateProfile', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = DefaultModel.fromJson(decodedBody);
    return model;
  }

  void getProfilePicture(String fotoProfile) {
    final baseUrl = injector.get<AppConfig>().baseUrl;
    final port = injector.get<AppConfig>().port;
    if (fotoProfile.isNotEmpty) {
      photoWidget.assign(CachedNetworkImageProvider(
          '$baseUrl:$port/eidupay/home/getPicProfile/' + fotoProfile));
    } else {
      photoWidget.assign(const AssetImage('assets/images/default_profile.png'));
    }
  }

  void saveTap() {
    Get.back();
  }
}
