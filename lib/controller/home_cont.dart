import 'dart:convert';

import 'package:eidupay/controller/auth_controller.dart';
import 'package:eidupay/controller/services/services_cont.dart';
import 'package:eidupay/controller/transaction_controller.dart';
import 'package:eidupay/model/account.dart';
import 'package:eidupay/model/education.dart';
import 'package:eidupay/model/home.dart';
import 'package:eidupay/model/mutasi.dart';
import 'package:eidupay/model/statement.dart';
import 'package:eidupay/model/sub_account.dart';
import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/view/login.dart';
import 'package:eidupay/view/profile/profile.dart';
import 'package:eidupay/view/services/services_page.dart';
import 'package:eidupay/view/notification/notification_page.dart';
import 'package:eidupay/view/sub_account/sub_account_list_page.dart';
import 'package:eidupay/view/sub_account/sub_account_on_board_page.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/view/transaction_page.dart';
import 'package:eidupay/view/transfer/transfer_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_bottom_sheet.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/app_config.dart';

class HomeCont extends GetxController {
  final Network _network;
  HomeCont(this._network);

  late SharedPreferences _pref;

  final refreshController = RefreshController();
  final subAccountText =
      'Praktisnya berbagi kemudahan pada orang terdekat untuk bertransaksi menggunakan sejumlah saldo yang telah anda ijinkan';
  late AccountModel account;
  late SubAccountDetail extendedInfo;

  var iklanImages = <Images>[].obs;
  var lastTransaction = <Mutasi>[].obs;
  var serviceApps = <Menu>[].obs;
  var dataSiswa = <DataSiswa>[].obs;
  var balance = 'NA'.obs;
  var balanceHide = ''.obs;
  var limit = 'NA'.obs;
  var idVerifyStatus = ''.obs;
  var notificationData = <NotificationData>[].obs;
  var photoUrl = ''.obs;
  var isFcmAvailable = false;
  var isNotifHaveUnread = false.obs;
  var sisaSaldo = 0.obs;
  var totalTagihan = 0.obs;
  var limitHarian = '0'.obs;
  var showBalance = true.obs;
  @override
  void onInit() async {
    super.onInit();
    _pref = await setSharedPreference();
    Get.put(ServiceCont());
    refreshService();
  }

  void refreshService() {
    _checkFcm();
    getHomeData();
    getAccountInfo();
    getBalance();
    getMutasi();
    getUnreadMessage();
  }

