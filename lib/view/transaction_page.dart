import 'package:eidupay/controller/transaction_controller.dart';
import 'package:eidupay/model/mutasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionPage extends StatelessWidget {
  static final route =
      GetPage(name: '/transaction', page: () => const TransactionPage());
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi')),
      body: const _BodyTransactionPage(),
    );
  }
}

class _BodyTransactionPage extends StatelessWidget {
  const _BodyTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<TransactionController>();
    return SafeArea(
      child: Obx(
        () => (!_c.isLoaded.value)
            ? const Center(child: CircularProgressIndicator())
            : SmartRefresher(
                controller: _c.refreshController,
                enablePullUp: true,
                onRefresh: _c.refreshService,
                onLoading: _c.loadMore,
                child: (_c.datas.isEmpty)
                    ? const Center(child: Text('Belum ada transaksi'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: _c.datas.length,
                        itemBuilder: (context, index) {
                          final data = _c.datas[index];
                          return _TransactionCard(
                            data: data,
                            onTap: () => _c.transactionCardTapped(data),
                          );
                        }),
              ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Mutasi data;
  final VoidCallback? onTap;

  const _TransactionCard({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('d MMM y, h:m', 'in_ID').format(data.timeStamp);
    final type = dtUser['tipe'];

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 2.0))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: data.statusTrx == 'SUKSES'
                                ? Colors.green
                                : data.statusTrx == 'PENDING'
                                    ? orange1
                                    : red,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: Center(
                            child: Text(data.statusTrx,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Text(data.tipeTransaksi,
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ((data.typeTrx == 'WITHDRAW') ? '-' : '+') +
                                  ' Rp ' +
                                  data.total,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 16,
                                  // color: t80,
                                  color: (data.typeTrx == 'WITHDRAW')
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF000119).withAlpha(75),
                            ),
                          ),
                          if (type != 'extended')
                            Text(
                              'Rp ' + data.lastBalance,
                              style: const TextStyle(fontSize: 14, color: t80),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
