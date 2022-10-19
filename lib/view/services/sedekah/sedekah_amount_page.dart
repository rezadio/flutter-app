import 'package:eidupay/controller/services/sedekah/sedekah_amount_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/common_mod.dart';
import 'package:eidupay/model/sedekah.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SedekahAmountPage extends StatefulWidget {
  static final route = GetPage(
      name: '/services/sedekah/:id/amount/',
      page: () => const SedekahAmountPage());

  const SedekahAmountPage({Key? key}) : super(key: key);

  @override
  _SedekahAmountPageState createState() => _SedekahAmountPageState();
}

class _SedekahAmountPageState extends State<SedekahAmountPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sedekah')),
        body: const _BodySedekahAmountPage(),
      ),
    );
  }
}

class _BodySedekahAmountPage extends StatefulWidget {
  const _BodySedekahAmountPage({Key? key}) : super(key: key);

  @override
  _BodySedekahAmountPageState createState() => _BodySedekahAmountPageState();
}

class _BodySedekahAmountPageState extends State<_BodySedekahAmountPage> {
  final _getController = Get.put(SedekahAmountController(injector.get()));
  final DataSedekah dataSedekah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _getController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nominal',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _getController.amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [currencyMaskFormatter],
                    decoration: underlineInputDecoration.copyWith(
                        hintText: '0', prefixText: 'Rp '),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Nominal wajib diisi';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: h(30)),
            Text(
              'Sumber Dana',
              style: TextStyle(
                  fontSize: w(16), fontWeight: FontWeight.w500, color: t100),
            ),
            SizedBox(height: h(10)),
            SizedBox(
              height: 60,
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  items: sumberDana,
                  value: 'Saldo Eidupay',
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const Spacer(),
            SubmitButton(
              text: 'Lanjutkan',
              backgroundColor: green,
              onPressed: () async =>
                  await _getController.process(dataSedekah: dataSedekah),
            )
          ],
        ),
      ),
    );
  }
}
