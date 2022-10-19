import 'package:eidupay/controller/transfer/transfer_controller.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/qris/qris_scan_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferPage extends StatefulWidget {
  static final route =
      GetPage(name: '/transfer/', page: () => const TransferPage());

  const TransferPage({Key? key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: const _BodyTransferPage(),
    );
  }
}

class _BodyTransferPage extends StatefulWidget {
  const _BodyTransferPage({Key? key}) : super(key: key);

  @override
  _BodyTransferPageState createState() => _BodyTransferPageState();
}

class _BodyTransferPageState extends State<_BodyTransferPage> {
  final _getController = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transfer \nkemana?',
                    style: TextStyle(
                        fontSize: w(24), fontWeight: FontWeight.bold)),
                MaterialButton(
                  height: 65,
                  color: green.withOpacity(0.2),
                  elevation: 0,
                  highlightElevation: 1,
                  shape: const CircleBorder(),
                  onPressed: () {
                    Get.toNamed(QrisScanPage.route.name);
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: green),
                    child: const Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('assets/images/scan.png'),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                _CustomCard(
                  color: green,
                  text: 'Eidupay',
                  icon: const Image(
                      image: AssetImage('assets/images/wallet_outlined.png')),
                  onPressed: () => _getController.toWalletTap(),
                ),
                const SizedBox(height: 20),
                _CustomCard(
                  color: blue,
                  text: 'Bank',
                  icon: const Image(
                      image: AssetImage('assets/images/ico_bank_topup.png')),
                  onPressed: () => _getController.toBankTap(),
                ),
                const SizedBox(height: 20),
                _CustomCard(
                  color: orange1,
                  text: 'e-Money',
                  icon: const Image(
                      image: AssetImage('assets/images/e_money.png')),
                  onPressed: () => _getController.toEMoneyTap(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final Color color;
  final String text;
  final Widget icon;
  final VoidCallback? onPressed;

  const _CustomCard({
    Key? key,
    required this.color,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: Row(
          children: [
            SizedBox(width: w(28)),
            Container(
                height: 45,
                width: 45,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: icon),
            SizedBox(width: w(38)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Transfer ke',
                    style: TextStyle(
                        fontSize: w(12), fontWeight: FontWeight.w400)),
                Text(text,
                    style:
                        TextStyle(fontSize: w(18), fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
