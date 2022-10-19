import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eidupay/controller/home_cont.dart';
import 'package:eidupay/controller/services/services_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/home.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/kyc/instruction_page.dart';
import 'package:eidupay/view/qris/qris_scan_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/history_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';

GlobalKey _one = GlobalKey();
GlobalKey _two = GlobalKey();
GlobalKey _three = GlobalKey();
GlobalKey _four = GlobalKey();
GlobalKey _five = GlobalKey();
GlobalKey _six = GlobalKey();
GlobalKey _seven = GlobalKey();
GlobalKey _eight = GlobalKey();
GlobalKey _nine = GlobalKey();

class Home extends StatelessWidget {
  static final route = GetPage(name: '/home', page: () => Home());
  final _c = Get.put(HomeCont(injector.get()));
  final scrollController = ScrollController();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        builder: Builder(
            builder: (context) => HomePage(scrollController: scrollController)),
        onFinish: _c.onFinish,
        onComplete: (index, key) {
          debugPrint('$index, $key');
          if (index == 6) {
            final _findRenderObject = _eight.currentContext?.findRenderObject();
            if (_findRenderObject != null) {
              scrollController.position.ensureVisible(_findRenderObject);
            }
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final ScrollController scrollController;
  const HomePage({Key? key, required this.scrollController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _c = Get.find<HomeCont>();

  static const _titleTextStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const _descTextStyle = TextStyle(fontSize: 12);

  @override
  void initState() {
    super.initState();
    _c.initPrompt(_showCasePressed);
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = widget.scrollController;

    ImageProvider _getProfile() {
      if (_c.photoUrl.value.isNotEmpty) {
        return CachedNetworkImageProvider(_c.photoUrl.value);
      } else {
        return const AssetImage('assets/images/default_profile.png');
      }
    }

    return Obx(() {
      return SafeArea(
        child: SmartRefresher(
          controller: _c.refreshController,
          enablePullDown: true,
          onRefresh: () {
            _c.refreshService();
            _c.refreshController.refreshCompleted();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: w(135),
                          height: w(42),
                          child: Image.asset('assets/images/logo_eidupay.png'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Showcase(
                            key: _one,
                            shapeBorder: const CircleBorder(),
                            overlayPadding: const EdgeInsets.all(8),
                            titleTextStyle: _titleTextStyle,
                            descTextStyle: _descTextStyle,
                            title: 'Informasi Akun Eidupay',
                            description:
                                'Lihat berbagai informasi tentang akun eidupay kamu.',
                            child: GestureDetector(
                              onTap: () => _c.profileTap(),
                              child: CachedNetworkImage(
                                imageUrl: _c.photoUrl.value,
                                errorWidget: (context, url, error) {
                                  return Container(
                                    width: w(41),
                                    height: w(41),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/default_profile.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                                imageBuilder: (context, _) => Container(
                                  width: w(41),
                                  height: w(41),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: _getProfile(),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Showcase(
                            key: _five,
                            title: 'Pemberitahuan',
                            description:
                                'Kini notifikasi, transaksi, atau promo bisa diakses lebih cepat dan mudah.',
                            titleTextStyle: _titleTextStyle,
                            descTextStyle: _descTextStyle,
                            shapeBorder: const CircleBorder(),
                            overlayPadding: const EdgeInsets.all(3),
                            child: GestureDetector(
                              onTap: () => _c.notification(),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    child: const Icon(Icons.notifications,
                                        size: 20),
                                  ),
                                  if (_c.isNotifHaveUnread.value)
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 7,
                                      width: 7,
                                      decoration: const BoxDecoration(
                                          color: green, shape: BoxShape.circle),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: h(30)),
                  _checkVerifyStatus(_c.idVerifyStatus.value),
                  Container(
                    width: double.infinity,
                    height: w(80),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                              color: green,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/card_bg.png'),
                                  fit: BoxFit.fitWidth),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Saldo anda',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: blue),
                                ),
                                (_c.balance.value == 'NA')
                                    ? Shimmer(
                                        gradient: const LinearGradient(
                                            colors: [Colors.white54, green]),
                                        direction: ShimmerDirection.ltr,
                                        child: Container(
                                          height: 18,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white),
                                        ),
                                      )
                                    : InkWell(
                                        child: Row(
                                          children: [
                                            Text(
                                                (_c.showBalance.value)
                                                    ? '${dtUser['nama'].toString().split(' ').first} - Rp. ' +
                                                        _c.balance.value +
                                                        '  '
                                                    : '${dtUser['nama'].toString().split(' ').first} - Rp. ' +
                                                        StringUtils
                                                            .stringToSecureFullText(
                                                                _c.balance
                                                                    .value) +
                                                        '  ',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: t10)),
                                            Icon(
                                              (_c.showBalance.value)
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: disabledGreen,
                                            )
                                          ],
                                        ),
                                        onTap: () => {
                                          if (_c.showBalance.value)
                                            _c.showBalance.value = false
                                          else
                                            _c.showBalance.value = true,
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h(33)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (dtUser['tipe'] == 'member')
                        Showcase(
                          key: _two,
                          title: 'TopUp Saldo Eidupay',
                          description:
                              'Transaksi makin mudah dimulai dengan isi saldo eidupay.',
                          titleTextStyle: _titleTextStyle,
                          descTextStyle: _descTextStyle,
                          overlayPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          radius: const BorderRadius.all(Radius.circular(16)),
                          child: Menu1(
                            img: 'assets/images/ico_topup.png',
                            title: 'Top Up',
                            act: () => _c.topup(),
                          ),
                        ),
                      if (dtUser['tipe'] == 'member')
                        Showcase(
                          key: _three,
                          title: 'Transfer',
                          description:
                              'Mau kirim uang kemana aja bisa!\nMudah, cepat dan aman lho. Cobain deh.',
                          titleTextStyle: _titleTextStyle,
                          descTextStyle: _descTextStyle,
                          overlayPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          radius: const BorderRadius.all(Radius.circular(16)),
                          child: Menu1(
                            img: 'assets/images/ico_transfer.png',
                            title: 'Transfer',
                            act: () => _c.transfer(),
                          ),
                        ),
                      Showcase(
                        key: _four,
                        title: 'Scan QR Code',
                        description:
                            'Scan QRIS dimana saja.\nDijamin anti ribet!',
                        titleTextStyle: _titleTextStyle,
                        descTextStyle: _descTextStyle,
                        overlayPadding: const EdgeInsets.symmetric(vertical: 8),
                        radius: const BorderRadius.all(Radius.circular(16)),
                        child: Menu1(
                          img: 'assets/images/logo_scan.png',
                          title: 'Bayar',
                          act: () => Get.toNamed(QrisScanPage.route.name),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(33)),
                  if (dtUser['tipe'] == 'member')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Layanan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: t100),
                        ),
                        SizedBox(height: h(16)),
                        Showcase(
                          key: _six,
                          title: 'Produk dan Layanan',
                          description:
                              'Beragam produk dan layanan menarik dari berbagai mitra bisa kamu temukan disini.',
                          titleTextStyle: _titleTextStyle,
                          descTextStyle: _descTextStyle,
                          overlayPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          radius: const BorderRadius.all(Radius.circular(16)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (_c.serviceApps.isNotEmpty)
                                  ? CustomMenu3(menu: _c.serviceApps[5])
                                  : const ShimmerMenu3(),
                              (_c.serviceApps.isNotEmpty)
                                  ? CustomMenu3(menu: _c.serviceApps[1])
                                  : const ShimmerMenu3(),
                              (_c.serviceApps.isNotEmpty)
                                  ? CustomMenu3(menu: _c.serviceApps[2])
                                  : const ShimmerMenu3(),
                              (_c.serviceApps.isNotEmpty)
                                  ? CustomMenu2(
                                      img: 'assets/images/ico_services.png',
                                      title: 'Lainnya',
                                      clr: darkBlue,
                                      onTap: () => _c.services())
                                  : const ShimmerMenu3(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: h(33)),
                  _c.dataSiswa.isNotEmpty && _c.dataSiswa.value[0].ack != 'NOK'
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: disabledGreen,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Tagihan Data Siswa',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: blue),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: _c.dataSiswa.length,
                                            itemBuilder: (context, index) {
                                              final data = _c.dataSiswa[index];
                                              return InkWell(
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  margin:
                                                      const EdgeInsets.all(3),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: blue,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              StringUtils
                                                                  .toTitleCase(data
                                                                      .namaSekolah!),
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: t10)),
                                                          const Text('')
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              StringUtils
                                                                  .toTitleCase(
                                                                      data
                                                                          .nama!),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: t10)),
                                                          Text(data.kelas!,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: t10)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () =>
                                                    _c.toInquiryEdukasi(data),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Text(''),
                  SizedBox(height: h(33)),
                  Showcase(
                    key: _seven,
                    title: 'Sub Akun',
                    description:
                        'Kini kamu bisa berbagi limit akses eidupay kepada keluarga dan sahabat yang belum punya eidupay. Pasti seru banget!',
                    titleTextStyle: _titleTextStyle,
                    descTextStyle: _descTextStyle,
                    overlayPadding: const EdgeInsets.all(5),
                    radius: const BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Image.asset(
                                  'assets/images/extended-icon.png')),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_c.subAccountText,
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center),
                                GestureDetector(
                                  onTap: () => _c.toSubAccount(),
                                  child: Container(
                                    height: 25,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        color: green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Center(
                                      child: Text(
                                        'Pelajari',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h(33)),
                  (_c.iklanImages.isNotEmpty)
                      ? CarouselSlider.builder(
                          key: _eight,
                          itemCount: _c.iklanImages.length,
                          options: CarouselOptions(
                              aspectRatio: 16 / 7,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3)),
                          itemBuilder: (context, index, i) {
                            final iklan = _c.iklanImages[index];
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: blue.withOpacity(0.1),
                                image: DecorationImage(
                                    image:
                                        CachedNetworkImageProvider(iklan.image),
                                    fit: BoxFit.fill),
                              ),
                            );
                          },
                        )
                      : Shimmer(
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade300,
                            Colors.grey.shade100,
                          ]),
                          direction: ShimmerDirection.ltr,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                          ),
                        ),
                  SizedBox(height: h(43)),
                  Showcase(
                    key: _nine,
                    title: 'Lihat Riwayat',
                    description:
                        'Semua aktivitas transaksi bisa kamu cek disini.',
                    titleTextStyle: _titleTextStyle,
                    descTextStyle: _descTextStyle,
                    overlayPadding: const EdgeInsets.all(10),
                    radius: const BorderRadius.all(Radius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaksi terakhir',
                              style: TextStyle(
                                  fontSize: w(16),
                                  fontWeight: FontWeight.bold,
                                  color: green),
                            ),
                            GestureDetector(
                              onTap: _c.fullTrxTap,
                              child: Text(
                                'Lihat semua',
                                style: TextStyle(
                                    fontSize: w(12),
                                    fontWeight: FontWeight.bold,
                                    color: green),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h(30)),
                        (_c.lastTransaction.isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _c.lastTransaction.length > 3
                                    ? 3
                                    : _c.lastTransaction.length,
                                itemBuilder: (context, i) {
                                  final lastTransaction = _c.lastTransaction[i];
                                  return HistoryTransactionCard(
                                    lastTransaction: lastTransaction,
                                    onTap: () =>
                                        _c.historyCardTapped(lastTransaction),
                                  );
                                })
                            : const SizedBox(
                                height: 50,
                                child: Center(child: Text('Tidak ada data.')),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showCasePressed() async {
    Get.back();
    ShowCaseWidget.of(context)?.startShowCase(
        [_one, _two, _three, _four, _five, _six, _seven, _eight]);
  }

  Widget _checkVerifyStatus(String idVerifyStatus) {
    if (idVerifyStatus == '2') {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: w(50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: orange1.withOpacity(0.1)),
            child: Row(
              children: [
                const SizedBox(width: 15),
                SizedBox(
                  width: w(30),
                  height: w(30),
                  child: Image.asset('assets/images/ico_warning_big1.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'KYC not Verified',
                      style: TextStyle(
                          fontSize: w(12), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: w(150),
                        child: Text('Verifikasi KYC untuk akses semua fitur.',
                            style: TextStyle(
                                fontSize: w(10),
                                fontWeight: FontWeight.w400,
                                color: t70)))
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: SubmitButton(
                    fontSize: 13,
                    height: 34,
                    borderRadius: 10,
                    text: 'Verify',
                    backgroundColor: orange1,
                    onPressed: () {
                      Get.toNamed(InstructionPage.route.name,
                          arguments: PageArgument.kycPage1());
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h(15)),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget menu1(
    BuildContext context,
    String img,
    String title,
    VoidCallback act,
  ) =>
      GestureDetector(
        onTap: act,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.width * 0.135,
              width: MediaQuery.of(context).size.width * 0.135,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: blue),
              child: Center(child: Image.asset(img, color: Colors.white)),
            ),
            SizedBox(height: h(13)),
            SizedBox(
                width: 75,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: t100),
                      textAlign: TextAlign.center),
                )),
          ],
        ),
      );

  Widget menu1Icon(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback act,
  ) =>
      GestureDetector(
        onTap: act,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.width * 0.135,
              width: MediaQuery.of(context).size.width * 0.135,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: blue),
              child: Icon(icon, color: Colors.white, size: h(28)),
            ),
            SizedBox(height: h(13)),
            SizedBox(
                width: 75,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: t100),
                      textAlign: TextAlign.center),
                )),
          ],
        ),
      );

  @override
  void dispose() {
    _one.currentState?.dispose();
    _two.currentState?.dispose();
    _three.currentState?.dispose();
    _four.currentState?.dispose();
    _five.currentState?.dispose();
    _six.currentState?.dispose();
    _seven.currentState?.dispose();
    _eight.currentState?.dispose();
    _nine.currentState?.dispose();

    super.dispose();
  }
}

class Menu1 extends StatelessWidget {
  final String img, title;
  final VoidCallback? act;

  const Menu1({Key? key, required this.img, required this.title, this.act})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: act,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.width * 0.135,
            width: MediaQuery.of(context).size.width * 0.135,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: blue),
            child: Center(child: Image.asset(img, color: Colors.white)),
          ),
          SizedBox(height: h(13)),
          SizedBox(
              width: 75,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400, color: t100),
                    textAlign: TextAlign.center),
              )),
        ],
      ),
    );
  }
}

