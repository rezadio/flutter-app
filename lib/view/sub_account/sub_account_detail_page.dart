import 'package:eidupay/controller/sub_account/sub_account_detail_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:eidupay/extension.dart';
import 'package:eidupay/tools.dart';

class SubAccountDetailPage extends StatefulWidget {
  static final route = GetPage(
      name: '/sub_account/:id', page: () => const SubAccountDetailPage());
  const SubAccountDetailPage({Key? key}) : super(key: key);

  @override
  _SubAccountDetailPageState createState() => _SubAccountDetailPageState();
}

class _SubAccountDetailPageState extends State<SubAccountDetailPage> {
  final _c = Get.put(SubAccountDetailController(injector.get()));

  @override
  void initState() {
    super.initState();
    _c.idExt = Get.parameters['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (!_c.isLoaded.value)
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(_c.detail.name),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Get.toNamed('/sub-account/${Get.parameters['id']}/edit',
                            arguments: _c.detail);
                      },
                    )
                  ],
                ),
                body: const _BodySubAccountDetailPage(),
              ),
            ),
    );
  }
}

class _BodySubAccountDetailPage extends StatefulWidget {
  const _BodySubAccountDetailPage({Key? key}) : super(key: key);

  @override
  _BodySubAccountDetailPageState createState() =>
      _BodySubAccountDetailPageState();
}

