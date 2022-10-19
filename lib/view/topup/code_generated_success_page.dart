import 'dart:io';
import 'dart:typed_data';

import 'package:eidupay/controller/home_cont.dart';
import 'package:eidupay/controller/topup/code_generated_success_cont.dart';
import 'package:eidupay/model/topup_merchant.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:eidupay/extension.dart';

class CodeGeneratedSuccessPage extends StatefulWidget {
  static final route = GetPage(
      name: '/topup-merchant/success', page: () => CodeGeneratedSuccessPage());
  const CodeGeneratedSuccessPage({Key? key}) : super(key: key);

  @override
  _CodeGeneratedSuccessPageState createState() =>
      _CodeGeneratedSuccessPageState();
}

class _CodeGeneratedSuccessPageState extends State<CodeGeneratedSuccessPage> {
  final _c = Get.put(CodeGeneratedSuccessCont());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Merchant'),
        automaticallyImplyLeading: false,
        actions: [
          MaterialButton(
            shape: CircleBorder(),
            child: Image(
              height: 24,
              image: AssetImage('assets/images/share.png'),
            ),
            onPressed: () async {
              await _c.screenshotController
                  .capture(delay: const Duration(milliseconds: 10))
                  .then((Uint8List? image) async {
                if (image != null) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/image.png').create();
                  await imagePath.writeAsBytes(image);

                  /// Share Plugin
                  await Share.shareFiles([imagePath.path]);
                }
              });
            },
          )
        ],
      ),
      body: _BodyCodeGeneratedSuccessPage(),
    );
  }
}

class _BodyCodeGeneratedSuccessPage extends StatefulWidget {
  const _BodyCodeGeneratedSuccessPage({Key? key}) : super(key: key);

  @override
  _BodyCodeGeneratedSuccessPageState createState() =>
      _BodyCodeGeneratedSuccessPageState();
}

