import 'package:eidupay/controller/sub_account/sub_accunt_list_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/sub_account/add_sub_account_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/extension.dart';

class SubAccountListPage extends StatefulWidget {
  static final route = GetPage(
      name: '/profile/sub-account/', page: () => const SubAccountListPage());

  const SubAccountListPage({Key? key}) : super(key: key);

  @override
  _SubAccountListPageState createState() => _SubAccountListPageState();
}

class _SubAccountListPageState extends State<SubAccountListPage> {
  final _c = Get.put(SubAccountListCont(injector.get()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Account'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Get.toNamed(AddSubAccountPage.route.name))
        ],
      ),
      body: Obx(() {
        return _c.inProgress.value
            ? const Center(child: CircularProgressIndicator())
            : const _BodySubAccountListPage();
      }),
    );
  }
}

class _BodySubAccountListPage extends StatefulWidget {
  const _BodySubAccountListPage({Key? key}) : super(key: key);

  @override
  _BodySubAccountListPageState createState() => _BodySubAccountListPageState();
}

class _BodySubAccountListPageState extends State<_BodySubAccountListPage> {
  final _c = Get.find<SubAccountListCont>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => (_c.listSubAcc.isEmpty)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum ada Sub Account yang ditambahkan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SubmitButton(
                        text: 'Tambah',
                        backgroundColor: green,
                        onPressed: () =>
                            Get.toNamed(AddSubAccountPage.route.name),
                      ),
                    )
                  ],
                ),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                itemCount: _c.listSubAcc.length,
                itemBuilder: (context, i) {
                  final listSubAcc = _c.listSubAcc[i];
                  return Column(
                    children: [
                      _SubAccountCard(
                        photoUrl: 'assets/images/avatar1.png',
                        name: listSubAcc.name,
                        transaction: 50,
                        amount: int.parse(listSubAcc.used.numericOnly()),
                        dailyLimit:
                            int.parse(listSubAcc.limitDaily.numericOnly()),
                        limitValue: int.parse(listSubAcc.limit.numericOnly()),
                        lockFund: listSubAcc.lockFund,
                        onTap: () => _c.toExtDetail(listSubAcc.idExt),
                      ),
                      const Divider(height: 40),
                    ],
                  );
                })));
  }
}

class _SubAccountCard extends StatelessWidget {
  final String photoUrl;
  final String name;
  final num amount;
  final int transaction;
  final int dailyLimit;
  final int limitValue;
  final bool lockFund;
  final void Function()? onTap;

  const _SubAccountCard({
    Key? key,
    required this.photoUrl,
    required this.name,
    required this.amount,
    required this.transaction,
    required this.dailyLimit,
    required this.limitValue,
    required this.lockFund,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final divide = (amount == 0 && limitValue == 0) ? 0 : amount / limitValue;
    // String _getText(double value) {
    //   final fullName = name.split(' ');
    //   if (value > 0.9) {
    //     return '😍 Great, your limit for ${fullName.first} is on track';
    //   } else {
    //     return '😭 ${fullName.first} reach his/her limit';
    //   }
    // }

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage(photoUrl)),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: n800,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        if (dailyLimit != 0)
                          Text(
                            'Daily Limit Rp. ${(dailyLimit).amountFormat}',
                            style: const TextStyle(
                                color: t70,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        lockFund == 't'
                            ? const Text(
                                'Lock Found',
                                style: TextStyle(
                                    color: t70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Terpakai Rp. ' + amount.amountFormat,
                      style: const TextStyle(
                          color: n800,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Limit Rp. ${(limitValue).amountFormat}',
                      style: const TextStyle(
                          color: t70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            LinearProgressIndicator(
              semanticsLabel: 'limit indicator',
              color: divide <= 0.5
                  ? Colors.green
                  : divide < 0.9
                      ? orange1
                      : Colors.red,
              value: divide.toDouble(),
              backgroundColor: divide <= 0.5
                  ? Colors.green.withOpacity(0.1)
                  : divide < 0.9
                      ? orange1.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
            ),
            // Text(
            //   _getText(divide.toDouble()),
            //   style: const TextStyle(
            //       color: t70, fontSize: 12, fontWeight: FontWeight.bold),
            // )
          ],
        ),
      ),
    );
  }
}
