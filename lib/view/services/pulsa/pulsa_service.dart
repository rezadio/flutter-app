import 'package:eidupay/controller/services/pulsa/pulsa_cont.dart';
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

class PulsaService extends StatefulWidget {
  const PulsaService({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/pulsa-service', page: () => const PulsaService());

  @override
  State<PulsaService> createState() => _PulsaServiceState();
}

class _PulsaServiceState extends State<PulsaService>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(PulsaCont(injector.get()));
  final id = Get.arguments;
  late TabController _tabController;

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
        appBar: AppBar(title: const Text('Pulsa / Paket Data')),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: h(35)),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _c.formKey,
                  child: CustomTextFormField(
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
                                  await FlutterContactPicker.pickPhoneContact();

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
                ),
                Row(
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
                          style: TextStyle(fontSize: w(14), color: t70)),
                    ),
                  ],
                ),
                if (_c.isChecked.value == true)
                  TextFormField(
                    controller: _c.favoriteController,
                    decoration: underlineInputDecoration.copyWith(
                        hintText: 'Masukkan nama favorit'),
                  ),
                SizedBox(height: h(10)),
                SubmitButton(
                  backgroundColor: green,
                  text: 'Lanjutkan',
                  onPressed: () => _c.continueTap(_c.contNoHp.text, id),
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
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    Obx(() => _c.recentTrx.isEmpty
                        ? const Center(child: Text('Tidak ada data.'))
                        : ListView.builder(
                            padding: const EdgeInsets.only(top: 20.0),
                            physics: const BouncingScrollPhysics(),
                            itemCount: _c.recentTrx.length,
                            itemBuilder: (context, index) {
                              return RecentTransactionWidget(
                                  title: 'Pulsa',
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
                              final noPelanggan =
                                  _c.savedName[index].noPelanggan;
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: _FavoriteCard(
                                  aliasName: aliasName,
                                  noPelanggan: noPelanggan,
                                  onTap: () {
                                    _c.contNoHp.text = noPelanggan;
                                  },
                                ),
                              );
                            })
                        : const Center(child: Text('Tidak ada data')))
                  ],
                ))
              ],
            ),
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
