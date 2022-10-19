import 'package:eidupay/controller/services/pascabayar/pascabayar_cont.dart';
import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/recent_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class PascabayarService extends StatefulWidget {
  const PascabayarService({Key? key}) : super(key: key);
  static final route = GetPage(
      name: '/pascabayar_service', page: () => const PascabayarService());

  @override
  _PascabayarServiceState createState() => _PascabayarServiceState();
}

class _PascabayarServiceState extends State<PascabayarService>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(PascabayarCont(injector.get()));
  late TabController _tabController;
  final id = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.idMenu = id;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    PhoneContact? _phoneContact;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pascabayar')),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(30)),
              // Text(
              //   'Nomor Handphone',
              //   style: TextStyle(
              //       fontSize: w(16), fontWeight: FontWeight.w500, color: t100),
              // ),
              // SizedBox(height: h(15)),

              Form(
                key: _c.formKey,
                child: Column(
                  children: [
                    // TextFormField(
                    //   controller: _c.contNoHp,
                    //   decoration: InputDecoration(
                    //       hintText: 'Masukkan no handphone',
                    //       hintStyle: const TextStyle(color: t70),
                    //       suffixIcon: GestureDetector(
                    //         child: const Icon(Icons.clear),
                    //         onTap: () => _c.clear(),
                    //       )),
                    //   validator: (value) {
                    //     if (value == '') {
                    //       return 'No handphone tidak boleh kosong!';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    CustomTextFormField(
                      controller: _c.contNoHp,
                      maxLength: 13,
                      title: 'Nomor Handphone',
                      hintText: 'Masukkan Nomor Handphone',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      suffixIcon: Container(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: const Icon(Icons.clear),
                              onTap: () => _c.clear(),
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.account_box,
                                size: 30,
                                color: blue,
                              ),
                              onTap: () async {
                                PhoneContact contact =
                                    await FlutterContactPicker
                                        .pickPhoneContact();

                                setState(() {
                                  _phoneContact = contact;
                                  _c.contNoHp.text =
                                      StringUtils.stringToFixPhoneNumber(
                                          _phoneContact!.phoneNumber!.number!);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty || val == '') {
                          return 'Nomor Handphone tidak boleh kosong!';
                        }
                      },
                    ),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: _c.isChecked.value,
                              onChanged: (val) {
                                _c.isChecked.value = !_c.isChecked.value;
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                _c.isChecked.value = !_c.isChecked.value;
                              },
                              child: Text('Simpan untuk digunakan lagi',
                                  style:
                                      TextStyle(fontSize: w(14), color: t70)),
                            ),
                          ],
                        )),
                    Obx(() => _c.isChecked.value == true
                        ? TextFormField(
                            controller: _c.favoriteController,
                            decoration: underlineInputDecoration.copyWith(
                                hintText: 'Masukkan nama favorit'),
                            validator: (val) {
                              if (_c.isChecked.value &&
                                  _c.favoriteController.text == '') {
                                return 'Nama favorit harus diisi!';
                              }
                            },
                          )
                        : Container()),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SubmitButton(
                backgroundColor: green,
                text: 'Continue',
                onPressed: () => _c.continueTap(_c.contNoHp.text),
              ),
              SizedBox(height: h(10)),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Transaksi Terakhir'),
                  Tab(text: 'Tersimpan'),
                ],
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Obx(() => _c.recentTrx.isEmpty
                      ? const Center(child: Text('Tidak ada data.'))
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 20.0),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _c.recentTrx.length,
                          itemBuilder: (context, index) {
                            return RecentTransactionWidget(
                                title: _c.recentTrx[index].namaTipeTransaksi,
                                id: _c.recentTrx[index].noHpTujuan ??
                                    _c.recentTrx[index].noRekTujuan ??
                                    '',
                                date: _c.recentTrx[index].timeStamp,
                                price: _c.recentTrx[index].total);
                          },
                        )),
                  Obx(() => _c.savedName.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _c.savedName.length,
                          itemBuilder: (context, index) {
                            final aliasName = _c.savedName[index].aliasName;
                            final noPelanggan = _c.savedName[index].noPelanggan;
                            return _FavoriteCard(
                              aliasName: aliasName,
                              noPelanggan: noPelanggan,
                              onTap: () {
                                _c.contNoHp.text = noPelanggan;
                              },
                            );
                          })
                      : const Center(child: Text('Tidak ada data')))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final String aliasName;
  final String noPelanggan;
  final void Function()? onTap;
  const _FavoriteCard(
      {Key? key,
      required this.aliasName,
      required this.noPelanggan,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0xFFEAEAEA))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              aliasName,
              style: TextStyle(
                  color: t90, fontSize: w(14), fontWeight: FontWeight.w400),
            ),
            Text(
              noPelanggan,
              style: const TextStyle(
                  color: t90, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
