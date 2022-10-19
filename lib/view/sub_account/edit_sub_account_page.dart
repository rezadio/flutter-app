import 'package:eidupay/controller/sub_account/edit_sub_account_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_drop_down_form_field.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditSubAccountPage extends StatefulWidget {
  static final route = GetPage(
      name: '/sub-account/:id/edit', page: () => const EditSubAccountPage());
  const EditSubAccountPage({Key? key}) : super(key: key);

  @override
  _EditSubAccountPageState createState() => _EditSubAccountPageState();
}

class _EditSubAccountPageState extends State<EditSubAccountPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit')),
        body: const _BodyEditSubAccountPage(),
      ),
    );
  }
}

class _BodyEditSubAccountPage extends StatefulWidget {
  const _BodyEditSubAccountPage({Key? key}) : super(key: key);

  @override
  _BodyEditSubAccountPageState createState() => _BodyEditSubAccountPageState();
}

class _BodyEditSubAccountPageState extends State<_BodyEditSubAccountPage> {
  final _controller = Get.put(EditSubAccountController(injector.get()));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          Form(
            key: _controller.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _controller.nameController,
                  title: 'Nama',
                  hintText: 'Masukkan nama',
                  onChanged: (val) {
                    _controller.hasChange(true);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Nama harus diisi!';
                    }
                    if (value.isEmpty) {
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
                        return 'Penuisan email salah!';
                      }
                    }
                  },
                  onChanged: (val) {
                    _controller.hasChange(true);
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
                    _controller.hasChange.value = true;
                    _controller.relationshipValue = value;
                  },
                  value: _controller.relationshipValue,
                ),
                CustomTextFormField(
                  controller: _controller.phoneController,
                  title: 'No. Handphone',
                  hintText: 'Masukkan No Handphone',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (val) {
                    _controller.hasChange(true);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'No. Handphone harus diisi!';
                    }
                    if (value.isEmpty) {
                      return 'No. Handphone harus diisi!';
                    }
                  },
                ),
                GestureDetector(
                    onTap: () => _controller.resetPin(),
                    child: const Text(
                      'Reset PIN',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
          SizedBox(height: h(30)),
          Obx(() => SubmitButton(
                backgroundColor: green,
                text: 'Simpan',
                onPressed: !_controller.hasChange.value
                    ? null
                    : () => _controller.simpanTap(),
              ))
        ],
      ),
    );
  }
}
