import 'package:eidupay/controller/services/pdam/pdam_controller.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/main.dart';
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

class PdamPage extends StatefulWidget {
  static final route =
      GetPage(name: '/sevices/pdam', page: () => const PdamPage());
  const PdamPage({Key? key}) : super(key: key);

  @override
  _PdamPageState createState() => _PdamPageState();
}

class _PdamPageState extends State<PdamPage> {
  @override
  Widget build(BuildContext context) {
    final _getController = Get.put(PdamController(injector.get()));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Pembayaran PDAM')),
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            return _getController.inProccess.value
                ? Shimmer.fromColors(
                    child: const ShimmerBodyAll(),
                    baseColor: (Colors.grey[300])!,
                    highlightColor: (Colors.grey[100])!)
                : const _BodyPdamPage();
          })),
    );
  }
}

class _BodyPdamPage extends StatefulWidget {
  const _BodyPdamPage({Key? key}) : super(key: key);

  @override
  _BodyPdamPageState createState() => _BodyPdamPageState();
}

class _BodyPdamPageState extends State<_BodyPdamPage>
    with SingleTickerProviderStateMixin {
  final _getController = Get.find<PdamController>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getController.getRecentTrx(Get.arguments);
    _getController.getFavorite(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _getController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: h(10)),
                            Text(
                              'Silahkan pilih area',
                              style: TextStyle(
                                  fontSize: w(15),
                                  fontWeight: FontWeight.bold,
                                  color: t100),
                            ),
                            TextFormField(
                              controller: _getController.areaContr,
                              onTap: () => _getController.areaTap(),
                              readOnly: true,
                              decoration:
                                  const InputDecoration(hintText: 'Pilih area'),
                            ),
                            SizedBox(height: h(25)),
                            CustomTextFormField(
                              controller: _getController.idController,
                              title: 'ID Pelanggan',
                              hintText: 'Masukkan di sini',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              suffixIcon: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () => _getController.clear(),
                              ),
                              validator: (val) {
                                if (val!.isEmpty || val == '') {
                                  return 'ID Pelanggan harus diisi';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: _getController.isChecked.value,
                              onChanged: (val) {
                                _getController.isChecked.value =
                                    !_getController.isChecked.value;
                              },
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  _getController.isChecked.value =
                                      !_getController.isChecked.value;
                                },
                                child: const Text('Simpan nomor pelanggan',
                                    style: TextStyle(fontSize: 14, color: t70)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return _getController.isChecked.value == true
                            ? TextFormField(
                                controller: _getController.favoriteController,
                                decoration: underlineInputDecoration.copyWith(
                                    hintText: 'Masukkan nama favorit'),
                              )
                            : Container();
                      }),
                      const SizedBox(height: 24),
                      SubmitButton(
                        text: 'Lanjutkan',
                        onPressed: () => _getController.lanjutkanTap(),
                        backgroundColor: green,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h(30)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Transaksi Terakhir'),
                      Tab(text: 'Tersimpan')
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Obx(
                        () => SmartRefresher(
                          controller: _getController.refreshController,
                          onRefresh: () {
                            _getController.getRecentTrx(Get.arguments);
                            _getController.refreshController.refreshCompleted();
                          },
                          child: (_getController.recentTrx.isEmpty)
                              ? const Center(child: Text('Tidak ada data.'))
                              : ListView.builder(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, right: 30.0, left: 30.0),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _getController.recentTrx.length,
                                  itemBuilder: (context, index) {
                                    return RecentTransactionWidget(
                                        title: _getController
                                            .recentTrx[index].namaTipeTransaksi,
                                        id: _getController
                                                .recentTrx[index].noRekTujuan ??
                                            '',
                                        date: _getController
                                            .recentTrx[index].timeStamp,
                                        price: _getController
                                            .recentTrx[index].total);
                                  }),
                        ),
                      ),
                      _getController.savedName.isEmpty
                          ? const Center(child: Text('Tidak ada data.'))
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _getController.savedName.length,
                                  itemBuilder: (context, index) {
                                    final aliasName = _getController
                                        .savedName[index].aliasName;
                                    final noPelanggan = _getController
                                        .savedName[index].noPelanggan;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: _FavoriteCard(
                                        aliasName: aliasName,
                                        noPelanggan: noPelanggan,
                                        onTap: () {
                                          _getController.idController.text =
                                              noPelanggan;
                                        },
                                      ),
                                    );
                                  }),
                            )
                    ],
                  ),
                )
              ],
            )));
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
                  fontSize: 16, color: t70, fontWeight: FontWeight.w600),
            ),
            Text(
              noPelanggan,
              style: const TextStyle(
                  color: t90, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
