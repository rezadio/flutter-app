import 'package:eidupay/controller/topup/manage_card_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class ManageCard extends StatelessWidget {
  const ManageCard({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/topup-instant/manage-card', page: () => const ManageCard());
  @override
  Widget build(BuildContext context) {
    final _c = Get.put(ManageCardCont(injector.get()));
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kartu')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kartu Tersimpan',
                  style: TextStyle(
                      fontSize: w(16), fontWeight: FontWeight.w400, color: t90),
                ),
                GestureDetector(
                    onTap: () => _c.addNewCard(),
                    child: Text(
                      '+ Tambah Kartu',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w500,
                          color: green),
                    )),
              ],
            ),
            const SizedBox(height: 15),
            Obx(
              () => Expanded(
                child: (_c.cardList.isEmpty)
                    ? const Center(
                        child: Text('Belum ada kartu yang tersimpan'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: _c.cardList.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () => _c.cardTap(i, _c.cardList[i].id),
                            child: Obx(() => Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                height: w(170),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _c.cardSelectedIndex.contains(i),
                                      onChanged: (value) =>
                                          _c.cardTap(i, _c.cardList[i].id),
                                    ),
                                    SizedBox(width: w(8)),
                                    Expanded(
                                      child: _CustomCard(
                                        logoUrl:
                                            _c.getLogo(_c.cardList[i].cardNum),
                                        cardNum: _c.formatCardNum(
                                            _c.cardList[i].cardNum),
                                        name: _c.cardList[i].nameHolder,
                                        expDate: _c.formatExpDate(
                                            _c.cardList[i].expiredDate),
                                      ),
                                    )
                                  ],
                                ))),
                          );
                        }),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Obx(
                  () => Expanded(
                    flex: 1,
                    child: SubmitButton(
                      backgroundColor: Colors.red,
                      text: 'Hapus',
                      onPressed: (_c.cardSelectedId.value == 0)
                          ? null
                          : () => _c.removeCard(_c.cardSelectedId.value),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Obx(
                  () => Expanded(
                    flex: 2,
                    child: SubmitButton(
                      backgroundColor: green,
                      text: 'Pilih',
                      onPressed: (_c.cardSelectedId.value == 0)
                          ? null
                          : () => _c.continueTap(_c.cardSelectedId.value),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final String logoUrl;
  final String cardNum;
  final String name;
  final String expDate;

  const _CustomCard(
      {Key? key,
      this.logoUrl = '',
      required this.cardNum,
      required this.name,
      required this.expDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: const BoxDecoration(
          color: green,
          image: DecorationImage(
              image: AssetImage('assets/images/card_bg.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            SizedBox(
                height: 35,
                width: 50,
                child: (logoUrl.isNotEmpty)
                    ? Image.asset(
                        logoUrl,
                        alignment: Alignment.topLeft,
                      )
                    : null)
          ],
        ),
        Expanded(child: Container()),
        Text(
          cardNum,
          style: TextStyle(
              fontSize: w(12), fontWeight: FontWeight.w700, color: t10),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: w(12), fontWeight: FontWeight.w400, color: t10),
            ),
            Text(
              expDate,
              style: TextStyle(
                  fontSize: w(12), fontWeight: FontWeight.w400, color: t10),
            ),
          ],
        ),
      ]),
    );
  }
}
