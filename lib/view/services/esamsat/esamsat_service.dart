import 'package:eidupay/controller/services/esamsat/esamsat_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_drop_down_form_field.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:eidupay/widget/shimmer_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class EsamsatService extends StatefulWidget {
  static final route =
      GetPage(name: '/esamsat', page: () => const EsamsatService());
  const EsamsatService({Key? key}) : super(key: key);

  @override
  State<EsamsatService> createState() => _EsamsatServiceState();
}

class _EsamsatServiceState extends State<EsamsatService>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(EsamsatCont(injector.get()));
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
          appBar: AppBar(title: const Text('E-Samsat')),
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
  final _c = Get.find<EsamsatCont>();
  @override
  void initState() {
    super.initState();
    _c.getRecentTrx(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<EsamsatCont>();
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
                        CustomDropdownFormField(
                          title: 'Wilayah',
                          hint: 'Pilih wilayah samsat',
                          items: _c.listProductEsamsat['listBiller']
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              child: Text(item['namaOperator']),
                              value: item['idOperator'] + '|' + item['info'],
                            );
                          }).toList(),
                          onPressed: (value) {
                            _c.idBiller.value = value!.split('|')[0];
                            _c.infoSamsat.value = value.split('|')[1];
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Wajib dipilih';
                            }
                          },
                        ),
                        SizedBox(height: h(25)),
                        CustomTextFormField(
                          controller: _c.contKodeBayar,
                          title: 'Kode Bayar',
                          hintText: 'Masukkan Kode Bayar',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.clear),
                            onTap: () => _c.clear(),
                          ),
                          validator: (val) {
                            if (val!.isEmpty || val == '') {
                              return 'Kode Bayar tidak boleh kosong!';
                            }
                          },
                        ),
                        // ignore: unnecessary_null_comparison
                        _c.infoSamsat.value != ''
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(color: green2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Info',
                                          style: TextStyle(
                                              color: t90,
                                              fontSize: w(14),
                                              fontWeight: FontWeight.w900),
                                        ),
                                        GestureDetector(
                                          child: const Icon(
                                            Icons.clear,
                                            size: 20,
                                            color: green,
                                          ),
                                          onTap: () => _c.infoSamsat.value = '',
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: h(20)),
                                    Text(
                                        _c.infoSamsat.value
                                            .replaceAll('\\n', '\n'),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: t90,
                                            fontSize: w(12),
                                            fontWeight: FontWeight.w200)),
                                  ],
                                ))
                            : const Text(''),
                      ])),
              SizedBox(height: h(20)),
              SubmitButton(
                backgroundColor: green,
                text: 'Lanjutkan',
                onPressed: () => _c.continueTap(),
              ),
              SizedBox(height: h(40)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2, color: green),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    'Transaksi Terakhir',
                    style: TextStyle(
                        color: t90,
                        fontSize: w(14),
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: _c.recentTrx.isEmpty
                    ? const Center(child: Text('Tidak ada data.'))
                    : Container(
                        height: 30,
                        width: double.infinity,
                        child: Center(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(top: 20.0),
                              physics: const BouncingScrollPhysics(),
                              itemCount: _c.recentTrx.length,
                              itemBuilder: (context, index) {
                                return RecentTransactionWidget(
                                    title:
                                        _c.recentTrx[index].namaTipeTransaksi,
                                    id: _c.recentTrx[index].noRekTujuan ?? '',
                                    date: _c.recentTrx[index].timeStamp,
                                    price: _c.recentTrx[index].total);
                              }),

                          // Column(

                          //    children: [ Row(
                          //     children: [
                          //       Text('Transaksi Teraakhir'),
                          //       SizedBox(
                          //         height: 300,
                          //         child: ListView.builder(
                          //             padding: const EdgeInsets.only(top: 20.0),
                          //             physics: const BouncingScrollPhysics(),
                          //             itemCount: _c.recentTrx.length,
                          //             itemBuilder: (context, index) {
                          //               return RecentTransactionWidget(
                          //                   title: _c.recentTrx[index].namaTipeTransaksi,
                          //                   id: _c.recentTrx[index].noRekTujuan ?? '',
                          //                   date: _c.recentTrx[index].timeStamp,
                          //                   price: _c.recentTrx[index].total);
                          //             }),
                          //       ),
                          //     ],
                          //   ),
                          //    ]
                          // ),
                          // TabBar(
                          //   controller: _tabController,
                          //   tabs: const [
                          //     Tab(text: 'Transaksi Terakhir'),
                          //     // Tab(text: 'Tersimpan'),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 300,
                          //   child: TabBarView(controller: _tabController, children: [
                          //     _c.recentTrx.isEmpty
                          //         ? const Center(child: Text('Tidak ada data.'))
                          //         : ListView.builder(
                          //             padding: const EdgeInsets.only(top: 20.0),
                          //             physics: const BouncingScrollPhysics(),
                          //             itemCount: _c.recentTrx.length,
                          //             itemBuilder: (context, index) {
                          //               return RecentTransactionWidget(
                          //                   title: _c.recentTrx[index].namaTipeTransaksi,
                          //                   id: _c.recentTrx[index].noRekTujuan ?? '',
                          //                   date: _c.recentTrx[index].timeStamp,
                          //                   price: _c.recentTrx[index].total);
                          //             }),
                          //     // _Recent(
                          //     //   data: _c.recentTrx,
                          //     //   jenis: 'recent',
                          //     // ),
                          //     // _c.savedName.isEmpty
                          //     //     ? const Center(child: Text('Tidak ada data.'))
                          //     //     : ListView.builder(
                          //     //         itemCount: _c.savedName.length,
                          //     //         itemBuilder: (context, index) {
                          //     //           final aliasName = _c.savedName[index].aliasName;
                          //     //           final noPelanggan = _c.savedName[index].noPelanggan;
                          //     //           return Padding(
                          //     //             padding: const EdgeInsets.only(top: 10),
                          //     //             child: _FavoriteCard(
                          //     //               aliasName: aliasName,
                          //     //               noPelanggan: noPelanggan,
                          //     //               onTap: () {
                          //     //                 _c.contNoPelanggan.text = noPelanggan;
                          //     //               },
                          //     //             ),
                          //     //           );
                          //     //         })
                          //   ]),
                          // ),
                        )),
              )
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
