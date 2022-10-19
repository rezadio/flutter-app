import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferToCashPage extends StatefulWidget {
  static final route =
      GetPage(name: '/transfer/to-cash', page: () => TransferToCashPage());
  const TransferToCashPage({Key? key}) : super(key: key);

  @override
  _TransferToCashPageState createState() => _TransferToCashPageState();
}

class _TransferToCashPageState extends State<TransferToCashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer to Cash'),
      ),
      body: _BodyTransferToCashPage(),
    );
  }
}

class _BodyTransferToCashPage extends StatefulWidget {
  const _BodyTransferToCashPage({Key? key}) : super(key: key);

  @override
  _BodyTransferToCashPageState createState() => _BodyTransferToCashPageState();
}

class _BodyTransferToCashPageState extends State<_BodyTransferToCashPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/to_cash.png'),
                ),
              ),
            ),
            SizedBox(height: h(52)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kirim',
                    style: TextStyle(
                        color: green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Uang Tunai'.toUpperCase(),
                    style: const TextStyle(
                        color: blue, fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  SizedBox(height: h(5)),
                  const Flexible(
                    child: Text(
                      'Hanya berlaku untuk pengiriman uang tunai di dalam negeri',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          color: t70,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: h(35),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              shape: CircleBorder(),
                              value: false,
                              onChanged: (value) {}),
                          const Text(
                            'Pengiriman',
                            style: TextStyle(
                                fontSize: 14,
                                color: t70,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
                      Row(
                        children: [
                          Checkbox(
                              shape: CircleBorder(),
                              value: false,
                              onChanged: (value) {}),
                          const Text(
                            'Pembatalan',
                            style: TextStyle(
                                fontSize: 14,
                                color: t70,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: h(40)),
                  SubmitButton(
                    backgroundColor: green,
                    text: 'Continue',
                    onPressed: () {},
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
