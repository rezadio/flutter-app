import 'dart:convert';

import 'package:eidupay/network.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/login.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:eidupay/widget/dialog/eidu_loading_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ini untuk reset pin di halaman profile
// BUKAN UNTUK FORGET PASSWORD DI HALAMAN LOGIN

class ResetPinCont extends GetxController {
  final Network _network;
  ResetPinCont(this._network);

  TextEditingController contPinLama = TextEditingController();
  TextEditingController contPinBaru = TextEditingController();
  TextEditingController contKonfirmPinBaru = TextEditingController();

  var hidePinLama = true.obs;
  var hidePinBaru = true.obs;
  var hideKonfirmasiPinBaru = true.obs;

  final formKey = GlobalKey<FormState>();

  Future<dynamic> getNewPin() async {
    final body = <String, String>{
      'idAccount': dtUser['idAccount'],
      'pin': contPinLama.text,
      'pinBaru': contPinBaru.text,
    };
    final response =
        await _network.post(url: 'eidupay/profile/getGantiPin', body: body);
    final bodyResponse = await response.stream.bytesToString();
    final decryptedBody = _network.decrypt(bodyResponse);
    final decodedBody = jsonDecode(decryptedBody);
    return decodedBody;
  }

  Future<void> resetTap() async {
    if (formKey.currentState!.validate()) {
      EiduLoadingDialog.showLoadingDialog();
      var res = await getNewPin();
      Get.back();
      if (res['ACK'] == 'NOK') {
        if (res['forceLogout'] == 'no') {
          await EiduInfoDialog.showInfoDialog(
              title: 'Eidupay', description: res['pesan']);
          return;
        } else {
          await Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              onWillPop: () async {
                await Get.offAllNamed(Login.route.name);
                return true;
              },
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        size: 70, color: Colors.red),
                    const SizedBox(height: 10),
                    const Text(
                      'Proses Gagal!',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    Text(res['pesan'] ?? ''),
                    const SizedBox(height: 30),
                    SubmitButton(
                      backgroundColor: green,
                      text: 'Kembali ke Login',
                      onPressed: () => Get.offAllNamed(Login.route.name),
                    )
                  ],
                ),
              ));
        }
      }

      if (res['ACK'] == 'OK') {
        await Get.defaultDialog(
            title: '',
            barrierDismissible: false,
            onWillPop: () async {
              await Get.offAllNamed(Login.route.name);
              return true;
            },
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      size: 70, color: green),
                  const SizedBox(height: 10),
                  const Text(
                    'Selamat!',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                      'PIN berhasil direset. Anda dapat login dengan PIN yang baru.'),
                  const SizedBox(height: 30),
                  SubmitButton(
                    backgroundColor: green,
                    text: 'Kembali ke Login',
                    onPressed: () => Get.offAllNamed(Login.route.name),
                  )
                ],
              ),
            ));
      }
    }
  }
}
