import 'dart:convert';

import 'package:eidupay/controller/opening/opening_cont.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/view/login.dart';
import 'package:eidupay/view/sub_account/sub_home_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:device_info/device_info.dart';

final List<String> imgList = [
  'assets/images/01.png',
  'assets/images/02.png',
  'assets/images/03.png',
  'assets/images/04.png',
  'assets/images/05.png',
];

final List<String> judul = [
  'Easy to pay',
  'Easily track your transaction',
  'Send Money',
  'Extended user',
  'Pay Securely',
];

final List<String> desc = [
  'Bisa bayar di mana saja yang bertanda QRIS',
  'Bisa lihat mutasi selama 12 bulan',
  'Kirim uang ke keluarga, teman, relasi sesama pengguna eidupay, ke seluruh Bank di Indonesia mudah',
  'Tanpa perlu daftar eidupay, anda bisa menambahkan keluarga & teman untuk mengakses alokasi dana yang anda berikan',
  'Berizin dan Disupervisi oleh Bank Indonesia',
];

class OpenInit extends StatefulWidget {
  const OpenInit({Key? key}) : super(key: key);
  static final route = GetPage(name: '/open_init', page: () => OpenInit());

  @override
  _OpenInitState createState() => _OpenInitState();
}

class _OpenInitState extends State<OpenInit> {
  bool onboarding = true;
  late bool loggedIn;
  late Map<String, dynamic>? dtUser;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getDeviceInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Platform.isAndroid) {
      final device = await DeviceInfoPlugin().androidInfo;
      final uid = device.androidId;
      await prefs.setString(kUid, uid);
    }
    if (Platform.isIOS) {
      final device = await DeviceInfoPlugin().iosInfo;
      final uid = device.identifierForVendor;
      await prefs.setString(kUid, uid);
    }
  }

  Future<bool> getOnboard() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    onboarding = _pref.getBool(kOnBoarding) ?? true;
    await getDeviceInfo();
    loggedIn = _pref.getBool(kIsLoggedIn) ?? false;
    final stringDtUser = _pref.getString(kDtUser);
    dtUser = stringDtUser != null ? jsonDecode(stringDtUser) : null;
    return onboarding;
  }

  Future<String> getDtUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kDtUser) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Widget _tampil(bool val, bool isLoggedIn) {
      if (val) {
        return const OpeningView();
      } else {
        if (isLoggedIn) {
          if (dtUser != null) {
            if (dtUser!['tipe'] == 'extended') {
              return const SubHomePage();
            } else {
              return Home();
            }
          }
        }
        return const Login();
      }
    }

    return FutureBuilder(
        future: getOnboard(),
        builder: (context, AsyncSnapshot<bool> snap) {
          return snap.hasData ? _tampil(snap.data!, loggedIn) : Container();
        });
  }
}

class OpeningView extends StatefulWidget {
  static final route =
      GetPage(name: '/opening', page: () => const OpeningView());

  const OpeningView({Key? key}) : super(key: key);

  @override
  _OpeningViewState createState() => _OpeningViewState();
}

class _OpeningViewState extends State<OpeningView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _c = Get.put(OpeningCont());

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map(
          (item) => Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.asset(item),
              ),
              SizedBox(height: h(68)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  judul[imgList.indexOf(item)],
                  style: TextStyle(
                      fontSize: w(30),
                      color: t100,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: h(16)),
              Padding(
                padding: const EdgeInsets.only(left: 33, right: 33),
                child: Text(
                  desc[imgList.indexOf(item)],
                  style: TextStyle(
                    fontSize: w(16),
                    color: t60,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
        .toList();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: h(57)),
          Row(
            children: [
              const SizedBox(width: 28),
              SizedBox(
                width: w(123),
                height: w(42),
                child: Image.asset('assets/images/logo_eidupay.png'),
              ),
              const Spacer(),
              SizedBox(
                height: w(44),
                child: ElevatedButton(
                  onPressed: () => _c.continueTap(),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFFFE9F8F6)),
                      elevation: MaterialStateProperty.all(0.0)),
                  child: Text('Skip',
                      style: TextStyle(
                          fontSize: w(16),
                          color: green,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(width: 28),
            ],
          ),
          SizedBox(height: h(65)),
          Expanded(
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imageSliders,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43.0),
            child: SubmitButton(
              backgroundColor: green,
              text: 'Lanjutkan',
              onPressed: () {
                if (_current == imgList.length - 1) {
                  _c.continueTap();
                } else {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear);
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : green)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
