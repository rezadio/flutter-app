import 'package:eidupay/controller/services/sedekah/sedekah_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SedekahPage extends StatefulWidget {
  static final route =
      GetPage(name: '/services/sedekah', page: () => const SedekahPage());

  const SedekahPage({Key? key}) : super(key: key);

  @override
  _SedekahPageState createState() => _SedekahPageState();
}

class _SedekahPageState extends State<SedekahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sedekah')),
      body: const _BodySedekahPage(),
    );
  }
}

class _BodySedekahPage extends StatefulWidget {
  const _BodySedekahPage({Key? key}) : super(key: key);

  @override
  _BodySedekahPageState createState() => _BodySedekahPageState();
}

class _BodySedekahPageState extends State<_BodySedekahPage> {
  final _c = Get.put(SedekahController(injector.get()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => ListView.builder(
          itemCount: _c.dataList.length,
          itemBuilder: (context, index) {
            return _InstitutionWidget(
              imageUrl: _c.dataList[index].merchantLogo ??
                  _c.dataList[index].programLogo ??
                  '',
              institutionName: _c.dataList[index].merchantName,
              onTap: () async {
                EiduLoadingDialog.showLoadingDialog();
                final response =
                    await _c.getListDetail(_c.dataList[index].merchantId);
                Get.back();
                await Get.toNamed(
                        '/services/sedekah/${_c.dataList[index].merchantId}/',
                        arguments: response.dataList)
                    ?.then((value) => _c.getList());
              },
            );
          },
        ),
      ),
    );
  }
}

class _InstitutionWidget extends StatelessWidget {
  final String imageUrl;
  final String institutionName;
  final void Function()? onTap;

  const _InstitutionWidget({
    Key? key,
    required this.imageUrl,
    required this.institutionName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                      child: Image(image: NetworkImage(imageUrl)),
                    ),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        institutionName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
