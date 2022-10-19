import 'package:eidupay/controller/services/games/game_detail_cont.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/game.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/game_detail', page: () => const GameDetailPage());

  @override
  _GameDetailPageState createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final _c = Get.put(GameDetailCont(injector.get()));
  final Game game = Get.arguments[0];
  final GameDetailResponse gameDetail = Get.arguments[1];

  @override
  void initState() {
    super.initState();
    _c.gameDetail = gameDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Detail')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: w(100),
                  height: w(100),
                  child: Image.network(game.iconUrl),
                ),
                SizedBox(width: w(10)),
                SizedBox(
                  width: w(200),
                  child: Text(
                    _c.gameDetail.game.nameGame,
                    style: TextStyle(fontSize: w(16)),
                  ),
                )
              ],
            ),
            SizedBox(height: h(20)),
            const DashLineDivider(),
            SizedBox(height: h(10)),
            Obx(() => _c.hasUserId.value
                ? TextFormField(
                    controller: _c.contUserId,
                    decoration: const InputDecoration(hintText: 'User ID'),
                  )
                : const SizedBox.shrink()),
            SizedBox(height: h(10)),
            Obx(() => _c.hasZondeId.value
                ? TextFormField(
                    controller: _c.contZoneId,
                    decoration: const InputDecoration(hintText: 'Zone ID'),
                  )
                : const SizedBox.shrink()),
            SizedBox(height: h(10)),
            Obx(() => _c.hasUserName.value
                ? TextFormField(
                    controller: _c.contUserName,
                    decoration: const InputDecoration(hintText: 'User Name'),
                  )
                : const SizedBox.shrink()),
            SizedBox(height: h(10)),
            Obx(() => _c.hasServer.value
                ? TextFormField(
                    controller: _c.contServer,
                    decoration: const InputDecoration(hintText: 'Server'),
                  )
                : const SizedBox.shrink()),
            SizedBox(height: h(40)),
            Expanded(
              child: ListView.builder(
                itemCount: _c.gameDetail.denom.length,
                itemBuilder: (context, i) {
                  final denom = _c.gameDetail.denom[i];
                  String amount = denom.amount;
                  amount = amount.substring(0, amount.length - 3);
                  return GestureDetector(
                    onTap: () => _c.gameDetailTap(denom),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    50 /
                                    100,
                                child: Text(
                                  denom.nameDenom,
                                  style: TextStyle(fontSize: w(14)),
                                )),
                            Text(
                              'Rp. ' + (int.parse(amount)).amountFormat,
                              style: TextStyle(
                                  fontSize: w(14), fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 2),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
