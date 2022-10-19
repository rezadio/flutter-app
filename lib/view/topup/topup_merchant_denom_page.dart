import 'package:eidupay/controller/topup/topup_merchant_denom_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TopupMerchantDenomPage extends StatefulWidget {
  static final route = GetPage(
      name: '/topup-merchant', page: () => const TopupMerchantDenomPage());
  const TopupMerchantDenomPage({Key? key}) : super(key: key);

  @override
  _TopupMerchantDenomPageState createState() => _TopupMerchantDenomPageState();
}

class _TopupMerchantDenomPageState extends State<TopupMerchantDenomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Topup Merchant')),
      body: const _BodyTopupMerchantDenomPage(),
    );
  }
}

class _BodyTopupMerchantDenomPage extends StatefulWidget {
  const _BodyTopupMerchantDenomPage({Key? key}) : super(key: key);

  @override
  _BodyTopupMerchantDenomPageState createState() =>
      _BodyTopupMerchantDenomPageState();
}

class _BodyTopupMerchantDenomPageState
    extends State<_BodyTopupMerchantDenomPage> {
  final _getController = Get.put(TopupMerchantDenomController(injector.get()));
  final String biller = Get.arguments;

  @override
  void initState() {
    super.initState();
    _getController.biller = biller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 30.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: h(20)),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              width: double.infinity,
              height: 64,
              decoration: const BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saldo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Obx(
                    () => Text(
                      'Rp ' + _getController.balance.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Text('Nominal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(vertical: h(24)),
                  child: (_getController.denoms.isEmpty)
                      ? const Text('Kosong')
                      : ListView.builder(
                          itemCount: _getController.denoms.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => _DenomWidget(
                                nominal: _getController.denoms[index].nominal,
                                hargaCetak:
                                    _getController.denoms[index].hargaCetak,
                                isSelected: _getController.denomSelected
                                    .contains(_getController.denoms[index]),
                                onTap: () {
                                  if (_getController.denomSelected.isEmpty) {
                                    _getController.denomSelected
                                        .add(_getController.denoms[index]);
                                    _getController.isDenomSelected.value = true;
                                  } else {
                                    _getController.denomSelected.clear();
                                    _getController.denomSelected
                                        .add(_getController.denoms[index]);
                                    _getController.isDenomSelected.value = true;
                                  }
                                },
                              ),
                            );
                          }),
                ),
              ),
            ),
            Obx(
              () => SubmitButton(
                backgroundColor: green,
                text: 'Lanjutkan',
                onPressed: (!_getController.isDenomSelected.value)
                    ? null
                    : () => _getController.process(
                          denom: _getController.denomSelected.first,
                        ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DenomWidget extends StatelessWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String nominal;
  final String hargaCetak;

  const _DenomWidget({
    Key? key,
    this.isSelected = false,
    this.onTap,
    required this.nominal,
    required this.hargaCetak,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
            color: isSelected ? green.withOpacity(0.2) : Colors.transparent,
            border: const Border(bottom: BorderSide(color: t40))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nominal,
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t100),
                ),
                Text(
                  hargaCetak,
                  style: TextStyle(
                      fontSize: w(16),
                      fontWeight: FontWeight.w400,
                      color: t100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
