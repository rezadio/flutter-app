import 'package:eidupay/controller/sub_account/add_sub_account_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:eidupay/widget/custom_drop_down_form_field.dart';

class AddSubAccountPage extends StatefulWidget {
  static final route = GetPage(
      name: '/sub-account/create', page: () => const AddSubAccountPage());

  const AddSubAccountPage({Key? key}) : super(key: key);

  @override
  _AddSubAccountPageState createState() => _AddSubAccountPageState();
}

class _AddSubAccountPageState extends State<AddSubAccountPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Tambah Sub Account')),
        body: const _BodyAddSubAccountPage(),
      ),
    );
  }
}

class _BodyAddSubAccountPage extends StatefulWidget {
  const _BodyAddSubAccountPage({Key? key}) : super(key: key);

  @override
  _BodyAddSubAccountPageState createState() => _BodyAddSubAccountPageState();
}

class _BodyAddSubAccountPageState extends State<_BodyAddSubAccountPage> {
  final _controller = Get.put(AddSubAccountController(injector.get()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          Form(
            key: _controller.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _controller.nameController,
                  title: 'Nama',
                  hintText: 'Masukkan nama',
                  validator: (value) {
                    if (value!.isEmpty || value == '') {
                      return 'Nama harus diisi!';
                    }
                  },
                ),
                CustomTextFormField(
                  controller: _controller.emailController,
                  title: 'Email',
                  hintText: 'Masukkan Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return 'Email harus diisi!';
                    }
                    if (value.isEmpty) {
                      return 'Email harus diisi!';
                    }
                    if (value.isNotEmpty) {
                      if (!emailValidation.hasMatch(value)) {
                        return 'Penulisan email salah!';
                      }
                    }
                  },
                ),
                CustomDropdownFormField(
                  title: 'Hubungan',
                  hint: 'Masukkan hubungan',
                  items: const [
                    DropdownMenuItem(child: Text('Ayah'), value: 'Ayah'),
                    DropdownMenuItem(child: Text('Ibu'), value: 'Ibu'),
                    DropdownMenuItem(child: Text('Anak'), value: 'Anak'),
                    DropdownMenuItem(child: Text('Saudara'), value: 'Saudara'),
                    DropdownMenuItem(child: Text('Sahabat'), value: 'Sahabat'),
                  ],
                  onPressed: (value) {
                    _controller.relationshipValue = value;
                  },
                ),
                CustomTextFormField(
                  controller: _controller.phoneController,
                  title: 'No. Handphone',
                  hintText: 'Masukkan No. Handphone',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: _controller.pinController,
                    title: 'Log In PIN',
                    hintText: 'Enter PIN',
                    keyboardType: TextInputType.number,
                    obscureText: _controller.isPinHide.value,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    suffixIcon: GestureDetector(
                      child: Icon(_controller.isPinHide.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onTap: () {
                        _controller.isPinHide.value =
                            !_controller.isPinHide.value;
                      },
                    ),
                    validator: pinValidator,
                  ),
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: _controller.konfirmPinController,
                    title: 'Konfirmasi Log In PIN',
                    hintText: 'Masukkan PIN',
                    keyboardType: TextInputType.number,
                    obscureText: _controller.isKonfirmPinHide.value,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    suffixIcon: GestureDetector(
                      child: Icon(_controller.isKonfirmPinHide.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onTap: () {
                        _controller.isKonfirmPinHide.value =
                            !_controller.isKonfirmPinHide.value;
                      },
                    ),
                    validator: (value) {
                      if (value != _controller.pinController.text) {
                        return 'Konfirmasi PIN salah!';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 25),
                SubmitButton(
                  text: 'Simpan',
                  backgroundColor: green,
                  onPressed: () => _controller.simpanTap(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
