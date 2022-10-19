import 'package:eidupay/controller/sub_account/profile/sub_profile_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubProfilePage extends StatelessWidget {
  static final route = GetPage(
      name: '/sub-account/profile/', page: () => const SubProfilePage());

  const SubProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Eidu')),
      body: const _BodySubProfilePage(),
    );
  }
}

class _BodySubProfilePage extends StatefulWidget {
  const _BodySubProfilePage({Key? key}) : super(key: key);

  @override
  _BodySubProfilePageState createState() => _BodySubProfilePageState();
}

class _BodySubProfilePageState extends State<_BodySubProfilePage> {
  final _c = Get.put(SubProfileCont(injector.get()));

  @override
  void initState() {
    super.initState();
    _c.getSubBalance();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      initialData: false,
      future: _c.getSubAccount(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null && data) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.075),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            _c.subAccount.nama,
                                            style: TextStyle(
                                                fontSize: w(16),
                                                fontWeight: FontWeight.w400,
                                                color: darkBlue),
                                          ),
                                          SizedBox(height: h(7)),
                                          Text(
                                            _c.subAccount.hp,
                                            style: TextStyle(
                                                fontSize: w(16),
                                                fontWeight: FontWeight.w400,
                                                color: t70),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: w(36)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: double.infinity,
                                  height: w(64),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: green.withOpacity(0.1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Saldo ',
                                        style: TextStyle(
                                            fontSize: w(16),
                                            fontWeight: FontWeight.w400,
                                            color: darkBlue),
                                      ),
                                      Obx(
                                        () => Text(
                                          'Rp ' + _c.limit.value,
                                          style: TextStyle(
                                              fontSize: w(16),
                                              fontWeight: FontWeight.w500,
                                              color: green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: w(45),
                            foregroundImage: const AssetImage(
                                'assets/images/default_profile.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: w(77),
                        height: w(24),
                        child: Image.asset('assets/images/logo_eidupay.png'),
                      ),
                      const Text(
                        ' | ',
                        style: TextStyle(color: t70),
                      ),
                      Text(
                        'App Version $appVersion',
                        style: TextStyle(
                            fontSize: w(12),
                            fontWeight: FontWeight.w500,
                            color: t70),
                      ),
                    ],
                  ),
                  SizedBox(height: h(70)),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
