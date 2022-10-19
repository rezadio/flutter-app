import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/view/transaction_success_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eidupay/tools.dart';
import 'package:get/get.dart';
import 'package:eidupay/extension.dart';

class PayAmountPage extends StatefulWidget {
  static final route =
      GetPage(name: '/chat/:name/pay', page: () => PayAmountPage());

  const PayAmountPage({Key? key}) : super(key: key);

  @override
  _PayAmountPageState createState() => _PayAmountPageState();
}

class _PayAmountPageState extends State<PayAmountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
      ),
      body: _BodyPayAmountPage(),
    );
  }
}

class _BodyPayAmountPage extends StatefulWidget {
  const _BodyPayAmountPage({Key? key}) : super(key: key);

  @override
  _BodyPayAmountPageState createState() => _BodyPayAmountPageState();
}

class _BodyPayAmountPageState extends State<_BodyPayAmountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: Column(
        children: [
          Container(
            height: 65,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: green.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Balance',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Text(
                  'Rp' + 3000922.amountFormat,
                  style: TextStyle(
                      fontSize: 16, color: green, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: Form(
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(color: t60, fontSize: 14),
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(fontSize: 36),
                        decoration: underlineInputDecoration.copyWith(
                            prefixText: 'Rp',
                            prefixStyle: TextStyle(color: Colors.black)),
                      )
                    ],
                  ),
                  SizedBox(height: h(40)),
                  Column(
                    children: [
                      Text(
                        'Add a Note',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: h(16)),
                      TextFormField(
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                        decoration: underlineInputDecoration.copyWith(
                            hintText: 'Write here..'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SubmitButton(
            text: 'Continue',
            backgroundColor: green,
            onPressed: () {
              Get.offNamed(TransactionSuccessPage.route.name,
                  arguments:
                      PageArgument(title: 'Payment Success', hasButton: false));
            },
          ),
        ],
      ),
    ));
  }
}
