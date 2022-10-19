import 'package:eidupay/controller/services/pulsa/pulsa_cont.dart';
import 'package:eidupay/controller/services/pulsa/pulsa_list_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/pulsa_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class PulsaListProduk extends StatefulWidget {
  const PulsaListProduk({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/pulsa_list', page: () => const PulsaListProduk());

  @override
  _PulsaListProdukState createState() => _PulsaListProdukState();
}

class _PulsaListProdukState extends State<PulsaListProduk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pulsa / Paket Data')),
      body: _BodyPulsa(),
    );
  }
}

class _BodyPulsa extends StatefulWidget {
  const _BodyPulsa({Key? key}) : super(key: key);

  @override
  __BodyPulsaState createState() => __BodyPulsaState();
}

class __BodyPulsaState extends State<_BodyPulsa>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(PulsaListCont(injector.get()));
  final _contPulsa = Get.find<PulsaCont>();
  late TabController _tabController;
  late String logoOperator;

  @override
  void initState() {
    super.initState();
    _c.lsPulsa = _contPulsa.listPulsa;
    _c.lsData = _contPulsa.listData;

    _tabController = TabController(length: 2, vsync: this);
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'Simpati') {
      logoOperator = 'logo_simpati.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'Mentari') {
      logoOperator = 'logo_mentari.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'IM3') {
      logoOperator = 'logo_im3.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'As') {
      logoOperator = 'logo_as.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'XL') {
      logoOperator = 'logo_xl.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'Axis') {
      logoOperator = 'logo_axis.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'Tri') {
      logoOperator = 'logo_tri.png';
    }
    if (_c.lsPulsa.dataDenom.first.namaOperator == 'Smartfren') {
      logoOperator = 'logo_smartfren.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h(10)),
                SizedBox(height: h(15)),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor Handphone',
                            style: TextStyle(
                                fontSize: w(16),
                                fontWeight: FontWeight.w500,
                                color: t100),
                          ),
                          Text(
                            _c.noHp.value,
                            style: TextStyle(
                                fontSize: w(16),
                                fontWeight: FontWeight.w500,
                                color: t80),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        height: 100,
                        width: 125,
                        child: Image.asset('assets/images/' + logoOperator),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            SizedBox(height: h(30)),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Pulsa'),
                Tab(text: 'Paket Data'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: _Pulsa(data: _c.lsPulsa, noHp: _c.noHp.value),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Data(data: _c.lsData, noHp: _c.noHp.value),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Pulsa extends StatelessWidget {
  final PulsaRest data;
  final String noHp;

  const _Pulsa({Key? key, required this.data, required this.noHp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<PulsaListCont>();

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 0.77,
          crossAxisSpacing: 30,
          mainAxisSpacing: 15,
        ),
        itemCount: data.dataDenom.length,
        itemBuilder: (BuildContext ctx, i) {
          final dataDenom = data.dataDenom[i];
          return _NominalButton(dataDenom: dataDenom);
        });
    //     return ListView.builder(
    // itemCount: data.dataDenom.length,
    // itemBuilder: (context, i) {
    //   final dataDenom = data.dataDenom[i];
    //   return Column(
    //     children: [
    //       SizedBox(height: h(30)),
    //       GestureDetector(
    //         onTap: () => _c.pulsaTap(PulsaService.pulsa, dataDenom),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               dataDenom.nominal,
    //               style: TextStyle(
    //                   fontSize: w(14),
    //                   fontWeight: FontWeight.w400,
    //                   color: t100),
    //             ),
    //             Text(
    //               'Rp. ' + dataDenom.hargaCetak,
    //               style: TextStyle(
    //                   fontSize: w(16),
    //                   fontWeight: FontWeight.w400,
    //                   color: t100),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: h(21)),
    //       Divider(color: Colors.grey[350], thickness: 1)
    //     ],
    //   );
    // });
  }
}

class _NominalButton extends StatelessWidget {
  const _NominalButton({Key? key, required this.dataDenom}) : super(key: key);

  final Pulsa dataDenom;

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<PulsaListCont>();
    return GestureDetector(
      onTap: () => _c.pulsaTap(PulsaService.pulsa, dataDenom),
      child: Container(
        width: w(60),
        height: w(26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: green),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dataDenom.nominal,
              style: TextStyle(
                  fontSize: w(14),
                  fontWeight: FontWeight.w700,
                  color: darkBlue),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Rp. ' + dataDenom.hargaCetak,
              style: TextStyle(
                  fontSize: w(12), fontWeight: FontWeight.w400, color: green),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataButton extends StatelessWidget {
  const _DataButton({Key? key, required this.dataDenom}) : super(key: key);

  final PaketData dataDenom;

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<PulsaListCont>();
    return GestureDetector(
      onTap: () => _c.dataTap(PulsaService.data, dataDenom),
      child: Container(
        width: w(60),
        height: w(26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: green),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dataDenom.nominal,
              style: TextStyle(
                  fontSize: w(14),
                  fontWeight: FontWeight.w700,
                  color: darkBlue),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Rp. ' + dataDenom.hargaCetak,
              style: TextStyle(
                  fontSize: w(12), fontWeight: FontWeight.w400, color: green),
            ),
          ],
        ),
      ),
    );
  }
}

class _Data extends StatelessWidget {
  final DataRest data;
  final String noHp;

  const _Data({Key? key, required this.data, required this.noHp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<PulsaListCont>();
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 5 / 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: data.dataDenom.length,
        itemBuilder: (BuildContext ctx, i) {
          final dataDenom = data.dataDenom[i];
          return _DataButton(dataDenom: dataDenom);
        });
    // return ListView.builder(
    //     itemCount: data.dataDenom.length,
    //     itemBuilder: (context, i) {
    //       final dataDenom = data.dataDenom[i];
    //       return Column(
    //         children: [
    //           SizedBox(height: h(30)),
    //           GestureDetector(
    //             onTap: () => _c.dataTap(PulsaService.data, dataDenom),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text(
    //                   dataDenom.nominal,
    //                   style: TextStyle(
    //                       fontSize: w(14),
    //                       fontWeight: FontWeight.w400,
    //                       color: t100),
    //                 ),
    //                 Text(
    //                   'Rp. ' + dataDenom.hargaCetak,
    //                   style: TextStyle(
    //                       fontSize: w(16),
    //                       fontWeight: FontWeight.w400,
    //                       color: t100),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: h(21)),
    //           Divider(color: Colors.grey[350], thickness: 1)
    //         ],
    //       );
    //     });
  }
}
