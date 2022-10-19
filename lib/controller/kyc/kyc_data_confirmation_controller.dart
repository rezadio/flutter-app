import 'dart:convert';
import 'dart:io';

import 'package:eidupay/model/account.dart';
import 'package:eidupay/model/address.dart';
import 'package:eidupay/model/negara.dart';
import 'package:eidupay/model/occupation.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/view/kyc/kyc_success_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/tools.dart';

class KycDataConfirmationController extends GetxController {
  final Network _network;
  KycDataConfirmationController(this._network);

  final text =
      'Data pribadi Anda telah diambil. Pastikan semua data yang Anda isi sesuai dengan dokumen';
  final statementText =
      'Dengan ini saya menyatakan bahwa data yang saya berikan adalah benar';
  final dataNegara = <Negara>[];
  var isChecked = false.obs;
  var isAddressChanged = false.obs;
  var isPekerjaanLainnya = false.obs;
  var profession = ''.obs;
  var gender = 'default'.obs;
  var year = ''.obs;
  var month = ''.obs;
  var date = ''.obs;

  var provinsi = ''.obs;
  var kota = ''.obs;
  var kecamatan = ''.obs;
  var kelurahan = ''.obs;
  var kodepos = 0.obs;
  var countryCode = 'NN'.obs;

  var provinsi2 = ''.obs;
  var kota2 = ''.obs;
  var kecamatan2 = ''.obs;
  var kelurahan2 = ''.obs;
  var kodepos2 = 0.obs;

  var provinsiId = 0.obs;
  var provinsiId2 = 0.obs;
  var kotaId = 0.obs;
  var kotaId2 = 0.obs;
  var kecamatanId = 0.obs;
  var kecamatanId2 = 0.obs;
  var kelurahanId = 0.obs;
  var kelurahanId2 = 0.obs;

  final formKey = GlobalKey<FormState>();
  final nikController = TextEditingController();
  final nameController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final birthDateController = TextEditingController();
  final emailController = TextEditingController();
  final professionController = TextEditingController();
  final motherNameController = TextEditingController();

  //Address 1
  final addressController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();
  final postCodeController = TextEditingController();

  //Address 2
  final address2Controller = TextEditingController();
  final rt2Controller = TextEditingController();
  final rw2Controller = TextEditingController();
  final postCode2Controller = TextEditingController();

  var listOcupation = <Occupation>[].obs;
  var listProvince = <AddressData>[].obs;
  late AccountModel accountData;
  Future<void> initData() async {
    accountData = await _network.getAccountInfo();
    Account account = accountData.data[0];

    nikController.text = account.noKtp.toLowerCase();
    emailController.text = account.email.toLowerCase();
    nameController.text = account.name;
    postCodeController.text = account.kodePos;
    addressController.text = account.alamat;
    motherNameController.text = account.namaIbuKandung;
    birthPlaceController.text = account.tempatLahir;
    birthDateController.text = account.tanggalLahir;
    if (account.jenisKelamin == 'L') gender.value = 'laki-laki';
    if (account.jenisKelamin == 'P') gender.value = 'perempuan';
  }

  // void setText(RecognisedText ocr) {
  //   final parsedText = ocr.text;
  //   if (parsedText.isNotEmpty) {
  //     if (RegExp(r'(\d{2}-\d{2}-\d{4})').hasMatch(parsedText)) {
  //       final start = parsedText.indexOf(RegExp(r'(\d{2}-\d{2}-\d{4})'));
  //       birthDateController.text = parsedText.substring(start, start + 10);
  //     }
  //     if (RegExp(r'(\d{16})').hasMatch(parsedText)) {
  //       final start = parsedText.indexOf(RegExp(r'(\d{16})'));
  //       nikController.text = parsedText.substring(start, start + 16);
  //     }
  //     if (parsedText.contains('LAKI')) {
  //       gender.value = 'laki-laki';
  //     }
  //     if (parsedText.contains('PEREMPUAN')) {
  //       gender.value = 'perempuan';
  //     }
  //   }
  // }

