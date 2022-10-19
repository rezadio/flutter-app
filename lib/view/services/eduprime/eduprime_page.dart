import 'package:eidupay/controller/services/eduprime/eduprime_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EduprimePage extends StatefulWidget {
  static final route =
      GetPage(name: '/services/eduprime', page: () => const EduprimePage());

  const EduprimePage({Key? key}) : super(key: key);

  @override
  _EduprimePageState createState() => _EduprimePageState();
}

class _EduprimePageState extends State<EduprimePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Eduprime')),
        body: const _BodyEduprimePage(),
      ),
    );
  }
}

class _BodyEduprimePage extends StatefulWidget {
  const _BodyEduprimePage({Key? key}) : super(key: key);

  @override
  _BodyEduprimePageState createState() => _BodyEduprimePageState();
}

class _BodyEduprimePageState extends State<_BodyEduprimePage> {
  final _getController = Get.put(EduprimeController(injector.get()));
  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _getController.getRecentTrx(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _getController.formKey,
            child: CustomTextFormField(
              controller: _getController.usernameController,
              title: 'Username Eduprime',
              hintText: 'Masukkan di sini',
              suffixIcon: GestureDetector(
                child: const Icon(Icons.clear),
                onTap: () => _getController.clear(),
              ),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
              },
            ),
          ),
          SizedBox(height: h(20)),
          SubmitButton(
            text: 'Lanjutkan',
            backgroundColor: green,
            onPressed: () async => _getController.continueTap(),
          ),
          SizedBox(height: h(50)),
          const Text('Transaksi Terakhir',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Divider(height: h(35)),
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              onRefresh: () async {
                await _getController.getRecentTrx(Get.arguments);
                refreshController.refreshCompleted();
              },
              child: Obx(
                () => (_getController.recentTrx.isEmpty)
                    ? const Center(child: Text('Tidak ada data.'))
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _getController.recentTrx.length,
                        itemBuilder: (context, index) {
                          final recentTrx = _getController.recentTrx[index];
                          return RecentTransactionWidget(
                              title: 'Paket',
                              id: recentTrx.noHpTujuan ??
                                  recentTrx.noRekTujuan ??
                                  '',
                              date: recentTrx.timeStamp,
                              price: 'Rp ${recentTrx.total}');
                        },
                      ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