  Future<void> getHomeData() async {
    dtUser = jsonDecode(_pref.getString(kDtUser) ?? '');
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/home/getDataHome', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    if (decodedBody['versi'] == 'false') {
      await _pref.setString(kIsUpdate, 'true');
      if (decodedBody['pushVersi'] == 'true') {
        await _pref.setString(kIsPushVersion, 'true');
      } else {
        await _pref.setString(kIsPushVersion, 'false');
      }
      await _bottomSheetNewVersion();
    } else {
      await _pref.setString(kIsUpdate, 'false');
    }
    switch (decodedBody['RC']) {
      case ('01'): //device changed
        await _pref.setBool(kIsLoggedIn, false);
        await Get.offAllNamed(Login.route.name);
        break;
      case ('02'): //session expired
        await _pref.setBool(kIsLoggedIn, false);
        await Get.offAllNamed(Login.route.name, arguments: true);
        break;
      default:
        final homeModel = HomeModel.fromJson(decodedBody);
        iklanImages.assignAll(homeModel.iklan.images);
        serviceApps.assignAll(homeModel.menu);
        dataSiswa.assignAll(homeModel.dataSiswa);
      // var datasiswaJson =
      //     '[{\"pesan\":\"Data Siswa Ditemukan\",\"biaya\":0,\"phone\":\"085882816377\",\"total_tagihan\":\"150000\",\"kelas\":\"2 2022-2023\",\"name\":\"ALYA ASRI JUNAIDAH\",\"nama_sekolah\":\"LPI QURROTA A\'YUN TULUNGAGUNG\",\"ACK\":\"OK\",\"nis\":\"QA256\",\"caraBayar\":\"full\",\"phone_sekolah\":\"085646444500\",\"path_logo\":\"https://mybusiness.eidupay.com/img/merchantagent/logo/drs_imam_muslimin_Logo__1620013416.jpeg\"},{\"pesan\":\"Data Siswa Ditemukan\",\"biaya\":0,\"phone\":\"085882816666\",\"total_tagihan\":\"300000\",\"kelas\":\"3 2022-2023\",\"name\":\"RYAN MANDHIRA\",\"nama_sekolah\":\"SMA KARTIKA CHANDRA KURNIA\",\"ACK\":\"OK\",\"nis\":\"QA66\",\"caraBayar\":\"full\",\"phone_sekolah\":\"085646444500\",\"path_logo\":\"https://mybusiness.eidupay.com/img/merchantagent/logo/drs_imam_muslimin_Logo__1620013416.jpeg\"},{\"pesan\":\"Data Siswa Ditemukan\",\"biaya\":0,\"phone\":\"085882816666\",\"total_tagihan\":\"0\",\"kelas\":\"3 2022-2023\",\"name\":\"JULKARNAEN ISKANDAR\",\"nama_sekolah\":\"SMA KARTIKA CHANDRA KURNIA\",\"ACK\":\"OK\",\"nis\":\"QA66\",\"caraBayar\":\"full\",\"phone_sekolah\":\"085646444500\",\"path_logo\":\"https://mybusiness.eidupay.com/img/merchantagent/logo/drs_imam_muslimin_Logo__1620013416.jpeg\"}]';
      // Iterable l = json.decode(datasiswaJson);

      // List<DataSiswa> datasiswa =
      //     List<DataSiswa>.from(l.map((model) => DataSiswa.fromJson(model)));
      // datasiswa.forEach((element) {
      //   totalTagihan.value += element.totalTagihan!.isEmpty
      //       ? int.parse(element.totalTagihan!)
      //       : 0;
      // });
      // dataSiswa.assignAll(datasiswa);
    }
  }

  Future<void> getBalance() async {
    final balanceModel = await _network.getBalance();
    final infoExtended = balanceModel.infoExtended;
    balance.value = balanceModel.infoMember.lastBalance;
    if (infoExtended != null) {
      extendedInfo = await _network.getExt();

      if (int.parse(balance.value.numericOnly()) <
          int.parse(infoExtended.extLimit.numericOnly())) {
        limit.value = balance.value;

        await updateTransaction(
            extendedInfo.idExt,
            limit.value,
            extendedInfo.limitDaily,
            extendedInfo.lockFund,
            extendedInfo.deactive);
        return;
      }
      final limitInt = (int.parse(infoExtended.extLimit.numericOnly()) -
          int.parse(infoExtended.extUsed.numericOnly()));
      limit.value = limitInt.amountFormat;
      if (extendedInfo.limitDaily != '0') {
        limitHarian.value = (int.parse(extendedInfo.limitDaily.numericOnly()) -
                int.parse(infoExtended.extDailyUsed.numericOnly()))
            .toString();
      }
    }
  }

  Future<dynamic> updateTransaction(String id, String limit, String dailyLimit,
      bool lockFund, bool deactive) async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'limit': limit.replaceAll('.', ''),
      'dailyLimit': dailyLimit,
      'lockFund': lockFund.toString(),
      'deactive': deactive.toString(),
      'idExt': id,
      'tipe': dtUser['tipe'],
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/extended/updateTransaction', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> getAccountInfo() async {
    final _package = await PackageInfo.fromPlatform();
    final baseUrl = injector.get<AppConfig>().baseUrl;
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'phoneExtended': _pref.getString(kUserType) == 'extended'
          ? _pref.getString(kHp)
          : null,
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

    switch (decodedBody['RC']) {
      case ('01'): //device changed
        await _pref.setBool(kIsLoggedIn, false);
        await Get.offAllNamed(Login.route.name);
        break;
      case ('02'): //session expired
        await _pref.setBool(kIsLoggedIn, false);
        await Get.offAllNamed(Login.route.name, arguments: true);
        break;
      default:
        final accountModel = AccountModel.fromJson(decodedBody);
        accountData = accountModel.data.first.toJson();
        if (accountModel.data.first.fotoProfile.isNotEmpty) {
          photoUrl.value = '$baseUrl:$port/eidupay/home/getPicProfile/' +
              accountModel.data.first.fotoProfile;
        }
        account = accountModel;
        idVerifyStatus.value = accountModel.data.first.idStatusVerifikasi;
        await _pref.setString(kIdVerifyStatus, idVerifyStatus.value);
    }
  }

  Future<void> getMutasi() async {
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'offset': '0',
      'limit': 3,
      'tgl': '',
      'lang': '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/home/getMutasi', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final mutasiModel = MutasiModel.fromJson(decodedBody);
    lastTransaction.assignAll(mutasiModel.dataMutasi);
  }

  Future<void> getUnreadMessage() async {
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'idAccount': _pref.getString(kUserId) ?? '',
      'packageName': _package.packageName,
      'tipe': _pref.getString(kUserType) ?? '',
      'lang': '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        port: 9009, url: 'api/getUnreadMessage', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    final unreadCount = decodedBody['data']['unread'] as int;
    if (unreadCount != 0) isNotifHaveUnread.value = true;
  }

  void topup() {
    Get.to(() => const Topup());
  }

  void transfer() {
    Get.toNamed(TransferPage.route.name)?.then((value) => refreshService());
  }

  void withdrawal() {
    EiduInfoDialog.showInfoDialog(title: 'Akan segera hadir');
    // Get.toNamed(TransferWithdrawalPage.route.name)?.then((value) => refresh());
  }

  void notification() {
    isNotifHaveUnread.value = false;
    Get.toNamed(NotificationPage.route.name, arguments: notificationData)
        ?.then((value) => refreshService());
  }

  void marketplace() {
    EiduInfoDialog.showInfoDialog(title: 'Akan segera hadir');
  }

  void invest() {
    EiduInfoDialog.showInfoDialog(title: 'Akan segera hadir');
    // Get.toNamed(InvestPage.route.name);
  }

  void services() {
    // serviceApps.removeWhere((element) => element.title == 'Belanja');

    Get.toNamed(ServicesPage.route.name, arguments: serviceApps)
        ?.then((value) => refreshService());
  }

  void chat() {
    EiduInfoDialog.showInfoDialog(title: 'Akan segera hadir');
  }

  void profileTap() {
    Get.toNamed(ProfilePage.route.name, arguments: [account, showBalance.value])
        ?.then((value) => refreshService());
  }

  void fullTrxTap() {
    Get.put(TransactionController(injector.get()));
    Get.toNamed(TransactionPage.route.name);
  }

  Future<void> initPrompt(VoidCallback? newFeaturePressed) async {
    final _pref = await SharedPreferences.getInstance();
    final type = dtUser['tipe'];
    if (_pref.getBool(kIsAlreadyPrompted) == false ||
        _pref.getBool(kIsAlreadyPrompted) == null) {
      final isBiometricUse = await _biometricPrompt();
      if (isBiometricUse != null && isBiometricUse) {
        await EiduInfoDialog.showInfoDialog(
            icon: 'assets/lottie/success.json', title: 'Berhasil!');
      }
      if (type == 'member') await _bottomSheetNewFeature(newFeaturePressed);
    } else {
      if (type == 'member') await _bottomSheetNewFeature(newFeaturePressed);
    }
  }

  Future<String> checkActiveBiometric() async {
    final _authBiometric = LocalAuthentication();
    final availableBiometrics = await _authBiometric.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      return 'assets/images/face_id.png';
    } else {
      return 'assets/images/touch_id.png';
    }
  }

  Future<bool?> _biometricPrompt() async {
    final biometricIcon = await checkActiveBiometric();
    final _c = Get.put(AuthController());
    final _pref = await SharedPreferences.getInstance();
    return await EiduConfirmationBottomSheet.showBottomSheet<bool>(
      title: 'Biometric Login',
      description:
          'Apakah ingin menambahkan fitur login dengan biometric scan?',
      iconUrl: biometricIcon,
      firstButtonText: 'Lain kali',
      secondButtonText: 'Ya',
      secondaryColor: green,
      firstButtonOnPressed: () async {
        await _pref.setBool(kIsAlreadyPrompted, true);
        await _pref.setBool(kFingerprint, false);
        await _pref.setBool(kFaceId, false);

        Get.back(result: false);
      },
      secondButtonOnPressed: () async {
        final authed = await _c.authenticateBiometric();
        if (authed) {
          await _pref.setBool(kIsAlreadyPrompted, true);
          await _pref.setBool(kIsUseBiometric, true);
          Get.back(result: true);
        } else {
          await _pref.setString(kPin, '');
          await _pref.setString(kHp, '');
          await _pref.setBool(kIsUseBiometric, false);
        }
      },
    );
  }

  Future<void> _bottomSheetNewFeature([VoidCallback? onPressed]) async {
    final _pref = await SharedPreferences.getInstance();
    if (_pref.getBool(kIsShowCasePrompted) != true) {
      await EiduBottomSheet.showBottomSheet(
        imageUrl: 'assets/images/animasi-cowok.png',
        title: 'Yang ditunggu tampil baru!',
        description:
            'Mau tau apa saja yang beda dari eidupay?\nYuk, cek langsung!',
        buttonText: 'Mau tau dong!',
        onPressed: onPressed,
      );
      await _pref.setBool(kIsShowCasePrompted, true);
    }
  }

  Future<void> _bottomSheetNewVersion([VoidCallback? onPressed]) async {
    final _pref = await SharedPreferences.getInstance();
    if (_pref.getString(kIsUpdate) == 'true') {
      if (_pref.getString(kIsPushVersion) != 'true') {
        await EiduBottomSheet.showBottomSheet(
          imageUrl: 'assets/images/extended-5.png',
          title: 'Versi baru!',
          description:
              'Eidupay versi terbaru udah tersedia nih?\nYuk, cek langsung!',
          buttonText: 'Update',
          onPressed: () async => {
            await LaunchReview.launch(
                androidAppId: 'id.co.eidu.mobile',
                iOSAppId: 'id.co.eidu.mobile')
          },
        );
      } else {
        await EiduInfoDialog.showInfoDialog(
            title:
                'EiduPay versi terbaru telah tersedia, silahkan lakukan update',
            icon: 'assets/lottie/warning.json');

        await LaunchReview.launch(
            androidAppId: 'id.co.eidu.mobile', iOSAppId: 'id.co.eidu.mobile');
      }
    }
  }

  Future<void> toSubAccount() async {
    final isOnBoardTapped = _pref.getBool(kSubAccountOnBoardTapped);
    if (isOnBoardTapped == null || !isOnBoardTapped) {
      await Get.toNamed(SubAccountOnBoardPage.route.name);
    } else {
      await Get.toNamed(SubAccountListPage.route.name);
    }
  }

  Future<dynamic> _getInqEdukasi(DataSiswa data) async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final type = dtUser['tipe'].toString();
    final _package = await PackageInfo.fromPlatform();
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, String>{
      'merchantPhone': data.phoneSekolah!,
      'payerNumber': dtUser['idAccount'],
      'customerNumber': data.nis!,
      'idAccount': dtUser['idAccount'],
      'tipe': type,
      if (type == 'extended') 'phoneExtended': dtUser['hp'],
      'lang': '',
      'packageName': _packageInfo.packageName,
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode,
    };

    final response = await _network.post(
        url: 'eidupay/pendidikan/getInquiryEdukasi',
        header: header,
        body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> toInquiryEdukasi(DataSiswa data) async {
    var res = await _getInqEdukasi(data);
    if (res['ACK'] == 'NOK') {
      String pesan = res['pesan'];
      if (res['pesan'] == 'Data tidak ditemukan') {
        pesan = 'Tagihan tidak ditemukan';
      }
      await EiduInfoDialog.showInfoDialog(title: pesan);
    }
    if (res['ACK'] == 'OK') {
      final educationInquiryData = EducationInquiry.fromJson(res);
      await Get.toNamed(
          '/services/education/direct/${educationInquiryData.inquiryListCategory.merchantPhone}/confirm/',
          arguments: educationInquiryData);
    }
  }

  Future<void> onFinish() async {
    await _pref.setBool(kIsShowCasePrompted, true);
  }

  Future<void> historyCardTapped(Mutasi data) async {
    final trxCont = Get.put(TransactionController(injector.get()));
    EiduLoadingDialog.showLoadingDialog();
    final response = await trxCont.getNotificationTrxDetail(data.idStock);
    Get.back();
    await Get.toNamed(
      '/transaction/detail/${data.idStock}',
      arguments: {'notifDetail': response.first, 'mutasi': data},
    )?.then((value) => refreshService());
  }

  Future<void> _checkFcm() async {
    final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    if (token != null) await _setFcmToken(token);
  }

  Future<void> _checkVersion() async {}

  Future<void> _setFcmToken(String token) async {
    final header = {'Cookie': _pref.getString(kCookie) ?? ''};
    final body = <String, dynamic>{
      'token': token,
      'idAccount': _pref.getString(kUserId) ?? '',
      'lang': '',
      'tipe': _pref.getString(kUserType) ?? '',
      'deviceInfo': _pref.getString(kUid) ?? '',
      'versionCode': versionCode
    };
    final response = await _network.post(
        url: 'eidupay/login/setFcmToken', header: header, body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    debugPrint('Set FCM Token: $decodedBody');
    debugPrint('Token: $token');
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
