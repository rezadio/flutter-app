import 'package:eidupay/controller/komunitas_list_cont.dart';
import 'package:eidupay/model/komunitas.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class KomunitasList extends StatefulWidget {
  const KomunitasList({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/signup/komunitas-list', page: () => const KomunitasList());

  @override
  _KomunitasListState createState() => _KomunitasListState();
}

class _KomunitasListState extends State<KomunitasList> {
  final _c = Get.put(KomunitasListCont());
  final List<DataKomunitas> listKomunitas = Get.arguments;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _c.dtKomunitas = listKomunitas;
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Daftar Komunitas')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Masukkan ID Komunitas',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (val) => _c.onSearchChange(val),
              ),
              const SizedBox(height: 20),
              Obx(() => _c.filteredListKomunitas.isEmpty
                  ? const Expanded(
                      child: Center(child: Text('Tidak ada data.')))
                  : Expanded(
                      child: Obx(() => ListView.builder(
                          controller: scrollController,
                          itemCount: _c.filteredListKomunitas.length,
                          itemBuilder: (context, i) {
                            final komunitas = _c.filteredListKomunitas[i];
                            return GestureDetector(
                              onTap: () {
                                Get.back(result: komunitas);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${komunitas.communityId} - ${komunitas.communityName}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    komunitas.communityAddress,
                                    style: const TextStyle(
                                        fontSize: 16, color: t70),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'PIC : ' + komunitas.picName,
                                    style: const TextStyle(
                                        fontSize: 16, color: blue),
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(thickness: 1, color: t70),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            );
                          })),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
