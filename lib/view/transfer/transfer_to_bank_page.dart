import 'package:dropdown_search/dropdown_search.dart';
import 'package:eidupay/controller/transfer/transfer_to_bank_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/bank.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/eidu_saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TransferToBankPage extends StatefulWidget {
  static final route = GetPage(
      name: '/transfer/to-bank', page: () => const TransferToBankPage());

  const TransferToBankPage({Key? key}) : super(key: key);

  @override
  _TransferToBankPageState createState() => _TransferToBankPageState();
}

class _TransferToBankPageState extends State<TransferToBankPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Transfer ke Bank')),
          body: const _BodyTransferToBankPage()),
    );
  }
}

class _BodyTransferToBankPage extends StatefulWidget {
  const _BodyTransferToBankPage({Key? key}) : super(key: key);

  @override
  _BodyTransferToBankPageState createState() => _BodyTransferToBankPageState();
}

class _BodyTransferToBankPageState extends State<_BodyTransferToBankPage> {
  final _getController = Get.put(TransferToBankController(injector.get()));

  @override
  void initState() {
    super.initState();
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
        padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => EiduSaldoCard(saldo: _getController.balance.value)),
            SizedBox(height: h(30)),
            const Text('Transfer Detail',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 21, left: 5, right: 5),
              child: Form(
                key: _getController.formKey,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bank',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: h(15)),
                      DropdownSearch<DataBank>(
                        mode: Mode.DIALOG,
                        showSearchBox: true,
                        searchDelay: const Duration(milliseconds: 1000),
                        isFilteredOnline: true,
                        items: _getController.listBank.value,
                        dropdownSearchDecoration: underlineInputDecoration
                            .copyWith(hintText: 'Masukkan nama bank'),
                        // selectedItem: (_getController.bankName.value.isNotEmpty)
                        //     ? _getController.bankName.value
                        //     : null,
                        itemAsString: (value) {
                          if (value != null) return value.namaBank;
                          return '';
                        },
                        onFind: (value) async {
                          if (value != null && value.isNotEmpty) {
                            final banks = await _getController.getBank(value);
                            return banks;
                          }
                          return [];
                        },
                        onChanged: (value) {
                          if (value != null && value.idBank.isNotEmpty) {
                            _getController.bankName.value = value.namaBank;
                            _getController.selectedBank = value;
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Bank wajib diisi';
                          }
                        },
                      ),
                      SizedBox(height: h(40)),
                      const Text('Nomor Rekening',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        maxLength: 30,
                        controller: _getController.accountNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: underlineInputDecoration.copyWith(
                            hintText: 'Masukkan nomor akun',
                            suffixIcon: GestureDetector(
                              child: const Icon(Icons.clear),
                              onTap: () => _getController.clear(),
                            )),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Nomor rekenening wajib diisi';
                          }
                        },
                      ),
                      const Text('Nominal',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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
                            suffixIcon: _getController.isNotEnough.value
                                ? TextButton(
                                    onPressed: () {
                                      Get.toNamed(Topup.route.name)?.then(
                                          (value) =>
                                              _getController.getBalance());
                                    },
                                    child: const Text('Top Up'))
                                : null),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (num.parse(currencyMaskFormatter.magicMask
                                    .clearMask(
                                        _getController.amountController.text)) <
                                10000) {
                              return 'Minimal Rp 10,000';
                            }
                            if (int.parse(currencyMaskFormatter.magicMask
                                    .clearMask(value)) >
                                num.parse(_getController.balance.value
                                    .numericOnly())) {
                              return 'Saldo tidak cukup';
                            }
                          }
                          if (value != null && value.isEmpty) {
                            return 'Nominal wajib diisi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: h(24)),
                      CustomTextFormField(
                        controller: _getController.noteController,
                        title: 'Berita Transfer',
                        hintText: 'Masukkan berita transfer',
                        inputFormatters: [UpperCaseTextFormatter()],
                        maxLength: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _getController.isChecked.value,
                            onChanged: (val) {
                              _getController.isChecked.value =
                                  !_getController.isChecked.value;
                            },
                          ),
                          GestureDetector(
                              onTap: () {
                                _getController.isChecked.value =
                                    !_getController.isChecked.value;
                              },
                              child: Text('Simpan untuk digunakan lagi',
                                  style:
                                      TextStyle(fontSize: w(14), color: t70))),
                        ],
                      ),
                      if (_getController.isChecked.value == true)
                        TextFormField(
                          controller: _getController.favoriteController,
                          decoration: underlineInputDecoration.copyWith(
                              hintText: 'Masukkan nama favorit'),
                        ),
                      SizedBox(height: h(30)),
                      SubmitButton(
                          backgroundColor: green,
                          text: 'Lanjut',
                          onPressed: () async =>
                              await _getController.process()),
                      const SizedBox(height: 40),
                      Text(
                        'Metode Tersimpan',
                        style: TextStyle(
                            fontSize: w(16), fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 18),
                      if (_getController.savedName.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _getController.savedName.length,
                          itemBuilder: (context, index) {
                            final splittedText = _getController
                                .savedName[index].noPelanggan
                                .split('-');
                            final bank = splittedText[0];
                            final noRek = splittedText[1];
                            final aliasName =
                                _getController.savedName[index].aliasName;
                            return _SavedCard(
                              bank: bank,
                              name: aliasName,
                              noRek: noRek,
                              onTap: () {
                                _getController.bankName.value = bank;
                                _getController.accountNumberController.text =
                                    noRek;
                                _getController.selectedBank =
                                    _getController.listBank.value.where(
                                        (element) => element.namaBank == bank);
                              },
                            );
                          },
                        )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SavedCard extends StatelessWidget {
  final String bank;
  final String name;
  final String noRek;
  final void Function()? onTap;
  const _SavedCard(
      {Key? key,
      required this.bank,
      required this.name,
      required this.noRek,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: const Color(0xFFEAEAEA))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bank,
                    style: TextStyle(
                        color: t80,
                        fontWeight: FontWeight.w300,
                        fontSize: w(12)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: t90,
                            fontSize: w(14),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        noRek,
                        style: const TextStyle(
                            color: t90,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
