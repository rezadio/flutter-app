import 'package:eidupay/controller/services/bpjs/bpjs_service_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BPJS extends StatefulWidget {
  const BPJS({Key? key}) : super(key: key);
  static final route = GetPage(name: '/bjps', page: () => const BPJS());

  @override
  _BPJSState createState() => _BPJSState();
}

class _BPJSState extends State<BPJS> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _c = Get.put(BPJSServiceCont(injector.get()));
  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _c.getRecentTrx(Get.arguments);
    _c.getFavorite(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('BPJS Kesehatan')),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h(24)),
                Text('Ayo lakukan pembayaran BPJS sebelum jatuh tempo',
                    style: TextStyle(
                        fontSize: w(12),
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(height: h(24)),
                Text('Nomor Pelanggan',
                    style: TextStyle(
                        fontSize: w(12),
                        fontWeight: FontWeight.w500,
                        color: t80)),
                Form(
                    key: _c.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            controller: _c.custNumberCont,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintText: 'Masukkan nomor pelanggan',
                                hintStyle: TextStyle(
                                    fontSize: w(16),
                                    fontWeight: FontWeight.w400,
                                    color: t50),
                                suffixIcon: GestureDetector(
                                  child: const Icon(Icons.clear),
                                  onTap: () => _c.clear(),
                                )),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Nomor pelanggan wajib diisi';
                              }
                              if (value == null) {
                                return 'Nomor pelanggan wajib diisi';
                              }
                            })
                      ],
                    )),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: _c.remember.value,
                          onChanged: (val) {
                            _c.remember.value = val!;
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )),
                    Text('Simpan Nomor Pelanggan',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w400,
                            color: t70)),
                  ],
                ),
                if (_c.remember.value == true)
                  TextFormField(
                    controller: _c.favoriteController,
                    decoration: underlineInputDecoration.copyWith(
                        hintText: 'Masukkan nama favorit'),
                  ),
                SizedBox(height: h(32)),
                SubmitButton(
                    backgroundColor: green,
                    text: 'Lanjutkan',
                    onPressed: () => _c.continueTap()),
                SizedBox(height: h(24)),
                Divider(color: Colors.grey[350], thickness: 2),
                SizedBox(height: h(24)),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Transaksi Terakhir'),
                    Tab(text: 'Tersimpan'),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: TabBarView(controller: _tabController, children: [
                      SmartRefresher(
                        controller: refreshController,
                        onRefresh: () async {
                          await _c.getRecentTrx(Get.arguments);
                          refreshController.refreshCompleted();
                        },
                        child: (_c.recentTrx.isEmpty)
                            ? const Center(child: Text('Tidak ada data.'))
                            : ListView.builder(
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
                      ),
                      (_c.savedName.isEmpty)
                          ? const Center(child: Text('Tidak ada data.'))
                          : ListView.builder(
                              itemCount: _c.savedName.length,
                              itemBuilder: (context, index) {
                                final aliasName = _c.savedName[index].aliasName;
                                final noPelanggan =
                                    _c.savedName[index].noPelanggan;
                                return _FavoriteCard(
                                  aliasName: aliasName,
                                  noPelanggan: noPelanggan,
                                  onTap: () {
                                    _c.custNumberCont.text = noPelanggan;
                                  },
                                );
                              })
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
