import 'package:eidupay/controller/services/pdam/pdam_pick_area_cont.dart';
import 'package:eidupay/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PDAMGetArea extends StatelessWidget {
  const PDAMGetArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(PdamGetAreaCont(injector.get()));
    return Scaffold(
        appBar: AppBar(title: const Text('Pilih Area')),
        body: Obx(() {
          return _c.inProgress.value
              ? const Center(child: CircularProgressIndicator())
              : const _ListArea();
        }));
  }
}

class _ListArea extends StatelessWidget {
  const _ListArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.find<PdamGetAreaCont>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Masukkan nama area yang dicari'),
            onChanged: (val) => _c.onSearch(val.toLowerCase()),
          ),
        ),
        Expanded(
          child: Obx(() => ListView.builder(
              itemCount: _c.listAreaFilter.length,
              itemBuilder: (context, i) {
                return Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Text(
                            _c.listAreaFilter[i]['namaOperator'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          onTap: () => _c.areaTap(_c.listAreaFilter[i]),
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 1)
                      ],
                    ));
              })),
        ),
      ],
    );
  }
}
