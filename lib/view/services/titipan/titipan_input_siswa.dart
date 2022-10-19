import 'package:eidupay/controller/services/titipan/titipan_input_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/category_data.dart';
import 'package:eidupay/model/common_mod.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TitipanInputSiswa extends StatefulWidget {
  const TitipanInputSiswa({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/sevices/titipan/input-siswa',
      page: () => const TitipanInputSiswa());

  @override
  _TitipanInputSiswaState createState() => _TitipanInputSiswaState();
}

class _TitipanInputSiswaState extends State<TitipanInputSiswa> {
  final _c = Get.put(TitipanInputController(injector.get()));
  final DataCategory _data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Setoran')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _c.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h(56)),
                        Text(
                          'Masukkan Nomor Induk Siswa',
                          style: TextStyle(
                              fontSize: w(16),
                              fontWeight: FontWeight.w500,
                              color: t100),
                        ),
                        SizedBox(height: h(15)),
                        TextFormField(
                          controller: _c.nomorIndukController,
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
                SizedBox(height: h(30)),
                Text(
                  'Sumber Dana',
                  style: TextStyle(
                      fontSize: w(16),
                      fontWeight: FontWeight.w500,
                      color: t100),
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
                const SizedBox(height: 30),
                SubmitButton(
                  backgroundColor: green,
                  text: 'Lanjutkan',
                  onPressed: () => _c.process(dataCategory: _data),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
