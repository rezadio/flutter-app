import 'package:eidupay/controller/topup/merchan_partner_cont.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class MerchantPartner extends StatelessWidget {
  const MerchantPartner({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/merchantPartner', page: () => MerchantPartner());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(MerchantPartnerCont());
    return Scaffold(
      appBar: AppBar(title: Text('Merchant & Partner')),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: _c.merchantList.length,
                itemBuilder: (context, i) {
                  final merchant = _c.merchantList[i];
                  final imgList = merchant['img'] as List<String>;
                  return _CustomMerchantCard(
                      onTap: () => _c.merchantTap(merchant),
                      child: Wrap(
                        spacing: 12,
                        children: imgList
                            .map(
                              (img) => Image.asset(
                                img,
                                width: MediaQuery.of(context).size.width * 0.22,
                                height: 40,
                                alignment: Alignment.centerLeft,
                              ),
                            )
                            .toList(),
                      ));
                })),
      ),
    );
  }
}

class _CustomMerchantCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const _CustomMerchantCard({Key? key, required this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: green.withOpacity(0.1)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
