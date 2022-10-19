import 'dart:convert';

import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordCont extends GetxController {
  final Network _network;
  ResetPasswordCont(this._network);

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<dynamic> getNewPin() async {
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'pinBaru': passwordController.text
    };
    final response =
        await _network.post(url: 'eidupay/profile/getNewPin', body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> resetTap() async {
    if (formKey.currentState?.validate() == true) {
      EiduLoadingDialog.showLoadingDialog();
      var res = await getNewPin();
      Get.back();

      if (res['ACK'] != 'OK') {
        await EiduInfoDialog.showInfoDialog(
            title: 'Eidupay', description: res['pesan']);
        return;
      } else {
        await Get.defaultDialog(
          title: '',
          barrierDismissible: false,
          onWillPop: () async {
            Get.back();
            Get.back();
            return true;
          },
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Icon(Icons.check_circle_outlined, size: 85, color: green),
                const SizedBox(height: 20),
                const Text(
                    'Password berhasil dirubah. Anda dapat login menggunaka password yang baru.'),
                const SizedBox(height: 30),
                SubmitButton(
                  backgroundColor: green,
                  text: 'Login',
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                )
              ],
            ),
          ),
        );
        return;
      }
    }
  }
}
