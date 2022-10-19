import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/controller/sub_account/sub_home_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/qris/qris_scan_page.dart';
import 'package:eidupay/widget/history_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class SubHomePage extends StatelessWidget {
  static final route =
      GetPage(name: '/sub-account/', page: () => const SubHomePage());

  const SubHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _BodySubHomePage());
  }
}

class _BodySubHomePage extends StatefulWidget {
  const _BodySubHomePage({Key? key}) : super(key: key);

  @override
  _BodySubHomePageState createState() => _BodySubHomePageState();
}

class _BodySubHomePageState extends State<_BodySubHomePage> {
  final _c = Get.put(SubHomeCont(injector.get()));

  @override
  void initState() {
    super.initState();
    _c.initPrompt(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: SmartRefresher(
          controller: _c.refreshController,
          enablePullDown: true,
          onRefresh: () {
            _c.refreshService();
            _c.refreshController.refreshCompleted();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                          InkWell(
                            onTap: () => _c.profileTap(),
                            child: Container(
                              width: w(41),
                              height: w(41),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/default_profile.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _c.notification(),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child:
                                      const Icon(Icons.notifications, size: 20),
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
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: h(30)),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: t10),
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
                                    : Text(
                                        '${dtUser['nama'].toString().split(' ').first} - Rp. ' +
                                            _c.limit.string,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: t10)),
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
                                    : _c.limitHarian.value != '0'
                                        ? Text(
                                            'Batas harian anda : Rp. ' +
                                                StringUtils.stringToThousands(_c
                                                    .limitHarian.value
                                                    .toString()),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: t10))
                                        : const Text(''),
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
                      Menu1(
                        img: 'assets/images/ico_services.png',
                        title: 'Services',
                        act: () => _c.services(),
                      ),
                      Menu1(
                        img: 'assets/images/logo_scan.png',
                        title: 'Bayar',
                        act: () => Get.toNamed(QrisScanPage.route.name),
                      ),
                    ],
                  ),
                  SizedBox(height: h(33)),
                  (_c.iklanImages.isNotEmpty)
                      ? CarouselSlider.builder(
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
                  Column(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
