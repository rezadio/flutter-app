import 'package:eidupay/controller/services/education/education_service_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/education.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EducationService extends StatefulWidget {
  const EducationService({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/services/education/', page: () => const EducationService());

  @override
  _EducationServiceState createState() => _EducationServiceState();
}

class _EducationServiceState extends State<EducationService>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(EducationServiceCont(injector.get()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edukasi')),
        body: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _c.listKategori.isEmpty
                  ? const SizedBox.shrink()
                  : TabBar(
                      controller: _c.tabController,
                      tabs: _c.listKategori
                          .map((element) => Tab(text: element.categoryName))
                          .toList(),
                    ),
              Expanded(
                child: _c.inProgress.value
                    ? const Center(child: CircularProgressIndicator())
                    : TabBarView(
                        controller: _c.tabController,
                        children: _c.listKategori
                            .map((element) => _EducationServiceBody(
                                dataSave: _c.listSavedAll,
                                dataList: _c.listDataFilter))
                            .toList()),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _EducationServiceBody extends StatelessWidget {
  _EducationServiceBody(
      {Key? key, required this.dataSave, required this.dataList})
      : super(key: key);

  final List dataSave;
  final List<DataListCategory> dataList;
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<EducationServiceCont>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h(24)),
          Text(
            'Cari',
            style: TextStyle(
                fontSize: w(16), fontWeight: FontWeight.w500, color: t100),
          ),
          TextFormField(
              controller: _c.contCari,
              decoration: InputDecoration(
                  hintText: 'Masukkan nama yang akan di cari',
                  hintStyle: TextStyle(
                      fontSize: w(16), fontWeight: FontWeight.w400, color: t70),
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () => _c.clear(),
                  )),
              onChanged: (val) => _c.search(val)),
          SizedBox(height: h(24)),
          // Text(
          //   'Transaksi Terakhir',
          //   style: TextStyle(
          //       fontSize: w(16), fontWeight: FontWeight.w500, color: t100),
          // ),
          // const SizedBox(height: 10),
          // Container(
          //   width: double.infinity,
          //   height: 90,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       border: Border.all(color: Colors.grey)),
          //   child: dataSave.isNotEmpty
          //       ? ListView(
          //           scrollDirection: Axis.horizontal,
          //           children: dataSave
          //               .asMap()
          //               .map((i, element) => MapEntry(
          //                   i,
          //                   Padding(
          //                     padding:
          //                         const EdgeInsets.symmetric(horizontal: 20),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         GestureDetector(
          //                           onTap: () => _c.savedListonTap(dataSave[i]),
          //                           child: Container(
          //                             width: w(50),
          //                             height: w(50),
          //                             decoration: BoxDecoration(
          //                                 borderRadius:
          //                                     BorderRadius.circular(30),
          //                                 color: green.withOpacity(0.2)),
          //                             child: dataSave[i]['merchantLogo']
          //                                         .toString() !=
          //                                     'null'
          //                                 ? Image.network(
          //                                     dataSave[i]['merchantLogo'])
          //                                 : Container(),
          //                           ),
          //                         ),
          //                         const SizedBox(height: 5),
          //                         Text(dataSave[i]['merchantName']
          //                                 .toString()
          //                                 .substring(0, 8) +
          //                             '...'),
          //                       ],
          //                     ),
          //                   )))
          //               .values
          //               .toList())
          //       : const Center(
          //           child: Text(
          //           'Tidak ada data.',
          //           style: TextStyle(color: t70),
          //         )),
          // ),
          const SizedBox(height: 10),
          Obx(
            () => (_c.listDataFilter.isEmpty)
                ? const Text('Tidak ada data.')
                : Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        _c.loadMore();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _c.listLength.value,
                          itemBuilder: (context, index) {
                            final data = dataList[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: GestureDetector(
                                  onTap: () => _c.educationTap(data),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: w(50),
                                            height: w(50),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: green.withOpacity(0.2)),
                                            child: data.logo != null
                                                ? Image.network(data.logo!)
                                                : Container(),
                                          ),
                                          SizedBox(width: w(10)),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  60 /
                                                  100,
                                              child: Text(data.edukasiName)),
                                          Expanded(child: Container()),
                                          const Icon(Icons.arrow_forward_ios)
                                        ],
                                      ),
                                      SizedBox(height: h(15)),
                                      Divider(
                                          color: Colors.grey[350], thickness: 1)
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
