import 'package:eidupay/controller/topup/add_new_card_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCard extends StatelessWidget {
  const AddNewCard({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/topup-instant/manage-card/add', page: () => const AddNewCard());

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(AddNewCardCont(injector.get()));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Tambah Kartu')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Form(
                  key: _c.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama pada kartu',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w400,
                            color: t60),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _c.nameController,
                        decoration: mainInputDecoration.copyWith(
                            hintText: 'Masukkan Nama'),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Wajib diisi';
                          }
                        },
                      ),
                      SizedBox(height: h(20)),
                      Text(
                        'Nomor Kartu',
                        style: TextStyle(
                            fontSize: w(14),
                            fontWeight: FontWeight.w400,
                            color: t60),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _c.cardNumController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [cardNumFormatter],
                        decoration: mainInputDecoration.copyWith(
                            hintText: 'Masukkan nomor kartu'),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Wajib diisi';
                          }
                        },
                      ),
                      SizedBox(height: h(20)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expired date',
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w400,
                                      color: t60),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: _c.expDateController,
                                  inputFormatters: [_c.expDateMask],
                                  keyboardType: TextInputType.number,
                                  decoration: mainInputDecoration.copyWith(
                                      hintText: 'Masukkan exp date'),
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return 'Wajib diisi';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CVV',
                                  style: TextStyle(
                                      fontSize: w(14),
                                      fontWeight: FontWeight.w400,
                                      color: t60),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: _c.cvvController,
                                  maxLength: 3,
                                  keyboardType: TextInputType.number,
                                  decoration: mainInputDecoration.copyWith(
                                      hintText: 'Masukkan cvv'),
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return 'Wajib diisi';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.28),
                SubmitButton(
                  backgroundColor: green,
                  text: 'Simpan',
                  onPressed: () => _c.saveTap(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
