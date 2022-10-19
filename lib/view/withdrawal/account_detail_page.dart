import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/pin_verification_page.dart';
import 'package:eidupay/widget/bottom_sheet/eidu_confirmation_bottom_sheet.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/extension.dart';

class AccountDetailPage extends StatefulWidget {
  static final route = GetPage(
    name: '/withdrawal/:user',
    page: () => const AccountDetailPage(),
  );

  const AccountDetailPage({Key? key}) : super(key: key);

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  @override
  Widget build(BuildContext context) {
    String? _name(String? text) =>
        text?.split('-').map((e) => e.capitalizeFirst).join(' ');

    return Scaffold(
      appBar:
          AppBar(title: Text(_name(Get.parameters['user']) ?? 'Unknown User')),
      body: const _BodyAccountDetailPage(),
    );
  }
}

class _BodyAccountDetailPage extends StatefulWidget {
  const _BodyAccountDetailPage({Key? key}) : super(key: key);

  @override
  _BodyAccountDetailPageState createState() => _BodyAccountDetailPageState();
}

class _BodyAccountDetailPageState extends State<_BodyAccountDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _streetNumberController = TextEditingController();
  final _rtController = TextEditingController();
  final _rwController = TextEditingController();
  final _villageController = TextEditingController();
  final _regencyController = TextEditingController();
  final _districtController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(left: 29.0, right: 29, bottom: 45),
          children: [
            _CustomTextFormField(
              controller: _nameController,
              title: 'Nama Lengkap',
              hintText: 'Masukkan Nama Lengkap',
            ),
            _CustomDropdownFormField(
              title: 'Pilih ID',
              hint: 'Pilih ID',
              items: const [
                DropdownMenuItem(
                  child: Text('KTP'),
                  value: 'KTP',
                ),
                DropdownMenuItem(
                  child: Text('SIM'),
                  value: 'SIM',
                ),
              ],
              onPressed: (value) {},
            ),
            _CustomTextFormField(
              controller: _idNumberController,
              title: 'Nomor ID',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: 'Masukkan Nomor ID',
            ),
            _CustomTextFormField(
              controller: _streetNumberController,
              title: 'No.',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: 'Masukkan No.',
            ),
            _CustomTextFormField(
              controller: _rtController,
              title: 'RT',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: 'Masukkan RT',
            ),
            _CustomTextFormField(
              controller: _rwController,
              title: 'RW',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: 'Masukkan RW',
            ),
            _CustomTextFormField(
              controller: _provinceController,
              title: 'Provinsi',
              hintText: 'Enter Province',
            ),
            _CustomTextFormField(
              controller: _regencyController,
              title: 'Daerah',
              hintText: 'Masukkan Nama Daerah',
            ),
            _CustomTextFormField(
              controller: _districtController,
              title: 'Distrik',
              hintText: 'Masukkan Distrik',
            ),
            _CustomTextFormField(
              controller: _villageController,
              title: 'Desa',
              hintText: 'Masukkan Nama Desa',
            ),
            _CustomTextFormField(
              controller: _postCodeController,
              title: 'Kode Pos',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: 'Masukkan Kode Pos',
            ),
            const SizedBox(height: 16),
            SubmitButton(
              backgroundColor: green,
              text: 'Lanjutkan',
              onPressed: () {
                EiduConfirmationBottomSheet.showBottomSheet(
                  title: 'Konfirmasi Pembayaran',
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tujuan',
                        style: TextStyle(
                          fontSize: w(14),
                          fontWeight: FontWeight.w400,
                          color: t60,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 58,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFCFBFC),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              height: 40,
                              image:
                                  AssetImage('assets/images/sample_pict.png'),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Smitty Werben',
                                  style: TextStyle(
                                      fontSize: w(16),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '123 123 1234',
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w400,
                                      color: t80),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CustomSingleRowCard(
                        title: 'Tipe ID',
                        value: 'Lorem Ipsum',
                      ),
                      const CustomSingleRowCard(
                        title: 'Nomor ID',
                        value: 'ABC123456789',
                      ),
                      CustomSingleRowCard(
                        title: 'Jumlah',
                        value: 'Rp ' + 250000.amountFormat,
                      ),
                      CustomSingleRowCard(
                        title: 'On-Site Fees',
                        value: 'Rp ' + 25000.amountFormat,
                      ),
                      const SizedBox(
                        height: 16,
                        child: DashLineDivider(
                          color: Color(0xFFB8B8B8),
                        ),
                      ),
                      CustomSingleRowCard(
                        title: 'Jumlah Pembayaran',
                        value: 'Rp ' + 275000.amountFormat,
                        valueColor: green,
                        valueSize: 18,
                      ),
                    ],
                  ),
                  color: green,
                  secondaryColor: green,
                  secondButtonText: 'Bayar',
                  secondButtonOnPressed: () {
                    Get.back();
                    Get.toNamed(PinVerificationPage.route.name,
                        arguments: PageArgument(title: 'Penarikan'));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idNumberController.dispose();
    _streetNumberController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _villageController.dispose();
    _regencyController.dispose();
    _districtController.dispose();
    _provinceController.dispose();
    _postCodeController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}

class _CustomDropdownFormField extends StatelessWidget {
  final String title;
  final String? hint;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String? value)? onPressed;

  const _CustomDropdownFormField({
    Key? key,
    required this.title,
    this.hint,
    this.items,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          DropdownButtonFormField(
            items: items,
            icon: const Icon(Icons.expand_more),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(color: Color(0xFFD5D5DC), fontSize: 14),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD5D5DC)))),
            onChanged: onPressed,
          ),
        ],
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  const _CustomTextFormField({
    Key? key,
    required this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: underlineInputDecoration.copyWith(hintText: hintText),
          ),
        ],
      ),
    );
  }
}