  Future<List<Occupation>> getOccupation(String? query, String? limit) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'query': query ?? '',
      'limit': limit ?? '5',
      'idAccount': _pref.getString(kUserId),
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType),
      'deviceInfo': _pref.getString(kUid),
      'lang': '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getOccupation', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = OccupationResponse.fromJson(decodedBody);
    listOcupation.value = model.data;
    return model.data;
  }

  Future<List<AddressData>> getListProvinsi(String? provinsi) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'query': provinsi ?? '',
      'limit': 50,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getProvinsi', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = AddressResponse.fromJson(decodedBody);
    listProvince.value = model.data;
    return model.data;
  }

  Future<List<AddressData>> getListKota(String kota, int provinsiId) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'query': kota,
      'parentId': provinsiId,
      'limit': 25,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getKota', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = AddressResponse.fromJson(decodedBody);
    return model.data;
  }

  Future<List<AddressData>> getListKecamatan(
      String kecamatan, int kotaId) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'query': kecamatan,
      'parentId': kotaId,
      'limit': 25,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getKecamatan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = AddressResponse.fromJson(decodedBody);
    return model.data;
  }

  Future<List<AddressData>> getListKelurahan(
      String kelurahan, int kecamatanId) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'query': kelurahan,
      'parentId': kecamatanId,
      'limit': 25,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getKelurahan', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = AddressResponse.fromJson(decodedBody);
    return model.data;
  }

  Future<List<AddressData>> getKodePos(int kelurahanId) async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'parentId': kelurahanId,
      'limit': 25,
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getKodePos', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = AddressResponse.fromJson(decodedBody);
    return model.data;
  }

  Future<void> getListNegara() async {
    final _pref = await SharedPreferences.getInstance();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'lang': '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/register/getListNegara', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final model = NegaraResponse.fromJson(decodedBody);
    dataNegara.assignAll(model.dataNegara);
  }

  Future<dynamic> upgrade(File ktpMuka, File ktp) async {
    try {
      setDate();
      final _pref = await SharedPreferences.getInstance();
      final _package = await PackageInfo.fromPlatform();
      final header = {'Cookie': _pref.getString(kCookie) ?? ''};
      final body = <String, String>{
        'id_memberaccount': _pref.getString(kUserId) ?? '',
        'identitas': 'KTP',
        'fotoKtpMukaBase64': base64Encode(await ktpMuka.readAsBytes()),
        'wargaNegara': countryCode.value,
        'tanggalLahir': '${year.value}-${month.value}-${date.value}',
        'namaIbuKandung': motherNameController.text,
        'kartuIdentitas': nikController.text,
        'pekerjaan': profession.value,
        'provinsi': provinsi.value,
        'kecamatan': kecamatan.value,
        'kelurahan': kelurahan.value,
        'kota': kota.value,
        'rt': rtController.text,
        'rw': rwController.text,
        'alamat': addressController.text,
        'kodePos': postCodeController.text,
        // jika alamat berubah
        if (isAddressChanged.value) 'provinsi2': provinsi2.value,
        if (isAddressChanged.value) 'kecamatan2': kecamatan2.value,
        if (isAddressChanged.value) 'kelurahan2': kelurahan2.value,
        if (isAddressChanged.value) 'kota2': kota.value,
        if (isAddressChanged.value) 'rt2': rt2Controller.text,
        if (isAddressChanged.value) 'rw2': rw2Controller.text,
        if (isAddressChanged.value) 'alamat2': address2Controller.text,
        if (isAddressChanged.value) 'kodePos2': postCode2Controller.text,
        'tempatLahir': birthPlaceController.text,
        'jenisKelamin': gender.value,
        'fotoKtpBase64': base64Encode(await ktp.readAsBytes()),
        'namaLengkap': nameController.text,
        'email': emailController.text,
        'packageName': _package.packageName,
        'tipe': _pref.getString(kUserType) ?? '',
        'lang': '',
        'deviceInfo': _pref.getString(kUid) ?? '',
        'versionCode': versionCode
      };
      final response = await _network.post(
          url: 'eidupay/register/getUpgrade', header: header, body: body);
      final bodyResponse = await response.stream.bytesToString();
      final decryptedBody = _network.decrypt(bodyResponse);
      final decodedBody = jsonDecode(decryptedBody);
      return decodedBody;
    } catch (e) {
      Get.back();
      rethrow;
    }
  }

  void setDate() {
    final splittedDate = birthDateController.text.split('-');
    year.value = splittedDate[2];
    month.value = splittedDate[1];
    date.value = splittedDate[0];
  }

  bool toggleAddressChanged() =>
      isAddressChanged.value = !isAddressChanged.value;

  bool toggleStatementCheck() => isChecked.value = !isChecked.value;

  Future<void> process(File face, File ktp) async {
    if (formKey.currentState?.validate() == true) {
      EiduLoadingDialog.showLoadingDialog();
      final response = await upgrade(face, ktp);
      Get.back();
      if (response['RC'] == '99') {
        await EiduInfoDialog.showInfoDialog(title: response['pesan']);
        return;
      }
      await deleteTempPictureDirectory(face, ktp);
      await Get.offNamed(KycSuccessPage.route.name, arguments: response);
    }
  }

  Future<void> deleteTempPictureDirectory(File face, File ktp) async {
    if (Platform.isAndroid) {
      await face.delete();
      await ktp.delete();
    } else if (Platform.isIOS) {
      final docsDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory(docsDir.path + '/camera/pictures/');
      imageDir.deleteSync(recursive: true);
    }
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    nikController.dispose();
    nameController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    professionController.dispose();
    motherNameController.dispose();
    addressController.dispose();
    rtController.dispose();
    rwController.dispose();
    postCodeController.dispose();

    address2Controller.dispose();
    rt2Controller.dispose();
    rw2Controller.dispose();
    postCode2Controller.dispose();
    super.dispose();
  }
}