class ShimmerMenu3 extends StatelessWidget {
  const ShimmerMenu3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        gradient: LinearGradient(
            colors: [Colors.grey.shade300, Colors.grey.shade100]),
        direction: ShimmerDirection.ltr,
        child: Container(
          padding: const EdgeInsets.all(3),
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
        ));
  }
}

class CustomMenu2 extends StatelessWidget {
  const CustomMenu2(
      {Key? key,
      required this.img,
      required this.title,
      required this.clr,
      this.onTap})
      : super(key: key);

  final String img;
  final String title;
  final Color clr;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(13.5),
            height: MediaQuery.of(context).size.width * 0.135,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: t80.withOpacity(0.1)),
            child: Center(child: Image.asset(img, color: clr)),
          ),
          SizedBox(height: h(13)),
          SizedBox(
            width: 75,
            child: Text(title,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: t100),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class CustomMenu3 extends StatelessWidget {
  const CustomMenu3({Key? key, required this.menu, this.onTap})
      : super(key: key);

  final VoidCallback? onTap;
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    final _serviceCont = Get.find<ServiceCont>();
    return GestureDetector(
      onTap: () => _serviceCont.serviceTap(menu.title, menu.idMenu),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: t80.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Image(image: NetworkImage(menu.icon)),
          ),
          SizedBox(height: h(13)),
          SizedBox(
              width: 75,
              child: Text(
                menu.title,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: t100),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