class _BodySubAccountDetailPageState extends State<_BodySubAccountDetailPage> {
  final _c = Get.find<SubAccountDetailController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: CustomHalfCircleClipper(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 300,
                  width: double.infinity,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: CircularProgressIndicator(
                      value: _c.detail.limit == '0'
                          ? 0
                          : (double.parse(_c.detail.used) /
                              double.parse(_c.detail.limit) /
                              2),
                      strokeWidth: 20,
                      backgroundColor: green.withOpacity(0.1),
                      color: green,
                      semanticsLabel: 'Limit value',
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah bertansaksi sebesar',
                          style: TextStyle(
                              color: t70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => Text(
                            'Rp ' + _c.amountUsed.value,
                            style: const TextStyle(
                                fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'dari Rp ' + _c.detail.limit,
                          style: const TextStyle(
                              color: t70,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          child: const Text('Reset Penggunaan'),
                          onPressed: () => _c.resetUsedTap(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CustomIconButtonWithLabel(
                        label: 'Top Up',
                        iconUrl: 'assets/images/ico_topup.png',
                        color: green,
                        onTap: () => _c.topupTap(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h(24)),
          Form(
            key: _c.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        height: 15,
                        width: 30,
                        child: Checkbox(
                            value: _c.isDailyLimitChecked.value,
                            onChanged: (_) => _c.toggleDailyCheck()),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () => _c.toggleDailyCheck(),
                          child: const Text('Daily Limit',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: t80)),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => (_c.isDailyLimitChecked.value)
                      ? Column(
                          children: [
                            _CustomTextFormField(
                              controller: _c.amountDailyLimitController,
                              hintText: 'Enter Amount Limit',
                              keyboardType: TextInputType.number,
                              inputFormatters: [currencyMaskFormatter],
                              onChanged: (value) {
                                _c.isChange.value = true;
                                if (value.isEmpty) {
                                  _c.dailyLimitValue.value = 0.0;
                                } else {
                                  final unformattedValue = int.parse(
                                      currencyMaskFormatter.magicMask
                                          .clearMask(value));
                                  final maxDailyLimit = int.parse(
                                      _c.maxDailyLimit.value.numericOnly());
                                  if (unformattedValue >= maxDailyLimit) {
                                    _c.amountDailyLimitController.text =
                                        maxDailyLimit.amountFormat;
                                    _c.dailyLimitValue.value =
                                        maxDailyLimit.toDouble();
                                    return;
                                  }
                                  _c.dailyLimitValue.value =
                                      unformattedValue.toDouble();
                                }
                              },
                            ),
                            SizedBox(height: h(4)),
                            Obx(
                              () => Slider(
                                value: _c.dailyLimitValue.value,
                                min: 0,
                                max: double.parse(
                                    _c.maxDailyLimit.value.numericOnly()),
                                divisions: 100,
                                onChanged: (value) {
                                  _c.isChange.value = true;
                                  _c.dailyLimitValue.value = value;
                                  _c.amountDailyLimitController.text =
                                      value.round().amountFormat;
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Rp 0.00',
                                  style: TextStyle(fontSize: 12, color: t50),
                                ),
                                Obx(
                                  () => Text(
                                    'Rp ' + _c.maxDailyLimit.value,
                                    style: const TextStyle(
                                        fontSize: 12, color: t50),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: h(50)),
                _CustomTextFormField(
                  controller: _c.amountLimitController,
                  title: 'Amount Limit',
                  hintText: 'Enter Amount Limit',
                  keyboardType: TextInputType.number,
                  inputFormatters: [currencyMaskFormatter],
                  onChanged: (value) {
                    _c.isChange.value = true;
                    if (value.isEmpty) {
                      _c.limitValue.value = 0.0;
                    } else {
                      int unformattedValue = 0;
                      final maxDailyLimit =
                          int.parse(_c.maxDailyLimit.value.numericOnly());

                      if (value.contains(',')) {
                        unformattedValue = int.parse(
                            currencyMaskFormatter.magicMask.clearMask(value));
                      } else {
                        unformattedValue = int.parse(value);
                      }

                      if (unformattedValue < _c.maxValue) {
                        _c.maxDailyLimit.value = unformattedValue.amountFormat;
                        _c.limitValue.value = unformattedValue.toDouble();
                        if (_c.dailyLimitValue.value.toInt() >
                            int.parse(_c.maxDailyLimit.value.numericOnly())) {
                          _c.amountDailyLimitController.text =
                              _c.amountLimitController.text;
                          _c.dailyLimitValue.value = double.parse(
                              _c.amountLimitController.text.numericOnly());
                        }
                        return;
                      } else {
                        _c.amountLimitController.text =
                            _c.maxValue.toInt().amountFormat;
                        _c.limitValue.value = _c.maxValue.toDouble();
                        _c.maxDailyLimit.value =
                            _c.maxValue.toInt().amountFormat;
                      }
                    }
                  },
                ),
                SizedBox(height: h(4)),
                Obx(
                  () => Slider(
                    value: _c.limitValue.value,
                    min: 0,
                    max: _c.maxValue,
                    divisions: 100,
                    onChanged: (value) {
                      _c.isChange.value = true;
                      _c.limitValue.value = value;
                      _c.amountLimitController.text =
                          value.round().amountFormat;
                      _c.maxDailyLimit.value = _c.amountLimitController.text;
                      if (_c.dailyLimitValue.value > value) {
                        _c.dailyLimitValue.value = value;
                        _c.amountDailyLimitController.text =
                            value.round().amountFormat;
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rp 0.00',
                      style: TextStyle(fontSize: 12, color: t50),
                    ),
                    Text(
                      'Rp ' + _c.maxValue.amountFormat,
                      style: const TextStyle(fontSize: 12, color: t50),
                    )
                  ],
                ),
                SizedBox(height: h(24)),
              ],
            ),
          ),
          SizedBox(height: h(24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nomor Handphone',
                style: TextStyle(
                    fontSize: 14, color: n800, fontWeight: FontWeight.bold),
              ),
              Text(_c.detail.phone)
            ],
          ),
          SizedBox(height: h(10)),
          _ToggleCard(
            text: 'Lock Fund',
            toggle: _c.toggleLockFund,
            onTap: (value) {
              _c.isChange.value = true;
              _c.toggleLockFund.value = !_c.toggleLockFund.value;
            },
          ),
          _ToggleCard(
            text: 'Non Aktif',
            toggle: _c.toggleDeactivateAccount,
            onTap: (value) {
              _c.isChange.value = true;
              _c.toggleDeactivateAccount.value =
                  !_c.toggleDeactivateAccount.value;
            },
          ),
          SizedBox(height: h(24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              InkWell(
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // const Icon(
                    //   Icons.delete,
                    //   color: red,
                    // ),
                    const Text(
                      'Hapus Akun',
                      style: TextStyle(
                          fontSize: 14,
                          color: red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () async => showModalBottomSheet(
                    shape: const StadiumBorder(),
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 3,
                                    width: 38,
                                    color: const Color(0xFFEBEBED),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 75,
                                        width: 75,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: green.withOpacity(0.1),
                                            shape: BoxShape.circle),
                                        child: const Image(
                                          color: green,
                                          image: AssetImage(
                                              'assets/images/trash.png'),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Hapus akun?',
                                        style: TextStyle(
                                            color: n800,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 22),
                                  const Text(
                                    'Apakah anda yakin akan menghapus akun ini ?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: t70),
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      TextButton(
                                        child: const Text(
                                          'Hapus',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () => _c.deleteTap(),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: SubmitButton(
                                          text: 'Batal',
                                          backgroundColor: green,
                                          onPressed: () {
                                            _c.toggleDeleteAccount.value =
                                                false;
                                            Get.back();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      );
                    }),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Obx(() => SubmitButton(
              backgroundColor: green,
              text: 'Simpan',
              onPressed: _c.isChange.value ? () => _c.simpanTap() : null)),
        ],
      ),
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final String text;
  final RxBool toggle;
  final Function(bool) onTap;

  const _ToggleCard({
    Key? key,
    required this.onTap,
    required this.text,
    required this.toggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: n800, fontWeight: FontWeight.bold),
          ),
          Obx(
            () => FlutterSwitch(
              value: toggle.value,
              height: 25,
              width: 45,
              toggleSize: 15,
              onToggle: onTap,
              activeColor: green,
              duration: const Duration(milliseconds: 150),
            ),
          )
        ],
      ),
    );
  }
}

class _CustomIconButtonWithLabel extends StatelessWidget {
  final String label;
  final String iconUrl;
  final Color color;
  final void Function()? onTap;

  const _CustomIconButtonWithLabel({
    Key? key,
    required this.label,
    required this.iconUrl,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Image(color: color, image: AssetImage(iconUrl)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

class _CustomTextFormField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String value)? onChanged;
  final int? maxLength;

  const _CustomTextFormField({
    Key? key,
    this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final judul = title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (judul != null)
          Text(
            judul,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: t80),
          ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: underlineInputDecoration.copyWith(
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixText: 'Rp ',
              prefixStyle: const TextStyle(color: t90)),
        ),
      ],
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
