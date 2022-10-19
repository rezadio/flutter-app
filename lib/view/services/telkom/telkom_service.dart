import 'package:eidupay/controller/services/telkom/telkom_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_drop_down_form_field.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:eidupay/widget/shimmer_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shimmer/shimmer.dart';

class TelkomService extends StatefulWidget {
  static final route =
      GetPage(name: '/telkom-service', page: () => const TelkomService());
  const TelkomService({Key? key}) : super(key: key);

  @override
  State<TelkomService> createState() => _TelkomServiceState();
}

class _TelkomServiceState extends State<TelkomService> {
  final _c = Get.put(TelkomCont(injector.get()));
  final id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Telkom')),
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            return _c.inProccess.value
                ? Shimmer.fromColors(
                    child: const ShimmerBodyAll(),
                    baseColor: (Colors.grey[300])!,
                    highlightColor: (Colors.grey[100])!)
                : const _BodyTelkomServicePage();
          })),
    );
  }
}

class _BodyTelkomServicePage extends StatefulWidget {
  const _BodyTelkomServicePage({Key? key}) : super(key: key);

  @override
  State<_BodyTelkomServicePage> createState() => __BodyTelkomServicePageState();
}

class __BodyTelkomServicePageState extends State<_BodyTelkomServicePage>
    with SingleTickerProviderStateMixin {
  final _c = Get.find<TelkomCont>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _c.getRecentTrx(Get.arguments);
    _c.getFavorite(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<TelkomCont>();
    IconData? clearIcon;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(24)),
              Text(
                'Ayo! Lakukan pembayaran tagihan telepon rumah atau internet telkom mu tepat waktu.',
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
                        CustomTextFormField(
                          controller: _c.contNoPelanggan,
                          title: 'Nomor Pelanggan',
                          hintText: 'Masukkan Nomor pelanggan/telepon rumah',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) => {
                            setState(() {
                              if (value.isNotEmpty) {
                                clearIcon = Icons.clear;
                              } else {
                                clearIcon = null;
                              }
                            })
                          },
                          suffixIcon: GestureDetector(
                            child: Icon(clearIcon),
                            onTap: () => _c.clear(),
                          ),
                          validator: (val) {
                            if (val!.isEmpty || val == '') {
                              return 'No Pelanggan tidak boleh kosong!';
                            }
                          },
                        ),
                      ])),
              SizedBox(
                height: h(20),
              ),
              _c.infoTelkom.value != ''
                  ? Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: green2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onTap: () => _c.infoTelkom.value = '',
                              ),
                            ],
                          ),
                          SizedBox(height: h(20)),
                          Text(_c.infoTelkom.value.replaceAll('\\n', '\n'),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: t90,
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w200)),
                        ],
                      ))
                  : Text(''),
              SizedBox(height: h(20)),
              Row(
                children: [
                  Checkbox(
                      value: _c.favorite.value,
                      onChanged: (val) {
                        _c.favorite.value = !_c.favorite.value;
                      }),
                  Text(
                    'Simpan sebagai favorit',
                    style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.w400,
                        color: t70),
                  ),
                ],
              ),
              if (_c.favorite.value == true)
                TextFormField(
                  controller: _c.favoriteController,
                  decoration: underlineInputDecoration.copyWith(
                      hintText: 'Masukkan nama favorit'),
                ),
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
                  // _Recent(
                  //   data: _c.recentTrx,
                  //   jenis: 'recent',
                  // ),
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
                                  _c.contNoPelanggan.text = noPelanggan;
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
    _tabController.dispose();
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
