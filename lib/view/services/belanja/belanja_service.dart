import 'package:eidupay/controller/services/belanja/belanja_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/view/qris/qris_scan_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:eidupay/widget/shimmer_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class BelanjaService extends StatefulWidget {
  static final route =
      GetPage(name: '/belanja', page: () => const BelanjaService());
  const BelanjaService({Key? key}) : super(key: key);

  @override
  State<BelanjaService> createState() => _BelanjaServiceState();
}

class _BelanjaServiceState extends State<BelanjaService>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(BelanjaCont(injector.get()));
  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _c.getRecentTrx(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Belanja')),
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            return _c.inProccess.value
                ? Shimmer.fromColors(
                    child: const ShimmerBodyAll(),
                    baseColor: (Colors.grey[300])!,
                    highlightColor: (Colors.grey[100])!)
                : const _BodySamsatServicePage();
          })),
    );
  }
}

class _BodySamsatServicePage extends StatefulWidget {
  const _BodySamsatServicePage({Key? key}) : super(key: key);

  @override
  State<_BodySamsatServicePage> createState() => __BodySamsatServicePageState();
}

class __BodySamsatServicePageState extends State<_BodySamsatServicePage>
    with SingleTickerProviderStateMixin {
  final _c = Get.find<BelanjaCont>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _c.getRecentTrx(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<BelanjaCont>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(24)),
              Text(
                'Ayo! Lakukan pembayaran tagihan pajak tahunan kendaraanmu, sebelum jatuh tempo.',
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w400, color: t100),
              ),
              SizedBox(height: h(20)),
              Form(
                  key: _c.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h(25)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              // ignore: avoid_unnecessary_containers
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border:
                                            Border.all(width: 2, color: t30)),
                                    child: const ImageIcon(
                                      AssetImage('assets/images/logo_scan.png'),
                                      size: 25,
                                      color: t10,
                                    ),
                                  ),
                                  const Text(
                                    'Scan QR',
                                    style: TextStyle(color: t80),
                                  )
                                ],
                              ),
                              onTap: () => Get.toNamed(QrisScanPage.route.name),
                            ),
                          ],
                        ),
                        CustomTextFormField(
                          controller: _c.contKodeMerchant,
                          title: 'Kode Merchant',
                          hintText: 'Masukkan Kode Merchant',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.clear),
                            onTap: () => _c.clearKodeMerchant(),
                          ),
                          validator: (val) {
                            if (val!.isEmpty || val == '') {
                              return 'Kode Merchant tidak boleh kosong!';
                            }
                          },
                        ),
                        CustomTextFormField(
                          controller: _c.contNominal,
                          title: 'Nominal',
                          hintText: 'Masukkan Nominal Belanja',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.clear),
                            onTap: () => _c.clearNominal(),
                          ),
                          validator: (val) {
                            if (val!.isEmpty || val == '') {
                              return 'Nominal Belanja tidak boleh kosong!';
                            }
                          },
                        ),
                        CustomTextFormField(
                          controller: _c.contBerita,
                          title: 'Keterangan',
                          hintText: 'Masukkan keterangan',
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.clear),
                            onTap: () => _c.clearKeterangan(),
                          ),
                          maxLength: 20,
                          validator: (val) {
                            if (val!.isEmpty || val == '') {
                              return 'Keterangan tidak boleh kosong!';
                            }
                          },
                        ),
                      ])),
              SizedBox(height: h(20)),
              SubmitButton(
                backgroundColor: green,
                text: 'Lanjutkan',
                onPressed: () => _c.continueTap(),
              ),
              SizedBox(height: h(10)),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Transaksi Terakhir'),
                  Tab(text: 'Tersimpan'),
                ],
              ),
              SizedBox(
                height: 300,
                child: TabBarView(controller: _tabController, children: [
                  _c.recentTrx.isEmpty
                      ? const Center(child: Text('Tidak ada data.'))
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 20.0),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _c.recentTrx.length,
                          itemBuilder: (context, index) {
                            return RecentTransactionWidget(
                                title: _c.recentTrx[index].namaTipeTransaksi,
                                id: _c.recentTrx[index].noRekTujuan ?? '',
                                date: _c.recentTrx[index].timeStamp,
                                price: _c.recentTrx[index].total);
                          }),
                  _c.savedName.isEmpty
                      ? const Center(child: Text('Tidak ada data.'))
                      : ListView.builder(
                          itemCount: _c.savedName.length,
                          itemBuilder: (context, index) {
                            final aliasName = _c.savedName[index].aliasName;
                            final noPelanggan = _c.savedName[index].noPelanggan;
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: _FavoriteCard(
                                aliasName: aliasName,
                                noPelanggan: noPelanggan,
                                onTap: () {
                                  _c.contKodeMerchant.text = noPelanggan;
                                },
                              ),
                            );
                          })
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _FavoriteCard extends StatelessWidget {
  final String aliasName;
  final String noPelanggan;
  final void Function()? onTap;
  const _FavoriteCard(
      {Key? key,
      required this.aliasName,
      required this.noPelanggan,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0xFFEAEAEA))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              aliasName,
              style: TextStyle(
                  color: t90, fontSize: w(14), fontWeight: FontWeight.w400),
            ),
            Text(
              noPelanggan,
              style: const TextStyle(
                  color: t90, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
