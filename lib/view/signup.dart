import 'package:eidupay/controller/signup_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/common_mod.dart';
import 'package:eidupay/view/login.dart';
import 'package:eidupay/view/terms_signup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:eidupay/widget/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class Signup extends StatelessWidget {
  static final route = GetPage(name: '/signup', page: () => Signup());
  Signup({Key? key}) : super(key: key);

  final c = Get.put(SignupCont(injector.get()));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Form(
              key: c.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h(64)),
                  SizedBox(
                    width: w(122),
                    height: w(42),
                    child: Image.asset(
                      'assets/images/logo_eidupay.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: h(13)),
                  Text('Buat Akun Baru',
                      style: TextStyle(
                          fontSize: w(30), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const SmallDivider(),
                  SizedBox(height: h(24)),
                  SizedBox(
                    height: 60,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonFormField(
                        items: negara,
                        value: c.negaraSelected,
                        onChanged: (val) {
                          c.negaraSelected = val.toString();
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(height: h(27)),
                  Text('Nama Lengkap',
                      style: TextStyle(fontSize: w(14), color: t50)),
                  const SizedBox(height: 4),
                  TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return 'Nama tidak bisa kosong';
                        } else {
                          return null;
                        }
                      },
                      controller: c.contName,
                      decoration: mainInputDecoration.copyWith(
                          hintText: 'Masukkan Nama')),
                  SizedBox(height: h(27)),
                  Text(
                    'Nomor Telepon',
                    style: TextStyle(fontSize: w(14), color: t50),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return 'Nomor telepon tidak bisa kosong';
                        } else {
                          return null;
                        }
                      },
                      controller: c.contPhoneNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: mainInputDecoration.copyWith(
                          hintText: 'Masukkan Nomor Telepon')),
                  SizedBox(height: h(27)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Referral ID/Komunitas',
                          style: TextStyle(fontSize: w(14), color: t50)),
                      Text('Opsional',
                          style: TextStyle(fontSize: w(14), color: t50)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                      controller: c.contRefID,
                      decoration: mainInputDecoration.copyWith(
                          hintText: 'Masukkan referral ID'),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        c.komunitasTap();
                      }),
                  SizedBox(height: h(40)),
                  SubmitButton(
                    backgroundColor: green,
                    text: 'Lanjutkan',
                    onPressed: () async {
                      if (c.formKey.currentState?.validate() == true) {
                        await Get.toNamed(TermSignup.route.name);
                      }
                    },
                  ),
                  SizedBox(height: h(30)),
                  GestureDetector(
                    onTap: () => Get.offNamed(Login.route.name),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah memiliki akun?',
                            style: TextStyle(fontSize: w(15), color: t70)),
                        Text(' Masuk',
                            style: TextStyle(
                                fontSize: w(15),
                                color: blue,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  VersionWidget.numberOnly(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
