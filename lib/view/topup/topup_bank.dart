import 'package:eidupay/controller/topup/topup_bank_cont.dart';
import 'package:eidupay/controller/topup/topup_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TopupBank extends StatelessWidget {
  const TopupBank({Key? key}) : super(key: key);
  static final route = GetPage(name: '/topupBank', page: () => TopupBank());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(TopupBankCont());
    final _topupCont = Get.find<TopupCont>();

    return Scaffold(
      appBar: AppBar(title: Text('Bank')),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  mainAxisExtent: MediaQuery.of(context).size.width * 0.3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  crossAxisCount: 4,
                ),
                itemCount: _topupCont.bankList.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () => _c.bankInfo(_topupCont.bankList[i]),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: w(63),
                          height: w(63),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: green.withOpacity(0.1)),
                          child:
                              Image.asset(_topupCont.bankList[i]['icon'] ?? ''),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          _topupCont.bankList[i]['name'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: w(12),
                              fontWeight: FontWeight.w500,
                              color: t90),
                        ),
                      )
                    ],
                  );
                })),
      ),
    );
  }
}
