import 'package:eidupay/controller/services/education/edukasi_input_siswa_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/education.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class EdukasiInputSiswa extends StatefulWidget {
  const EdukasiInputSiswa({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/services/education/:id/', page: () => const EdukasiInputSiswa());

  @override
  _EdukasiInputSiswaState createState() => _EdukasiInputSiswaState();
}

class _EdukasiInputSiswaState extends State<EdukasiInputSiswa> {
  final _c = Get.put(EdukasiInputSiswaCont(injector.get()));
  final DataListCategory data = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edukasi')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  key: _c.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No Induk Siswa',
                        style: TextStyle(
                            fontSize: w(16),
                            fontWeight: FontWeight.w500,
                            color: t100),
                      ),
                      SizedBox(height: h(15)),
                      TextFormField(
                        controller: _c.contNoInduk,
                        decoration: InputDecoration(
                            hintText: 'Masukkan no induk siswa',
                            hintStyle: TextStyle(
                                color: t70,
                                fontSize: w(16),
                                fontWeight: FontWeight.w400)),
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return 'No induk siswa harus diisi!';
                          }
                        },
                      ),
                    ],
                  )),
              const Spacer(),
              SubmitButton(
                backgroundColor: green,
                text: 'Lanjutkan',
                onPressed: () => _c.lanjutTap(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
