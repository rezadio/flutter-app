import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:eidupay/controller/transfer/transfer_to_emoney_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/eidu_saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:shimmer/shimmer.dart';

class TransferToEMoneyPage extends StatefulWidget {
  static final route = GetPage(
      name: '/transfer/emoney', page: () => const TransferToEMoneyPage());
  const TransferToEMoneyPage({Key? key}) : super(key: key);

  @override
  _TransferToEMoneyPageState createState() => _TransferToEMoneyPageState();
}

class _TransferToEMoneyPageState extends State<TransferToEMoneyPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Transfer ke e-Money')),
        body: const _BodyTransferToEMoneyPage(),
      ),
    );
  }
}

class _BodyTransferToEMoneyPage extends StatefulWidget {
  const _BodyTransferToEMoneyPage({Key? key}) : super(key: key);

  @override
  _BodyTransferToEMoneyPageState createState() =>
      _BodyTransferToEMoneyPageState();
}

class _BodyTransferToEMoneyPageState extends State<_BodyTransferToEMoneyPage> {
  final _getController = Get.put(TransferToEMoneyController(injector.get()));
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    PhoneContact? _phoneContact;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => EiduSaldoCard(saldo: _getController.balance.value)),
            SizedBox(height: h(30)),
            const Text(
              'Pilih e-Money',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h(15)),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 60,
                child: (_getController.operator.isEmpty)
                    ? Center(
                        child: Shimmer(
                        gradient: const LinearGradient(
                            colors: [Colors.white70, green]),
                        direction: ShimmerDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: w(100),
                              height: w(40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                            ),
                            Container(
                              width: w(100),
                              height: w(40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                            ),
                            Container(
                              width: w(100),
                              height: w(40),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _getController.operator.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => _OperatorCard(
                              bankPath: _getController.getImage(
                                  _getController.operator[index].namaOperator),
                              isTap: _getController.tappedId.contains(index),
                              onTap: () async {
                                if (_getController.tappedId.isEmpty) {
                                  _getController.tappedId.add(index);
                                  _getController.operatorId.value =
                                      _getController.operator[index].idOperator;
                                  await _getController.getDenom();
                                  _getController.isDenomSelected.value = false;
                                } else if (_getController.tappedId
                                    .contains(index)) {
                                  return;
                                } else {
                                  _getController.tappedId.clear();
                                  _getController.tappedId.add(index);
                                  _getController.operatorId.value =
                                      _getController.operator[index].idOperator;
                                  await _getController.getDenom();
                                  _getController.isDenomSelected.value = false;
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: h(40)),
            Form(
              key: _getController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: _getController.phoneController,
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
                            onTap: () => _getController.clear(),
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
                                _getController.phoneController.text =
                                    StringUtils.stringToFixPhoneNumber(_phoneContact!.phoneNumber!.number!);
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
                ],
              ),
            ),
            const Text('Nominal : ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(vertical: h(24)),
                  child: (_getController.denoms.isEmpty)
                      ? const Text('')
                      :

                      // GridView.builder(
                      //     gridDelegate:
                      //         const SliverGridDelegateWithMaxCrossAxisExtent(
                      //       maxCrossAxisExtent: 200,
                      //       childAspectRatio: 2 / 0.77,
                      //       crossAxisSpacing: 30,
                      //       mainAxisSpacing: 15,
                      //     ),
                      //     itemCount: _getController.denoms.length,
                      //     itemBuilder: (BuildContext ctx, i) {
                      //       return _DenomWidget(
                      //           nominal: _getController.denoms[i].nominal,
                      //           hargaCetak:
                      //               _getController.denoms[i].hargaCetak,
                      //           onTap: () {
                      //             if (_getController.denomSelected.isEmpty) {
                      //               _getController.denomSelected
                      //                   .add(_getController.denoms[i]);
                      //               _getController.isDenomSelected.value =
                      //                   true;
                      //             } else {
                      //               _getController.denomSelected.clear();
                      //               _getController.denomSelected
                      //                   .add(_getController.denoms[i]);
                      //               _getController.isDenomSelected.value =
                      //                   true;
                      //             }
                      //           });
                      //     })
                      ListView.builder(
                          controller: scrollController,
                          itemCount: _getController.denoms.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => _DenomWidget(
                                nominal: _getController.denoms[index].nominal,
                                hargaCetak:
                                    _getController.denoms[index].hargaCetak,
                                isSelected: _getController.denomSelected
                                    .contains(_getController.denoms[index]),
                                onTap: () {
                                  if (_getController.denomSelected.isEmpty) {
                                    _getController.denomSelected
                                        .add(_getController.denoms[index]);
                                    _getController.isDenomSelected.value = true;
                                  } else {
                                    _getController.denomSelected.clear();
                                    _getController.denomSelected
                                        .add(_getController.denoms[index]);
                                    _getController.isDenomSelected.value = true;
                                  }
                                },
                              ),
                            );
                          }),
                ),
              ),
            ),
            SubmitButton(
              backgroundColor: green,
              text: 'Lanjutkan',
              onPressed: () => _getController.process(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class _OperatorCard extends StatelessWidget {
  final String bankPath;
  final bool isTap;
  final void Function()? onTap;

  const _OperatorCard({
    Key? key,
    required this.bankPath,
    this.isTap = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 13),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
            color: isTap ? green.withOpacity(0.2) : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Image(
            image: AssetImage(bankPath),
          ),
        ),
      ),
    );
  }
}

class _DenomWidget extends StatelessWidget {
  final bool isSelected;
  final void Function()? onTap;
  final String nominal;
  final String hargaCetak;

  const _DenomWidget({
    Key? key,
    this.isSelected = false,
    this.onTap,
    required this.nominal,
    required this.hargaCetak,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  GestureDetector(
        //   onTap: () => onTap,
        //   child: Container(
        //     width: w(60),
        //     height: w(26),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(color: green),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           nominal,
        //           style: TextStyle(
        //               fontSize: w(14),
        //               fontWeight: FontWeight.w700,
        //               color: darkBlue),
        //         ),
        //         const SizedBox(
        //           height: 5,
        //         ),
        //         Text(
        //           'Rp. ' + hargaCetak,
        //           style: TextStyle(
        //               fontSize: w(12), fontWeight: FontWeight.w400, color: green),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
            color: isSelected ? green.withOpacity(0.2) : Colors.transparent,
            border: const Border(bottom: BorderSide(color: t40))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nominal,
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w400,
                      color: t100),
                ),
                Text(
                  hargaCetak,
                  style: TextStyle(
                      fontSize: w(16),
                      fontWeight: FontWeight.w400,
                      color: t100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
