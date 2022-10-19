import 'package:eidupay/controller/services/games/voucher_detail_cont.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/game.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoucherDetailPage extends StatefulWidget {
  const VoucherDetailPage({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/voucher-detail', page: () => const VoucherDetailPage());

  @override
  _VoucherDetailPageState createState() => _VoucherDetailPageState();
}

class _VoucherDetailPageState extends State<VoucherDetailPage> {
  final _c = Get.put(VoucherDetailCont(injector.get()));
  final VoucherDetail voucherDetail = Get.arguments[0];
  final String iconUrl = Get.arguments[1];

  @override
  void initState() {
    super.initState();
    _c.voucherDetail = voucherDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voucher Game Detail')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: w(100),
                  height: w(100),
                  child: Image.network(iconUrl),
                ),
                SizedBox(width: w(10)),
                SizedBox(
                  width: w(200),
                  child: Text(
                    voucherDetail.voucherName,
                    style: TextStyle(fontSize: w(16)),
                  ),
                )
              ],
            ),
            SizedBox(height: h(20)),
            const DashLineDivider(),
            SizedBox(height: h(50)),
            Expanded(
              child: ListView.builder(
                itemCount: voucherDetail.denom.length,
                itemBuilder: (context, i) {
                  final denom = voucherDetail.denom[i];
                  String amount = denom.denominationAmount;
                  amount = amount.substring(0, amount.length - 3);
                  return GestureDetector(
                    onTap: () => _c.voucherDetaiTap(denom),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    50 /
                                    100,
                                child: Text(
                                  denom.denominationName,
                                  style: TextStyle(fontSize: w(14)),
                                )),
                            Text(
                              'Rp. ' + int.parse(amount).amountFormat,
                              style: TextStyle(
                                  fontSize: w(14), fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 2),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
