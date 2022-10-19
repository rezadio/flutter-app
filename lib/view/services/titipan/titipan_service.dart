import 'package:eidupay/controller/services/titipan/titipan_service_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/view/services/titipan/titipan_input_siswa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TitipanService extends StatelessWidget {
  static final route =
      GetPage(name: '/services/titipan', page: () => const TitipanService());
  const TitipanService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Setoran')),
        body: const _BodyTitipanService(),
      ),
    );
  }
}

class _BodyTitipanService extends StatefulWidget {
  const _BodyTitipanService({Key? key}) : super(key: key);

  @override
  _BodyTitipanServiceState createState() => _BodyTitipanServiceState();
}

class _BodyTitipanServiceState extends State<_BodyTitipanService>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(TitipanServiceController(injector.get()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => _c.dataCategory.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TabBar(
                    controller: _c.tabController,
                    tabs: _c.dataCategory
                        .map((element) => Tab(
                              text: element.categoryName,
                            ))
                        .toList(growable: false),
                  ),
                  Expanded(
                      child: TabBarView(
                          controller: _c.tabController,
                          children: _buildTabBody(_c.savedList)))
                ],
              ),
      ),
    );
  }

  List<Widget> _buildTabBody(List dataSave) {
    final tabBody = <Widget>[];
    final tabLength = _c.tabController.length;
    for (var i = 0; i < tabLength; i++) {
      tabBody.add(_TabBody(dataSave: _c.savedList));
    }
    return tabBody;
  }
}

class _TabBody extends StatefulWidget {
  const _TabBody({Key? key, required this.dataSave}) : super(key: key);

  final List dataSave;

  @override
  __TabBodyState createState() => __TabBodyState();
}

class __TabBodyState extends State<_TabBody> {
  final _c = Get.find<TitipanServiceController>();
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cari',
            style: TextStyle(
                fontSize: w(16), fontWeight: FontWeight.w500, color: t100),
          ),
          TextFormField(
              controller: _c.searchController,
              decoration: underlineInputDecoration.copyWith(
                  hintText: 'Masukkan nama yang akan di cari',
                  hintStyle: const TextStyle(fontSize: 16, color: t70),
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () => _c.clear(),
                  )),
              onChanged: (val) => _c.search(val)),
          SizedBox(height: h(24)),
          Obx(
            () => (_c.filteredDataListCategory.isEmpty)
                ? const Text('Tidak ada data.')
                : Expanded(
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        _c.loadMore();
                        _refreshController.loadComplete();
                      },
                      child: ListView.builder(
                        itemCount: _c.listLength.value,
                        itemBuilder: (context, index) {
                          return _ListPendidikanWidget(
                            onTap: () => Get.toNamed(
                                TitipanInputSiswa.route.name,
                                arguments: _c.filteredDataListCategory[index]),
                            imageUrl: _c.filteredDataListCategory[index].logo,
                            institutionName:
                                _c.filteredDataListCategory[index].edukasiName,
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}

class _ListPendidikanWidget extends StatelessWidget {
  final String? imageUrl;
  final String institutionName;
  final void Function()? onTap;

  const _ListPendidikanWidget({
    Key? key,
    this.imageUrl,
    required this.institutionName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _logo = imageUrl;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: w(50),
                        width: w(50),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: green.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: (_logo != null && _logo.isNotEmpty)
                            ? Image(image: NetworkImage(_logo))
                            : null,
                      ),
                      const SizedBox(width: 24),
                      Flexible(
                        child: Text(institutionName),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          const Divider(height: 25),
        ],
      ),
    );
  }
}
