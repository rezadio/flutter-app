import 'package:eidupay/controller/qris/qris_payment_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/qris.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/eidu_saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QrisPaymentPage extends StatefulWidget {
  static final route =
      GetPage(name: '/qris/:id/', page: () => const QrisPaymentPage());
  const QrisPaymentPage({Key? key}) : super(key: key);

  @override
  _QrisPaymentPageState createState() => _QrisPaymentPageState();
}

class _QrisPaymentPageState extends State<QrisPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('BAYAR')),
        body: const _BodyQrisPaymentPage(),
      ),
    );
  }
}

class _BodyQrisPaymentPage extends StatefulWidget {
  const _BodyQrisPaymentPage({Key? key}) : super(key: key);

  @override
  _BodyQrisPaymentPageState createState() => _BodyQrisPaymentPageState();
}

class _BodyQrisPaymentPageState extends State<_BodyQrisPaymentPage> {
  final _getController = Get.put(QrisPaymentController(injector.get()));
  final String qrisString = Get.arguments[0];
  final Qris qris = Get.arguments[1];

  @override
  void initState() {
    super.initState();
    _getController.tipsController.text = '0';
    _getController.amountController.addListener(() {
      final amount = currencyMaskFormatter.magicMask
          .clearMask(_getController.amountController.text);
      if (amount.isNotEmpty) {
        final isValid = (int.parse(amount) >
            num.parse(_getController.balance.value.numericOnly()));
        if (isValid != _getController.isNotEnough.value) {
          _getController.isNotEnough.value = isValid;
        }
      } else {
        final isValid =
            (0 > num.parse(_getController.balance.value.numericOnly()));
        if (isValid != _getController.isNotEnough.value) {
          _getController.isNotEnough.value = isValid;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => EiduSaldoCard(saldo: _getController.balance.value)),
            const SizedBox(height: 30),
            const Text(
              'Account Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: t60.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    qris.nama,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    qris.city,
                    style: TextStyle(
                        color: t80.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            const SizedBox(height: 34),
            Form(
              key: _getController.formKey,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nominal',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _getController.amountController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: _getController.isNotEnough.value
                              ? red
                              : Colors.black),
                      inputFormatters: [currencyMaskFormatter],
                      decoration: underlineInputDecoration.copyWith(
                          hintText: '0',
                          prefixText: 'Rp ',
                          prefixStyle: TextStyle(
                              color: _getController.isNotEnough.value
                                  ? red
                                  : Colors.black),
                          suffixIcon: (_getController.isNotEnough.value &&
                                  _getController.isParentAccount.value)
                              ? TextButton(
                                  onPressed: () {
                                    Get.toNamed(Topup.route.name)?.then(
                                        (value) => _getController.getBalance());
                                  },
                                  child: const Text('Top Up'))
                              : null),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (int.parse(currencyMaskFormatter.magicMask
                                  .clearMask(value)) >
                              num.parse(
                                  _getController.balance.value.numericOnly())) {
                            return 'Saldo tidak cukup';
                          }
                        }
                        if (value != null && value.isEmpty) {
                          return 'Nominal wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Berita',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                        controller: _getController.beritaController,
                        decoration: underlineInputDecoration),
                    const SizedBox(height: 25),
                    const Text(
                      'Tips',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _getController.tipsController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: _getController.isNotEnough.value
                              ? red
                              : Colors.black),
                      inputFormatters: [currencyMaskFormatter],
                      decoration: underlineInputDecoration.copyWith(
                          hintText: '0',
                          prefixText: 'Rp ',
                          prefixStyle: TextStyle(
                              color: _getController.isNotEnough.value
                                  ? red
                                  : Colors.black),
                          suffixIcon: (_getController.isNotEnough.value &&
                                  _getController.isParentAccount.value)
                              ? TextButton(
                                  onPressed: () {
                                    Get.toNamed(Topup.route.name)?.then(
                                        (value) => _getController.getBalance());
                                  },
                                  child: const Text('Top Up'))
                              : null),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Obx(
              () => SubmitButton(
                backgroundColor: green,
                text: 'Lanjutkan',
                onPressed: !(_getController.isNotEnough.value)
                    ? () async => await _getController.process(
                        qris: qris, qrisString: qrisString)
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
