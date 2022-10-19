import 'package:eidupay/controller/swiff/swiff_payment_controller.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/swiff.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/eidu_saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SwiffPaymentPage extends StatelessWidget {
  static final route =
      GetPage(name: '/swiff/payment/:id', page: () => const SwiffPaymentPage());
  const SwiffPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pembayaran')),
      resizeToAvoidBottomInset: false,
      body: const _BodySwiffPaymentPage(),
    );
  }
}

class _BodySwiffPaymentPage extends StatefulWidget {
  const _BodySwiffPaymentPage({Key? key}) : super(key: key);

  @override
  _BodySwiffPaymentPageState createState() => _BodySwiffPaymentPageState();
}

class _BodySwiffPaymentPageState extends State<_BodySwiffPaymentPage> {
  final _c = Get.put(SwiffPaymentController(injector.get()));
  final SwiffInquiry inquiry = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.amountController.text = int.parse(inquiry.total).amountFormat;
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('MMM d, y h:m:s', 'in_ID').format(inquiry.dateTrx);
    final nominalBelanja =
        int.parse(inquiry.nominalBelanja.numericOnly()).amountFormat;
    final biaya = int.parse(inquiry.biaya.numericOnly()).amountFormat;
    final total = int.parse(inquiry.total.numericOnly()).amountFormat;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => EiduSaldoCard(saldo: _c.balance.value)),
            const SizedBox(height: 30),
            const Text(
              'Nama Merchant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: t60.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                inquiry.nama,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 34),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rincian',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                CustomSingleRowCard(
                  title: 'Merchant Code',
                  value: inquiry.merchantCode,
                ),
                // CustomSingleRowCard(
                //   title: 'Deskripsi',
                //   value: inquiry.desc,
                // ),
                CustomSingleRowCard(
                  title: 'Waktu Transaksi',
                  value: time,
                ),
                CustomSingleRowCard(
                  title: 'Nominal',
                  value: 'Rp ' + nominalBelanja,
                ),
                CustomSingleRowCard(
                  title: 'Biaya Admin',
                  value: 'Rp ' + biaya,
                ),
                const SizedBox(
                  height: 16,
                  child: DashLineDivider(
                    color: Color(0xFFB8B8B8),
                  ),
                ),
                CustomSingleRowCard(
                  title: 'Total',
                  value: 'Rp ' + total,
                  valueSize: 18,
                ),
              ],
            ),
            const Spacer(),
            SubmitButton(
              backgroundColor: green,
              text: 'Lanjutkan',
              onPressed: () async => await _c.process(inquiry: inquiry),
            ),
          ],
        ),
      ),
    );
  }
}
