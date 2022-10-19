import 'package:eidupay/controller/services/education/education_select_payment_method_cont.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class EducationSelectPaymentMethod extends StatelessWidget {
  static final route = GetPage(
      name: '/education_service/payment_method',
      page: () => const EducationSelectPaymentMethod());
  const EducationSelectPaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Metode Pembayaran')),
      body: const _BodyEducationSelectPaymentMethod(),
    );
  }
}

class _BodyEducationSelectPaymentMethod extends StatelessWidget {
  const _BodyEducationSelectPaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _getController = Get.put(EducationSelectPaymentMethodCont());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Metode',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                  itemCount: _getController.paymentMethod.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              Image.asset(
                                _getController.paymentMethod[index],
                                width: MediaQuery.of(context).size.width * 0.25,
                              ),
                            ],
                          ),
                          leading: Obx(
                            () => Radio(
                              groupValue:
                                  _getController.methodSelectedNumber.value,
                              value: index + 1,
                              onChanged: (int? value) {
                                if (value != 0) {
                                  _getController.isMethodSelected.value = true;
                                }
                                if (value != null) {
                                  _getController.methodSelectedNumber.value =
                                      value;
                                }
                              },
                            ),
                          ),
                        ),
                        const Divider(height: 5),
                      ],
                    );
                  }),
            ),
            Obx(
              () => SubmitButton(
                backgroundColor: green,
                text: 'Pilih',
                onPressed: (!_getController.isMethodSelected.value)
                    ? null
                    : () {
                        if (_getController.methodSelectedNumber.value != 1) {
                          EiduInfoDialog.showInfoDialog(title: 'Segera hadir');
                          return;
                        }
                        Get.back(
                            result: _getController.methodSelectedNumber.value);
                      },
              ),
            )
          ],
        ),
      ),
    );
  }
}
