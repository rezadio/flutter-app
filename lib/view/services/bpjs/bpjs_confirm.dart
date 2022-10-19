import 'package:eidupay/controller/services/bpjs/bpjs_confirm_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/bpjs.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class BPJSConfirm extends StatelessWidget {
  BPJSConfirm({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/bpjs_confirm', page: () => BPJSConfirm());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(BPJSConfirmCont(injector.get()));
    final BPJS bpjs = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('BPJS Kesehatan')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(24)),
              Text('Periksa dan pastikan data sibawah ini benar',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.w400,
                      color: t90)),
              SizedBox(height: h(24)),
              Text('Rincian Pelanggan',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.w500,
                      color: t80)),
              SizedBox(height: h(15)),
              _Detail(title: 'Nomor Pelanggan', desc: bpjs.idPelanggan ?? ''),
              _Detail(title: 'Nama', desc: bpjs.nama),
              _Detail(title: 'Periode', desc: bpjs.periode),
              _Detail(title: 'Nominal', desc: 'Rp ${bpjs.tagihan}'),
              _Detail(title: 'Biaya Pelanggan', desc: 'Rp ${bpjs.biayaAdmin}'),
              _Detail(title: 'Total Pembayaran', desc: 'Rp ${bpjs.hargaCetak}'),
              SizedBox(height: h(20)),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  height: w(44),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: green.withOpacity(0.1)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Saldo Sekarang',
                            style: TextStyle(
                                fontSize: w(12),
                                fontWeight: FontWeight.w400,
                                color: t100)),
                        Obx(
                          () => Text('Rp. ${_c.balance.value}',
                              style: TextStyle(
                                  fontSize: w(12),
                                  fontWeight: FontWeight.w400,
                                  color: darkBlue)),
                        )
                      ])),
              SizedBox(height: h(34)),
              SubmitButton(
                  backgroundColor: green,
                  text: 'Lanjut',
                  onPressed: () => _c.continueTap(bpjs))
            ],
          ),
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({Key? key, required this.title, required this.desc})
      : super(key: key);

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w400, color: t70)),
          Text(desc,
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w400, color: t100)),
        ],
      ),
    );
  }
}
