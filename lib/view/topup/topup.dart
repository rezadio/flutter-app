import 'package:eidupay/controller/topup/topup_cont.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Topup extends StatelessWidget {
  const Topup({Key? key}) : super(key: key);
  static final route = GetPage(name: '/topup', page: () => Topup());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(TopupCont());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Topup',
              style: TextStyle(
                fontSize: w(18),
                fontWeight: FontWeight.w500,
              )),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Metode\nTopup',
                style: TextStyle(
                  fontSize: w(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h(30)),
              otherMenu(context,
                  method: 'Bank',
                  clr: green,
                  img: 'assets/images/ico_bank_topup.png',
                  onTap: () => _c.bank()),
              SizedBox(height: h(20)),
              otherMenu(context,
                  method: 'Bank Syariah',
                  clr: darkBlue,
                  img: 'assets/images/ico_bank_topup.png',
                  onTap: () => _c.islamicBank()),
              SizedBox(height: h(20)),
              otherMenu(context,
                  method: 'Debit Langsung',
                  clr: orange1,
                  img: 'assets/images/ico_bank_topup.png',
                  onTap: () => _c.directDebit()),
              SizedBox(height: h(20)),
              otherMenu(context,
                  method: 'Merchant, Partner',
                  clr: lightBlue,
                  img: 'assets/images/ico_topup_merchant.png',
                  onTap: () => _c.merchant()),
              SizedBox(height: h(60)),
            ],
          ),
        )));
  }

  otherMenu(
    BuildContext context, {
    required String method,
    required Color clr,
    required String img,
    VoidCallback? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: w(90),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: clr.withOpacity(0.2)),
          child: Row(
            children: [
              SizedBox(width: h(34)),
              Container(
                padding: EdgeInsets.all(12),
                width: w(45),
                height: w(45),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: clr),
                child: Image.asset(img),
              ),
              SizedBox(width: h(34)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Topup dari',
                    style: TextStyle(
                        fontSize: w(12),
                        fontWeight: FontWeight.w400,
                        color: t90),
                  ),
                  SizedBox(height: h(5)),
                  Text(
                    method,
                    style: TextStyle(
                        fontSize: w(18),
                        fontWeight: FontWeight.w500,
                        color: t100),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