class _BodyCodeGeneratedSuccessPageState
    extends State<_BodyCodeGeneratedSuccessPage> {
  final _c = Get.put(CodeGeneratedSuccessCont());
  final _homeController = Get.find<HomeCont>();
  final MerchantPaymentCode paymentCode = Get.arguments[0];
  final Denom denom = Get.arguments[1];
  final String merchantName = Get.arguments[2];
  final getInstruction = <String>[];
  late List<String> merchantLogo;

  @override
  void initState() {
    super.initState();
    getInstruction.assignAll(_c.getInstruction(merchantName));
    merchantLogo = _c.logoUrl(merchantName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Screenshot(
                controller: _c.screenshotController,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: Image.asset('assets/images/logo_eidupay.png'),
                      ),
                      SizedBox(height: h(10)),
                      Flexible(
                        child: Image(
                          height: 145,
                          image: AssetImage(
                              'assets/images/success_generate_code.png'),
                        ),
                      ),
                      SizedBox(height: h(20)),
                      Text(
                        'Kode Token Berhasil dibuat',
                        style: TextStyle(
                            color: t70,
                            fontSize: w(16),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: h(25)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keterangan:',
                            style: TextStyle(
                              fontSize: w(14),
                              fontWeight: FontWeight.w400,
                              color: t60,
                            ),
                          ),
                          SizedBox(height: h(3)),
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFFCFBFC),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Kode Token',
                                      style: TextStyle(
                                          fontSize: w(16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: h(5)),
                                    Text(
                                      paymentCode.billNumber,
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
                          SizedBox(width: 8),
                          // CustomSingleRowCard(
                          //   title: 'Jumlah',
                          //   value: 'Rp ${paymentCode.amount.amountFormat}',
                          // ),
                          // CustomSingleRowCard(
                          //   title: 'Biaya Admin',
                          //   value: 'Rp 0',
                          // ),
                          // SizedBox(
                          //   height: h(16),
                          //   child: DashLineDivider(color: Color(0xFFB8B8B8)),
                          // ),
                          CustomSingleRowCard(
                            title: 'Nominal',
                            value: 'Rp. ${paymentCode.amount.amountFormat}',
                            valueColor: green,
                            valueSize: 18,
                          ),
                          SizedBox(
                            height: h(16),
                            child: DashLineDivider(color: Color(0xFFB8B8B8)),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 12,
                            children: merchantLogo
                                .map(
                                  (img) => Image.asset(
                                    img,
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    height: 40,
                                    alignment: Alignment.centerLeft,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallDivider(),
                  SizedBox(height: h(24)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kode Token',
                        style: TextStyle(
                            fontSize: w(16),
                            fontWeight: FontWeight.w400,
                            color: t90),
                      ),
                      SizedBox(height: h(8)),
                      Text(
                        '${paymentCode.billNumber}',
                        style: TextStyle(
                            fontSize: w(24),
                            fontWeight: FontWeight.w500,
                            color: t90),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Ikuti petunjuk berikut ini:',
                    style: TextStyle(
                        fontSize: w(14),
                        fontWeight: FontWeight.bold,
                        color: t90),
                  ),
                  SizedBox(height: h(27)),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getInstruction.length,
                      itemBuilder: (context, index) => _InstructionContainer(
                          index: index, instructions: getInstruction)),
                ],
              ),
            ),

            // DashLineDivider(),
            // SizedBox(height: h(27)),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.warning,
            //       color: orange1,
            //       size: 20,
            //     ),
            //     Text(
            //       ' Caution',
            //       style: TextStyle(
            //           fontSize: w(14),
            //           fontWeight: FontWeight.w500,
            //           color: t100),
            //     ),
            //   ],
            // ),
            // SizedBox(height: h(8)),
            // Container(
            //   width: double.infinity,
            //   //height: 200,
            //   child: Text(
            //     'Arcu amet non congue pellentesque posuere nisl purus. Neque ornare felis pharetra ac sit. Metus sagittis id neque imperdiet commodo tortor sapien in.',
            //     style: TextStyle(
            //         fontSize: w(12),
            //         fontWeight: FontWeight.w400,
            //         color: t60),
            //   ),
            // ),
            // SizedBox(height: h(32)),
            // Text(
            //   'How to do ?',
            //   style: TextStyle(
            //       fontSize: w(14),
            //       fontWeight: FontWeight.w500,
            //       color: t90),
            // ),
            // SizedBox(height: h(32)),
            // Container(
            //   width: double.infinity,
            //   height: w(173),
            //   child: ClipRRect(
            //     child: Image.asset('assets/images/tmp_video1.png'),
            //   ),
            // ),
            // SizedBox(height: h(20)),
            // SubmitButton(
            //   backgroundColor: green,
            //   text: 'Back to home',
            //   onPressed: () {
            //     Get.off(Home());
            //   },
            // ),
            // SizedBox(height: h(60))
            Padding(
              padding: EdgeInsets.all(30),
              child: SubmitButton(
                backgroundColor: green,
                text: 'Kembali ke Menu Utama',
                onPressed: () => _c.toHome(),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _maxBalance() {
    if (_homeController.idVerifyStatus.value == '1') {
      return 'Rp. ${10000000.amountFormat}';
    } else {
      return 'Rp. ${2000000.amountFormat}';
    }
  }

  String _maxTopUp() {
    if (_homeController.idVerifyStatus.value == '1') {
      final max =
          10000000 - int.parse(_homeController.balance.value.numericOnly());
      return max.amountFormat;
    } else {
      final max =
          2000000 - int.parse(_homeController.balance.value.numericOnly());
      // int.parse('0');
      return max.amountFormat;
    }
  }
}

class _InstructionContainer extends StatelessWidget {
  final int index;
  final List<String> instructions;

  const _InstructionContainer(
      {Key? key, required this.index, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              child: Text(
                'Step ${index + 1}',
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w300, color: t60),
              ),
            ),
            SizedBox(width: 20),
            Flexible(
              child: Text(
                instructions[index],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t90),
              ),
            ),
          ],
        ),
        if (index + 1 < instructions.length) SizedBox(height: h(16))
      ],
    );
  }
}
