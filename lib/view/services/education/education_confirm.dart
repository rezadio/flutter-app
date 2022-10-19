import 'package:eidupay/controller/services/education/education_confirm_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/education.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_clear_form_field.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EducationConfirm extends StatefulWidget {
  const EducationConfirm({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/services/education/:id/confirm/',
      page: () => const EducationConfirm());

  @override
  _EducationConfirmState createState() => _EducationConfirmState();
}

class _EducationConfirmState extends State<EducationConfirm> {
  final _c = Get.put(EducationConfirmCont(injector.get()));
  final EducationInquiry educationInquiry = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.educationInquiry = educationInquiry;
    _c.setRadioValues(educationInquiry.inquiryListCategory.datas);
  }

  @override
  Widget build(BuildContext context) {
    final dataListCategory = educationInquiry.inquiryListCategory;
    final datas = dataListCategory.datas;

    return Scaffold(
      appBar: AppBar(title: const Text('Edukasi')),
      body: educationInquiry.rc != '04'
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringUtils.toTitleCase(dataListCategory.merchantName),
                    style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.bold,
                        color: green),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey[350] ?? Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No Induk',
                              style: TextStyle(
                                  fontSize: w(14),
                                  fontWeight: FontWeight.bold,
                                  color: t100),
                            ),
                            Text(
                              dataListCategory.customerNumber,
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
                          children: [
                            Text(
                              'Nama',
                              style: TextStyle(
                                  fontSize: w(14),
                                  fontWeight: FontWeight.bold,
                                  color: t100),
                            ),
                            Text(
                              StringUtils.toTitleCase(
                                  dataListCategory.customerName),
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
                          children: [
                            Text(
                              'Kelas / Jur ',
                              style: TextStyle(
                                  fontSize: w(14),
                                  fontWeight: FontWeight.bold,
                                  color: t100),
                            ),
                            Text(
                              dataListCategory.kelas,
                              style: TextStyle(
                                  fontSize: w(14),
                                  fontWeight: FontWeight.w400,
                                  color: t100),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h(20)),
                  const Divider(
                    color: green,
                    height: 20,
                    thickness: 3,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                SizedBox(height: h(10)),
                                Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                          value: _c.listCheck[i],
                                          onChanged: (_) => {
                                                if (datas[i].amount != 0)
                                                  {_c.checklistTap(i, datas[i])}
                                                else
                                                  {
                                                    EiduInfoDialog.showInfoDialog(
                                                        title:
                                                            'Nominal tidak boleh kosong')
                                                  }
                                              }),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                65 /
                                                100,
                                            child: Text(datas[i].billName,
                                                style: TextStyle(
                                                    fontSize: w(14),
                                                    fontWeight: FontWeight.w500,
                                                    color: t100))),
                                        SizedBox(height: h(10)),
                                        datas[i].amount > 0
                                            ? Text(
                                                'Rp. ' +
                                                    (datas[i].amount)
                                                        .amountFormat,
                                                style: TextStyle(
                                                    fontSize: w(14),
                                                    fontWeight: FontWeight.w500,
                                                    color: t100),
                                              )
                                            : Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    65 /
                                                    100,
                                                child: TextFormField(
                                                    initialValue: '',
                                                    style: TextStyle(
                                                        fontSize: w(14),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: t100),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      currencyMaskFormatter
                                                    ],
                                                    validator: (val) {
                                                      if (val!.isEmpty ||
                                                          val == '') {
                                                        return 'Nominal tidak boleh kosong!';
                                                      }
                                                    },
                                                    decoration: underlineInputDecoration.copyWith(
                                                        hintText:
                                                            'Masukan Nominal',
                                                        prefixText: 'Rp. ',
                                                        prefixStyle: TextStyle(
                                                            fontSize: w(14),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: t100)),
                                                    onChanged: (value) => datas[
                                                            datas.indexWhere((element) =>
                                                                element.billCode ==
                                                                datas[i].billCode)] =
                                                        InquiryListCategoryData(
                                                            amount:
                                                                double.parse(value != '' ? StringUtils.stringToNumber(value) : '0'),
                                                            billCode: datas[i].billCode,
                                                            billName: datas[i].billName)),
                                              ),
                                        SizedBox(height: h(10)),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey[350],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: h(20)),
                  const Divider(
                    color: green,
                    height: 20,
                    thickness: 3,
                  ),
                  SizedBox(height: h(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya admin',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w500,
                            color: t100),
                      ),
                      Text(
                        'Rp. ' + (dataListCategory.serviceFee).amountFormat,
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w500,
                            color: t100),
                      ),
                    ],
                  ),
                  SizedBox(height: h(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.bold,
                            color: t100),
                      ),
                      Obx(
                        () => Text(
                          'Rp. ' + (_c.totalFee.value).amountFormat,
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.bold,
                              color: t100),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: h(10)),
                  if (dataListCategory.caraBayar == 'partial')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jumlah Bayar',
                          style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.bold,
                              color: t100),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            onChanged: (val) {
                              if (val == '') {
                                _c.jumBayar.value = 0;
                              } else {
                                _c.jumBayar.value =
                                    int.parse(_c.contJumlah.text);
                              }
                            },
                            controller: _c.contJumlah,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                                hintText: 'Masukkan jumlah '),
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: h(40)),
                  Obx(() => SubmitButton(
                        backgroundColor: green,
                        text: 'Lanjutkan',
                        onPressed: !_c.listCheck.contains(true)
                            ? null
                            : () => _c.continueTap(),
                      )),
                  SizedBox(height: h(40)),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataListCategory.merchantName,
                      style: TextStyle(
                          fontSize: w(14),
                          fontWeight: FontWeight.bold,
                          color: green),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _c.formKey,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey[350] ?? Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'No Induk',
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w600,
                                      color: t70),
                                ),
                                Text(
                                  dataListCategory.customerNumber,
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w700,
                                      color: t90),
                                ),
                              ],
                            ),
                            SizedBox(height: h(10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama',
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w600,
                                      color: t70),
                                ),
                                Text(
                                  StringUtils.toTitleCase(
                                      dataListCategory.customerName),
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w700,
                                      color: t90),
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
                                      fontWeight: FontWeight.w600,
                                      color: t70),
                                ),
                                Text(
                                  dataListCategory.kelas,
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w700,
                                      color: t90),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: t40,
                      height: 20,
                      thickness: 3,
                    ),
                    SizedBox(height: h(20)),
                    CustomTextClearFormField(
                      controller: _c.contNominal,
                      title: 'Nominal',
                      hintText: 'Masukkan Nominal Pembayaran',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val!.isEmpty || val == '') {
                          return 'Nominal Belanja tidak boleh kosong!';
                        }
                      },
                    ),
                    CustomTextClearFormField(
                      controller: _c.contBerita,
                      title: 'Keterangan',
                      hintText: 'Masukkan keterangan',
                      validator: (val) {
                        if (val!.isEmpty || val == '') {
                          return 'Keterangan tidak boleh kosong!';
                        }
                      },
                    ),
                    SizedBox(height: h(40)),
                    SubmitButton(
                      backgroundColor: green,
                      text: 'Lanjutkan',
                      onPressed: () => _c.continueSukaTap(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
