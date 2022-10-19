import 'package:eidupay/controller/services/listrik/listrik_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:eidupay/widget/shimmer_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eidupay/tools.dart';

class ListrikService extends StatefulWidget {
  const ListrikService({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/listrik_service', page: () => const ListrikService());

  @override
  _ListrikServiceState createState() => _ListrikServiceState();
}

class _ListrikServiceState extends State<ListrikService> {
  final _c = Get.put(ListrikCont(injector.get()));
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Listrik PLN')),
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            return _c.inProccess.value
                ? Shimmer.fromColors(
                    child: const ShimmerBodyAll(),
                    baseColor: (Colors.grey[300])!,
                    highlightColor: (Colors.grey[100])!)
                : const _BodyListrik();
          })),
    );
  }
}

class _BodyListrik extends StatefulWidget {
  const _BodyListrik({Key? key}) : super(key: key);

  @override
  __BodyListrikState createState() => __BodyListrikState();
}

class __BodyListrikState extends State<_BodyListrik>
    with SingleTickerProviderStateMixin {
  final _c = Get.find<ListrikCont>();
  late TabController _tabController;
  late List recentTrx;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _c.getRecentTrx(Get.arguments[0]);
    _c.getFavorite(Get.arguments[0]);
  }

  @override
  Widget build(BuildContext context) {
    _c.val.value = Get.arguments[1];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(24)),
              Text(
                'Ayo! Lakukan pembelian token atau tagihan listrik sebelum listrik anda padam ',
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w400, color: t100),
              ),
              SizedBox(height: h(15)),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'token',
                        groupValue: _c.val.value,
                        onChanged: (val) {
                          _c.val.value = val!;
                        },
                        activeColor: Colors.green,
                      ),
                      Text(
                        'Token Listrik',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w400,
                            color: t100),
                      ),
                    ],
                  ),
                  SizedBox(width: w(20)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'tagihan',
                        groupValue: _c.val.value,
                        onChanged: (v) {
                          _c.val.value = v!;
                        },
                        activeColor: Colors.green,
                      ),
                      Text(
                        'Tagihan Listrik',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w400,
                            color: t100),
                      ),
                    ],
                  ),
                ],
              ),
              Form(
                  key: _c.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h(25)),
                      CustomTextFormField(
                        controller: _c.contNoPelanggan,
                        title: 'Nomor Pelanggan',
                        hintText: 'Masukkan Nomor pelanggan',
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
                            return 'No Pelanggan tidak boleh kosong!';
                          }
                        },
                      ),
                      SizedBox(height: h(25)),
                      Obx(() => _c.val.value == 'token'
                          ? const _Token()
                          : Container()),
                    ],
                  )),
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
}

class _Recent extends StatelessWidget {
  const _Recent({Key? key, required this.data, required this.jenis})
      : super(key: key);
  final List data;
  final String jenis;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Token Listrik',
                        style: TextStyle(
                            fontSize: 12,
                            color: t70,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data[index].noHpTujuan ?? data[index].noRekTujuan,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),
                  jenis == 'recent'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              data[index].timeStamp,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: t70,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              StringUtils.stringToIdr(data[index].total),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blue),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            width: w(76),
                            height: w(34),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: lightBlue)),
                            child: const Center(
                                child: Text(
                              'Bayar',
                              style: TextStyle(color: lightBlue),
                            )),
                          ),
                        ),
                ],
              ),
              const Divider(height: 30, color: t60),
            ],
          );
        });
  }
}

class _Token extends StatelessWidget {
  const _Token({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<ListrikCont>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: _c.contNominal,
          title: 'Nominal',
          keyboardType: TextInputType.number,
          enableEdit: false,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          // suffixIcon: GestureDetector(
          //   child: const Icon(Icons.clear),
          //   onTap: () => _c.clearNominal(),
          // ),
          validator: (val) {
            if (val!.isEmpty || val == '') {
              return 'Nominal tidak boleh kosong!';
            }
          },
        ),
        SizedBox(height: h(10)),
        // ignore: avoid_unnecessary_containers
        Container(
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 140,
                childAspectRatio: 3 / 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _c.dataDenomListrik['denom'].length,
              itemBuilder: (BuildContext ctx, i) {
                return _NominalButton(
                  dataDenom: _c.dataDenomListrik['denom'][i],
                );
              }),

          // ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: _c.dataDenomListrik['denom'].length,
          //     itemBuilder: (context, i) {
          //       return Padding(
          //         padding: const EdgeInsets.only(right: 10),
          //         child: _NominalButton(
          //           dataDenom: _c.dataDenomListrik['denom'][i],
          //         ),
          //       );
          //     }),
        )
      ],
    );
  }
}

class _NominalButton extends StatelessWidget {
  const _NominalButton({Key? key, required this.dataDenom}) : super(key: key);

  final Map<String, dynamic> dataDenom;

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<ListrikCont>();
    return GestureDetector(
      onTap: () => _c.nominalTap(context, dataDenom),
      child: Container(
        width: w(60),
        height: w(26),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: green)),
        child: Center(
          child: Text(
            dataDenom['nominal'],
            style: TextStyle(
                fontSize: w(14), fontWeight: FontWeight.w700, color: darkBlue),
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
              style: const TextStyle(
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
