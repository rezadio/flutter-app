import 'package:eidupay/controller/services/titipan/titipan_confirmation_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/inquiry_tabungan.dart';
import 'package:eidupay/view/topup/topup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TitipanConfirmationPage extends StatefulWidget {
  const TitipanConfirmationPage({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/sevices/titipan/input-siswa/:id',
      page: () => const TitipanConfirmationPage());

  @override
  _TitipanConfirmationPageState createState() =>
      _TitipanConfirmationPageState();
}

class _TitipanConfirmationPageState extends State<TitipanConfirmationPage> {
  final _c = Get.put(TitipanConfirmationController(injector.get()));
  final InquiryTabungan inquiryTabungan = Get.arguments;

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
    return Scaffold(
      appBar: AppBar(title: const Text('Titipan')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[350] ?? Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No Induk',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.bold,
                              color: t80),
                        ),
                        Text(
                          inquiryTabungan.dataListCategory.customerNumber,
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t100),
                        ),
                      ],
                    ),
                    SizedBox(height: h(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.bold,
                              color: t80),
                        ),
                        Expanded(
                          child: Text(
                            inquiryTabungan.dataListCategory.customerName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: w(14),
                                fontWeight: FontWeight.w400,
                                color: t100),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kelas / Jur ',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.bold,
                              color: t80),
                        ),
                        Text(
                          inquiryTabungan.dataListCategory.kelas,
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t100),
                        ),
                      ],
                    ),
                    SizedBox(height: h(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sekolah',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.bold,
                              color: t80),
                        ),
                        Expanded(
                          child: Text(
                            inquiryTabungan.dataListCategory.merchantName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: w(14),
                                fontWeight: FontWeight.w400,
                                color: t100),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(20)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _c.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nominal',
                      style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextFormField(
                      controller: _c.amountController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: _c.isNotEnough.value ? red : Colors.black),
                      inputFormatters: [currencyMaskFormatter],
                      decoration: underlineInputDecoration.copyWith(
                          hintText: '0',
                          prefixText: 'Rp ',
                          prefixStyle: TextStyle(
                              color: _c.isNotEnough.value ? red : Colors.black),
                          suffixIcon: _c.isNotEnough.value
                              ? TextButton(
                                  onPressed: () {
                                    Get.toNamed(Topup.route.name)
                                        ?.then((value) => _c.getBalance());
                                  },
                                  child: const Text('Top Up'))
                              : null),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (num.parse(currencyMaskFormatter.magicMask
                                  .clearMask(_c.amountController.text)) <
                              10000) {
                            return 'Minimal Rp 10,000';
                          }
                          if (int.parse(currencyMaskFormatter.magicMask
                                  .clearMask(value)) >
                              num.parse(_c.balance.value.numericOnly())) {
                            return 'Saldo tidak cukup';
                          }
                        }
                        if (value != null && value.isEmpty) {
                          return 'Nominal wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SubmitButton(
              text: 'Lanjut',
              onPressed: () => _c.process(inquiryTabungan),
              backgroundColor: green,
            ),
          ],
        ),
      ),
    );
  }
}
