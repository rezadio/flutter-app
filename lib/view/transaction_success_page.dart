import 'dart:io';
import 'dart:typed_data';

import 'package:eidupay/controller/transaction_success_cont.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/view/sub_account/sub_home_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_single_row_card.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:eidupay/tools.dart';
import 'package:screenshot/screenshot.dart';

class TransactionSuccessPage extends StatefulWidget {
  static final route = GetPage(
      name: '/transaction-success', page: () => const TransactionSuccessPage());

  const TransactionSuccessPage({Key? key}) : super(key: key);

  @override
  _TransactionSuccessPageState createState() => _TransactionSuccessPageState();
}

class _TransactionSuccessPageState extends State<TransactionSuccessPage> {
  PageArgument argument = Get.arguments;
  final _c = Get.put(TransactionSuccessCont());
  final type = dtUser['tipe'];
  // Future<bool> _onWillPop() async {
  //   return  : false;

  // (await showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Are you sure?'),
  //         content: const Text('Do you want to exit an App'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
  //             child: const Text('No'),
  //           ),
  //           TextButton(
  //             onPressed: () => (type == 'extended')
  //                 ? Get.offAllNamed(SubHomePage.route.name)
  //                 : Get.offAllNamed(Home.route.name), // <-- SEE HERE
  //             child: const Text('Yes'),
  //           ),
  //         ],
  //       ),
  //     )) ??
  //     false;
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ignore: unawaited_futures
        type == 'extended'
            ? Get.offAllNamed(SubHomePage.route.name)
            : Get.offAllNamed(Home.route.name);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(argument.title),
          automaticallyImplyLeading: false,
          actions: [
            MaterialButton(
              shape: const CircleBorder(),
              child: const Image(
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
        body: const _BodyTransactionSuccessPage(),
      ),
    );
  }
}

class _BodyTransactionSuccessPage extends StatefulWidget {
  const _BodyTransactionSuccessPage({Key? key}) : super(key: key);

  @override
  _BodyTransactionSuccessPageState createState() =>
      _BodyTransactionSuccessPageState();
}

class _BodyTransactionSuccessPageState
    extends State<_BodyTransactionSuccessPage> {
  PageArgument argument = Get.arguments;
  final _c = Get.put(TransactionSuccessCont());
  final type = dtUser['tipe'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Screenshot(
            controller: _c.screenshotController,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Image.asset('assets/images/logo_eidupay.png'),
                  ),
                  SizedBox(height: h(10)),
                  const Flexible(
                    child: Image(
                      height: 145,
                      image: AssetImage(
                          'assets/images/withdrawal_complete_image.png'),
                    ),
                  ),
                  SizedBox(height: h(20)),
                  Text(
                    argument.subtitle ?? '',
                    style: TextStyle(
                        color: t70,
                        fontSize: w(16),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: h(10)),
                  Text(
                    argument.description ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h(20)),
                  argument.trxId != ''
                      ? Text(
                          'Transaksi ID',
                          style: TextStyle(
                              color: t70,
                              fontSize: w(16),
                              fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  SizedBox(height: h(10)),
                  Text(
                    argument.trxId ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: t70,
                        fontSize: w(14),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: h(25)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keterangan :',
                        style: TextStyle(
                          fontSize: w(14),
                          fontWeight: FontWeight.w400,
                          color: t60,
                        ),
                      ),
                      SizedBox(height: h(3)),
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFCFBFC),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                argument.ket1 ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: w(12),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: h(5)),
                              Text(
                                argument.ket2 ?? '',
                                style: TextStyle(
                                    fontSize: w(12),
                                    fontWeight: FontWeight.w400,
                                    color: t80),
                              ),
                              SizedBox(height: h(5)),
                              InkWell(
                                child: Row(
                                  children: [
                                    Text(
                                      argument.ket3 ?? '',
                                      style: TextStyle(
                                          fontSize: w(12),
                                          fontWeight: FontWeight.w400,
                                          color: t80),
                                    ),
                                    if (argument.ket3 != null &&
                                        argument.ket3!.contains('Token'))
                                      const Icon(
                                        Icons.content_copy,
                                        size: 17,
                                        color: Colors.black45,
                                      ),
                                  ],
                                ),
                                onTap: () {
                                  if (argument.ket3!.contains('Token')) {
                                    Clipboard.setData(ClipboardData(
                                        text: argument.ket3
                                            .toString()
                                            .substring(15)));
                                    Fluttertoast.showToast(
                                        msg: 'Token Berhasil Disalin',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomSingleRowCard(
                        title: 'Jumlah',
                        value: argument.nominal ?? 'Rp. 0',
                      ),
                      CustomSingleRowCard(
                        title: 'Biaya Admin',
                        value: argument.biayaAdmin ?? 'Rp. 0',
                      ),
                      SizedBox(
                        height: h(16),
                        child: const DashLineDivider(color: Color(0xFFB8B8B8)),
                      ),
                      CustomSingleRowCard(
                        title: 'Total',
                        value: argument.total ?? 'Rp. 0',
                        valueColor: green,
                        valueSize: 18,
                      ),
                      SizedBox(height: h(30)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (argument.hasButton == true)
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: SubmitButton(
              backgroundColor: green,
              text: 'Kembali ke Menu Utama',
              onPressed: () => (type == 'extended')
                  ? Get.offAllNamed(SubHomePage.route.name)
                  : Get.offAllNamed(Home.route.name),
            ),
          )
      ],
    );
  }
}
