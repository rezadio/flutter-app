import 'package:eidupay/controller/services/games/game_list_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameListPage extends StatefulWidget {
  const GameListPage({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/services/game-list', page: () => const GameListPage());

  @override
  _GameListPageState createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _c = Get.put(GameListCont(injector.get()));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topup Games dan Voucher')),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'GAMES'),
              Tab(text: 'VOUCHER'),
            ],
          ),
          Obx(() => _c.inProgress.value
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TabBarView(
                      controller: _tabController,
                      children: const [_GameList(), _GameVoucher()],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}

class _GameList extends StatelessWidget {
  const _GameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<GameListCont>();
    return _c.listGames.isEmpty
        ? const Center(child: Text('Tidak ada Game tersedia.'))
        : GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 0.6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30),
            itemCount: _c.listGames.length,
            itemBuilder: (context, i) {
              final game = _c.listGames[i];
              return GestureDetector(
                onTap: () => _c.gameTap(game),
                child: Column(
                  children: [
                    SizedBox(height: 100, child: Image.network(game.iconUrl)),
                    const SizedBox(height: 10),
                    Text(game.productName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(game.categoryName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: t70))
                  ],
                ),
              );
            });
  }
}

class _GameVoucher extends StatelessWidget {
  const _GameVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<GameListCont>();
    return _c.listVoucher.isEmpty
        ? const Center(child: Text('Tidak ada Voucher tersedia.'))
        : GridView.builder(
            padding: const EdgeInsets.only(top: 10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 0.57,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30),
            itemCount: _c.listVoucher.length,
            itemBuilder: (context, i) {
              final voucher = _c.listVoucher[i];
              return GestureDetector(
                onTap: () => _c.voucherTap(voucher),
                child: Column(
                  children: [
                    SizedBox(
                        height: 100, child: Image.network(voucher.iconUrl)),
                    const SizedBox(height: 10),
                    Text(voucher.voucherName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            });
  }
}
