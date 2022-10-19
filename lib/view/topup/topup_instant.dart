import 'package:eidupay/controller/topup/topup_instant_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/eidu_saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TopupInstant extends StatefulWidget {
  const TopupInstant({Key? key, this.withCard = true}) : super(key: key);
  static final route =
      GetPage(name: '/topup-instant', page: () => const TopupInstant());

  final bool withCard;

  @override
  _TopupInstantState createState() => _TopupInstantState();
}

class _TopupInstantState extends State<TopupInstant> {
  final _c = Get.put(TopupInstantCont(injector.get()));

  @override
  void initState() {
    super.initState();
    _c.amountController.addListener(() {
      final amount =
          currencyMaskFormatter.magicMask.clearMask(_c.amountController.text);
      if (amount.isNotEmpty) {
        final isValid =
            (int.parse(amount) > num.parse(_c.balance.value.numericOnly()));
        if (isValid != _c.isNotEnough.value) {
          _c.isNotEnough.value = isValid;
        }
      } else {
        final isValid = (0 > num.parse(_c.balance.value.numericOnly()));
        if (isValid != _c.isNotEnough.value) {
          _c.isNotEnough.value = isValid;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Topup')),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Obx(() => EiduSaldoCard(saldo: _c.balance.value)),
              SizedBox(height: w(86)),
              Text(
                'Nominal',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
              ),
              Form(
                key: _c.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: TextFormField(
                    controller: _c.amountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [currencyMaskFormatter],
                    style: TextStyle(fontSize: w(36)),
                    decoration: underlineInputDecoration.copyWith(
                      prefixText: 'Rp ',
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (num.parse(currencyMaskFormatter.magicMask
                                .clearMask(_c.amountController.text)) <
                            10000) {
                          return 'Minimal Rp 10,000';
                        }
                      }
                      if (value != null && value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: w(41)),
              widget.withCard
                  ? GestureDetector(
                      onTap: () => _c.selectCard(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kartu Terpilih',
                            style: TextStyle(
                                fontSize: w(14),
                                fontWeight: FontWeight.w400,
                                color: t60),
                          ),
                          const SizedBox(width: 16),
                          Obx(
                            () => Text(
                              _c.cardNum.value,
                              style: TextStyle(
                                  fontSize: w(14),
                                  fontWeight: FontWeight.w500,
                                  color: darkBlue),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_drop_down, color: darkBlue)
                        ],
                      ),
                    )
                  : Container(),
              Obx(
                () => (_c.cardList.isNotEmpty)
                    ? const Spacer()
                    : Expanded(
                        child: Center(
                            child: Text(
                          'Belum ada kartu ditambahkan',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t60),
                        )),
                      ),
              ),
              Obx(
                () => SubmitButton(
                  text: (_c.cardList.isEmpty)
                      ? 'Tambah Kartu'
                      : (_c.isCardSelected.value == false)
                          ? 'Pilih Kartu'
                          : 'Lanjut',
                  onPressed: _c.cardList.isEmpty
                      ? () => _c.addNewCard()
                      : _c.isCardSelected.value == false
                          ? () => _c.selectCard()
                          : (_c.amountController.text.isEmpty ||
                                  num.parse(currencyMaskFormatter.magicMask
                                          .clearMask(
                                              _c.amountController.text)) <
                                      10000)
                              ? null
                              : () => _c.continueTap(widget.withCard),
                  backgroundColor: green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
