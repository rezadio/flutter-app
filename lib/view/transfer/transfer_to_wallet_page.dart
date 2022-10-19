import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/controller/transfer/transfer_to_wallet_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/eidu_saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';

class TransferToWalletPage extends StatefulWidget {
  static final route = GetPage(
      name: '/transfer/to-wallet', page: () => const TransferToWalletPage());
  const TransferToWalletPage({Key? key}) : super(key: key);

  @override
  _TransferToWalletPageState createState() => _TransferToWalletPageState();
}

class _TransferToWalletPageState extends State<TransferToWalletPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Transfer Ke Eidupay')),
          body: const _BodyTransferToWalletPage()),
    );
  }
}

class _BodyTransferToWalletPage extends StatefulWidget {
  const _BodyTransferToWalletPage({Key? key}) : super(key: key);

  @override
  _BodyTransferToWalletPageState createState() =>
      _BodyTransferToWalletPageState();
}

class _BodyTransferToWalletPageState extends State<_BodyTransferToWalletPage> {
  final _getController = Get.put(TransferToWalletController(injector.get()));

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
    PhoneContact? _phoneContact;

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
            SizedBox(height: h(24)),
            Form(
              key: _getController.formKey,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: _getController.mobileController,
                      maxLength: 13,
                      title: 'Nomor Handphone',
                      hintText: 'Masukkan Nomor Handphone',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      suffixIcon: Container(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.clear),
                              onTap: () => _getController.clear(),
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.account_box,
                                size: 30,
                                color: blue,
                              ),
                              onTap: () async {
                                PhoneContact contact =
                                    await FlutterContactPicker
                                        .pickPhoneContact();

                                setState(() {
                                  _phoneContact = contact;
                                  _getController.mobileController.text =
                                     StringUtils.stringToFixPhoneNumber(_phoneContact!.phoneNumber!.number!);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty || val == '') {
                          return 'Nomor Handphone tidak boleh kosong!';
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
                                        (value) => _getController.getBalance());
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
                    SizedBox(height: h(24)),
                    CustomTextFormField(
                      controller: _getController.messageController,
                      title: 'Berita Transfer',
                      hintText: 'Masukkan berita transfer',
                      maxLength: 20,
                    ),
                    SizedBox(height: h(20)),
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
                              style: TextStyle(fontSize: w(14), color: t70)),
                        ),
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
                        onPressed: () async => await _getController.process()),
                    const SizedBox(height: 40),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tersimpan',
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
                                  final aliasName =
                                      _getController.savedName[index].aliasName;
                                  final noPelanggan = _getController
                                      .savedName[index].noPelanggan;
                                  return _FavoriteCard(
                                    aliasName: aliasName,
                                    noPelanggan: noPelanggan,
                                    onTap: () {
                                      _getController.mobileController.text =
                                          noPelanggan;
                                    },
                                  );
                                })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
              style: TextStyle(
                  color: t90, fontSize: w(14), fontWeight: FontWeight.w400),
            ),
            Text(
              noPelanggan,
              style: const TextStyle(
                  color: t90, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
