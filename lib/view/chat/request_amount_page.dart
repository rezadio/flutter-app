import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RequestAmountPage extends StatefulWidget {
  static final route =
      GetPage(name: '/chat/:name/request', page: () => RequestAmountPage());

  const RequestAmountPage({Key? key}) : super(key: key);

  @override
  _RequestAmountPageState createState() => _RequestAmountPageState();
}

class _RequestAmountPageState extends State<RequestAmountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request')),
      body: _BodyRequestAmountPage(),
    );
  }
}

class _BodyRequestAmountPage extends StatefulWidget {
  const _BodyRequestAmountPage({Key? key}) : super(key: key);

  @override
  _BodyRequestAmountPageState createState() => _BodyRequestAmountPageState();
}

class _BodyRequestAmountPageState extends State<_BodyRequestAmountPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: Column(
        children: [
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
            onPressed: () {},
            backgroundColor: green,
          ),
        ],
      ),
    );
  }
}
