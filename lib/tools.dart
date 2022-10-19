import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eidupay/app_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:eidupay/main.dart';

final port = injector.get<AppConfig>().port;
const versionCode = '2.0.3';
const buildNumber = '48';
const appVersion = versionCode + '+' + buildNumber;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const kDay = 'day';
const kCookie = 'cookie';
const kUserId = 'userId';
const kUserType = 'userType';
const kUid = 'uid';
const kHp = 'hp';
const kIdVerifyStatus = 'idVerifyStatus';
const kFingerprint = 'fingerprint';
const kFaceId = 'faceId';
const kPin = 'pin';
const kDtUser = 'dtUser';
const kSubAccountOnBoardTapped = 'subAccountOnBoardTapped';
const kLastLogin = 'lastLogin';
const kBiometricPin = 'biometricPin';
const kOnBoarding = 'onboarding';
const kIsLoggedIn = 'isLoggedIn';
const kIsAlreadyPrompted = 'isAlreadyPrompted';
const kIsUseBiometric = 'isUseBiometric';
const kIsShowCasePrompted = 'isShowCasePrompted';
const kIsUpdate = 'isUpdate';
const kIsPushVersion = 'kIsPushVersion';

String uId = '';
Map<String, dynamic> dtUser = {};
var accountData = <String, dynamic>{};

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

const green = Color(0xFF45CCC0);
const disabledGreen = Color(0xFFC8F0EC);
const newGreen = Color(0xFF45CCC0);
const purple = Color(0xFF343574);
const blue = Color(0xFF004B84);
const darkBlue = Color(0xFF004B84);
const n800 = Color(0xFF172B4D);
const disabledBlue = Color(0xFFE9F5FF);
const orange1 = Color(0xFFFE980B);
const orange2 = Color(0xFFFEA324);
const lightBlue = Color(0xFF41C2F8);
const grad1 = Color(0xFF1E96FC);
const grad2 = Color(0xFF1DE4B5);
const green2 = Color(0xFFE9F8F6);
const red = Color(0xFFFF4133);

//Chromatic
const t100 = Color(0xFF171725);
const t90 = Color(0xFF44444F);
const t80 = Color(0xFF696974);
const t70 = Color(0xFF92929D);
const t60 = Color(0xFFB5B5BE);
const t50 = Color(0xFFD5D5DC);
const t40 = Color(0xFFE2E2EA);
const t30 = Color(0xFFF1F1F5);
const t20 = Color(0xFFFAFAFB);
const t10 = Color(0xFFFFFFFF);

final emailValidation = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

LinearGradient gradientColor = const LinearGradient(
    colors: [grad1, grad2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

double w(int lebar) =>
    (lebar / 375 * 100) *
    MediaQuery.of(navigatorKey.currentContext!).size.width /
    100;

double h(int tinggi) =>
    (tinggi / 1090 * 100) *
    MediaQuery.of(navigatorKey.currentContext!).size.height /
    100;

InputDecoration defInput(String title, BuildContext context) {
  return InputDecoration(
    hintText: title,
    hintStyle:
        GoogleFonts.rubik(textStyle: TextStyle(fontSize: w(14), color: t60)),
    fillColor: Colors.grey[200],
    filled: true,
    disabledBorder: InputBorder.none,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
  );
}

final currencyMaskFormatter =
    TextInputMask(mask: '999,999,999', reverse: true, maxLength: 11);
final dateMaskFormatter = TextInputMask(mask: '99-99-9999');
final cardNumFormatter = TextInputMask(mask: '9999 9999 9999 9999');

const mainInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Color(0xFFD5D5DC)),
  hintStyle: TextStyle(color: Color(0xFFD5D5DC), fontSize: 14),
  filled: true,
  fillColor: Color(0xFFF6F7F8),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: red),
  ),
);

const underlineInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Color(0xFFD5D5DC), fontSize: 14),
  enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEAEBED))),
  disabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFEAEBED))),
);

String? passwordValidator(String? value) {
  if (value == null) {
    return 'Password required';
  }
  if (value.isEmpty) {
    return 'Password required';
  }
  if (value.isNotEmpty) {
    if (value.length < 6) {
      return 'Password length should be at least 6 characters';
    }
  }
}

String? pinValidator(String? value) {
  if (value == null) {
    return 'PIN harus diisi';
  }
  if (value.isEmpty) {
    return 'PIN harus diisi';
  }
  if (value.isNotEmpty) {
    if (value.length != 6) {
      return 'PIN harus 6 digit';
    }
  }
}

Future<String> getUid() async {
  final _pref = await SharedPreferences.getInstance();
  String _uid = _pref.getString(kUid) ?? '';
  return _uid;
}

String getBulan(String bulan) {
  switch (bulan) {
    case '01':
      return 'JAN';
    case '02':
      return 'FEB';
    case '03':
      return 'MAR';
    case '04':
      return 'APR';
    case '05':
      return 'MEI';
    case '06':
      return 'JUN';
    case '07':
      return 'JUL';
    case '08':
      return 'AGUS';
    case '09':
      return 'SEP';
    case '10':
      return 'OKT';
    case '11':
      return 'NOV';
    case '12':
      return 'DES';
    default:
      return '';
  }
}

Future<File> compressFile(File file) async {
  final filePath = file.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r".jp"));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
  final result = await FlutterImageCompress.compressAndGetFile(
    filePath,
    outPath,
    quality: 50,
  );
  debugPrint(file.lengthSync().toString());
  debugPrint(result?.lengthSync().toString());

  return result ?? file;
}

Future<SharedPreferences> setSharedPreference() async =>
    await SharedPreferences.getInstance();

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
