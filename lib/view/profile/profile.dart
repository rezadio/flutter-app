import 'package:eidupay/controller/profile/profile_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/komunitas.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/model/account.dart';
import 'package:eidupay/widget/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eidupay/tools.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/profile', page: () => const ProfilePage());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(ProfileCont(injector.get()));
    return Scaffold(
        appBar: AppBar(title: const Text('My Eidu')),
        body: Obx(() {
          return _c.inProccess.value
              ? Shimmer.fromColors(
                  child: const _ShimmerBody(),
                  baseColor: (Colors.grey[300])!,
                  highlightColor: (Colors.grey[100])!)
              : const _Body();
        }));
  }
}

class _ShimmerBody extends StatelessWidget {
  const _ShimmerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: w(50)),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: w(193),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: w(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: w(152),
                height: w(96),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
              Container(
                width: w(152),
                height: w(96),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: h(20)),
          Container(
            width: double.infinity,
            height: w(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
          SizedBox(height: h(20)),
          Container(
            width: double.infinity,
            height: w(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
          SizedBox(height: h(20)),
          Container(
            width: double.infinity,
            height: w(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _c = Get.find<ProfileCont>();
  final AccountModel account = Get.arguments[0];
  final bool showBalance = Get.arguments[1];
  late DataKomunitas? communityData;

  @override
  void initState() {
    super.initState();
    _c.getProfilePicture(account.data.first.fotoProfile);

    final _dataKomunitas = account.dataKomunitas;
    if (_dataKomunitas != null && _dataKomunitas.isNotEmpty) {
      communityData = _dataKomunitas.first;
    } else {
      communityData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountData = account.data.first;
    final dataKomunitas = communityData;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.075),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              colorFilter:
                                  ColorFilter.mode(green, BlendMode.hardLight),
                              image: AssetImage(
                                'assets/images/card_bg.png',
                              ),
                              fit: BoxFit.fill),
                          color: green),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // crossAxisAlignment:
                                  //     accountData.idStatusVerifikasi != '1'
                                  //         ? CrossAxisAlignment.start
                                  //         : CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: h(7)),
                                    Text(
                                      _c.nama,
                                      style: TextStyle(
                                          fontSize: w(16),
                                          fontWeight: FontWeight.w600,
                                          color: blue),
                                    ),
                                    SizedBox(height: h(7)),
                                    Text(
                                      _c.noHp,
                                      style: TextStyle(
                                          fontSize: w(16),
                                          fontWeight: FontWeight.w600,
                                          color: t10),
                                    ),
                                    if (dataKomunitas != null)
                                      SizedBox(height: h(7)),
                                    if (dataKomunitas != null)
                                      Text(
                                        dataKomunitas.communityName,
                                        style: TextStyle(
                                            fontSize: w(16),
                                            fontWeight: FontWeight.w400,
                                            color: disabledGreen),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: w(10)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: green.withOpacity(0.1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Saldo ',
                                  style: TextStyle(
                                      fontSize: w(16),
                                      fontWeight: FontWeight.w600,
                                      color: darkBlue),
                                ),
                                SizedBox(height: w(5)),
                                showBalance
                                    ? Text(
                                        'Rp ' +
                                            _c.balance!.infoMember.lastBalance,
                                        style: TextStyle(
                                            fontSize: w(16),
                                            fontWeight: FontWeight.w600,
                                            color: t10),
                                      )
                                    : Text(
                                        'Rp ' +
                                            StringUtils.stringToSecureFullText(
                                                _c.balance!.infoMember
                                                    .lastBalance),
                                        style: TextStyle(
                                            fontSize: w(16),
                                            fontWeight: FontWeight.w600,
                                            color: t10),
                                      )
                              ],
                            ),
                          ),
                          if (accountData.idStatusVerifikasi != '1')
                            const SizedBox(height: 10),
                          _checkVerifiStatus(
                              context, accountData.idStatusVerifikasi),
                          if (dtUser['tipe'] == 'member')
                            const SizedBox(height: 10),
                          if (dtUser['tipe'] == 'member' &&
                              accountData.idStatusVerifikasi == '1')
                            SubmitButton(
                              backgroundColor: blue,
                              iconColor: t10,
                              text: 'Sub Account',
                              onPressed: () => _c.subAccountTap(),
                              iconUrl: ('assets/images/ico_support.png'),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                    child: Obx(
                      () => GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: w(45),
                          foregroundImage: _c.photoWidget.first,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      body: GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration:
                                              BoxDecoration(color: t100),
                                          child: Hero(
                                              tag: 'imageHero',
                                              child: Image(
                                                image: _c.photoWidget.first,
                                              )
                                              // Image.network(
                                              //   _c.photoWidget.first,
                                              //   fit: BoxFit.fill,
                                              // ),
                                              ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  }));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h(16)),
            if (accountData.idStatusVerifikasi == '2')
              Container(
                width: double.infinity,
                height: w(89),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: orange1.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 11, right: 11),
                  child: Row(
                    children: [
                      SizedBox(
                          width: w(28),
                          height: w(28),
                          child: Image.asset(
                              'assets/images/ico_warning_big1.png')),
                      SizedBox(width: h(12)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KYC belum di verifikasi',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w500,
                                  color: t100),
                            ),
                            SizedBox(height: h(7)),
                            Text(
                              'Untuk mengakses fitur lengkap, KYC haru di verifikasi.',
                              style: TextStyle(
                                  fontSize: w(10),
                                  fontWeight: FontWeight.w400,
                                  color: t100),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: h(12)),
                      GestureDetector(
                        onTap: () => _c.verifyTap(context),
                        child: Container(
                          width: w(65),
                          height: w(34),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: orange1,
                          ),
                          child: Center(
                              child: Text(
                            'Verifikasi',
                            style: TextStyle(
                                fontSize: w(13),
                                fontWeight: FontWeight.w500,
                                color: t10),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (accountData.idStatusVerifikasi == '2') SizedBox(height: h(16)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                onTap: () => _c.editTap(accountData),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: w(152),
                  height: w(96),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: lightBlue.withOpacity(0.2),
                    border: Border.all(color: lightBlue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: w(46),
                        height: w(43),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightBlue.withOpacity(0.4),
                        ),
                        child: Image.asset('assets/images/ico_profile1.png'),
                      ),
                      SizedBox(height: w(12)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lihat Profile',
                            style: TextStyle(
                                fontSize: w(14),
                                fontWeight: FontWeight.w400,
                                color: t100),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 20)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _c.resetPin(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: w(152),
                  height: w(96),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: green.withOpacity(0.1),
                    border: Border.all(color: green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: w(46),
                        height: w(43),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: green.withOpacity(0.3),
                        ),
                        child: Image.asset('assets/images/ico_reset_pin.png'),
                      ),
                      SizedBox(height: w(12)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reset Pin',
                            style: TextStyle(
                                fontSize: w(14),
                                fontWeight: FontWeight.w400,
                                color: t100),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 20)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(height: h(34)),
            ListMenu(
              img: 'assets/images/touch_id.png',
              title: 'Biometric',
              onPress: () => _c.biometricTap(),
            ),
            SizedBox(height: h(27)),
            ListMenu(
              img: 'assets/images/ico_terms.png',
              title: 'Syarat & Ketentuan',
              onPress: () => _c.termTap(),
            ),
            SizedBox(height: h(27)),
            ListMenu(
              img: 'assets/images/ico_about.png',
              title: 'Kebijakan Privasi',
              onPress: () => _c.aboutTap(),
            ),
            SizedBox(height: h(27)),
            ListMenu(
              img: 'assets/images/ico_faq.png',
              title: 'FAQs',
              onPress: () => _c.faqTap(),
            ),
            SizedBox(height: h(27)),
            ListMenu(
              img: 'assets/images/ico_support.png',
              title: 'Support',
              onPress: () => _c.support(),
            ),
            SizedBox(height: h(27)),
            ListMenu(
              img: 'assets/images/ico_logout.png',
              title: 'Keluar',
              onPress: () => _c.logoutTap(context),
            ),
            SizedBox(height: h(70)),
            const VersionWidget(),
            SizedBox(height: h(70)),
          ],
        ),
      ),
    );
  }

  Widget _checkVerifiStatus(BuildContext context, String idVerifyStatus) {
    switch (idVerifyStatus) {
      case ('2'):
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.loop, color: disabledBlue, size: 15),
            Text(
              ' Proses verifikasi',
              style: TextStyle(
                  fontSize: w(12),
                  fontWeight: FontWeight.w600,
                  color: disabledBlue),
            )
          ],
        );
      case ('3'):
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.loop, color: disabledBlue, size: 15),
            Text(' Belum terverifikasi',
                style: TextStyle(
                  fontSize: w(12),
                  fontWeight: FontWeight.w600,
                  color: disabledBlue,
                )),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class ListMenu extends StatelessWidget {
  const ListMenu(
      {Key? key, this.img = '', this.title = '', required this.onPress})
      : super(key: key);
  final String img;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            width: w(20),
            height: w(20),
            child: Image.asset(img, color: t80),
          ),
          SizedBox(width: h(13)),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w400, color: t100),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: t80,
          )
        ],
      ),
    );
  }
}
