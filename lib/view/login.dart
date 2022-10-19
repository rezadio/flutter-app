import 'package:eidupay/controller/login_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/common_mod.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/signup.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:eidupay/widget/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  static final route = GetPage(name: '/login', page: () => const Login());
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _c = Get.put(LoginCont(injector.get()));
  bool? isSessionExpired = false;

  @override
  Widget build(BuildContext context) {
    isSessionExpired = Get.arguments;

    return FutureBuilder<bool>(
      initialData: false,
      future: _c.checkIsUseBiometric(),
      builder: (context, AsyncSnapshot<bool> snap) {
        if (isSessionExpired != null && isSessionExpired!) {
          final data = snap.data;
          if (data != null && data) {
            _c.biometricLogin();
            isSessionExpired = false;
          }
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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
                    Text(
                      'Masuk ke\nEidupay',
                      style: TextStyle(
                        fontSize: w(30),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SmallDivider(),
                    SizedBox(height: h(24)),
                    SizedBox(
                      height: 60,
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          items: negara,
                          value: _c.negaraSelected,
                          onChanged: (val) {
                            _c.negaraSelected = val.toString();
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    Form(
                        key: _c.formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: h(27)),
                              Text(
                                'Nomor Handphone',
                                style: TextStyle(
                                    fontSize: w(14),
                                    color: t50,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 4),
                              TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return 'Nomor handphone tidak boleh kosong!';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _c.contPhoneNumber,
                                  keyboardType: TextInputType.number,
                                  decoration: mainInputDecoration.copyWith(
                                      hintText: 'Masukkan nomor handphone')),
                              SizedBox(height: h(27)),
                              Text(
                                'PIN',
                                style: TextStyle(
                                    fontSize: w(14),
                                    color: t50,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 4),
                              Obx(() => TextFormField(
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'PIN tidak boleh kosong!';
                                      } else if (value != null &&
                                          value.length < 6) {
                                        return 'Format Pin belum sesuai!';
                                      } else {
                                        return null;
                                      }
                                    },
                                    maxLength: 6,
                                    controller: _c.contPin,
                                    obscureText: !_c.showPass.value,
                                    keyboardType: TextInputType.number,
                                    onFieldSubmitted: (value) => _c.signInTap(),
                                    decoration: mainInputDecoration.copyWith(
                                      hintText: 'Masukkan PIN',
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            _c.showPass.value =
                                                !_c.showPass.value;
                                          },
                                          child: Icon(
                                              (_c.showPass.value)
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: _c.showPass.value
                                                  ? green
                                                  : t50)),
                                    ),
                                  )),
                            ])),
                    SizedBox(height: h(60)),
                    Obx(
                      () => Row(
                        children: [
                          if (_c.isUseBiometric.value)
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: green),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              child: Container(
                                  height: 58,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              _c.biometricIcon.value),
                                          height: 30,
                                          width: 30),
                                    ],
                                  )),
                              onPressed: () => _c.biometricLogin(),
                            ),
                          if (_c.isUseBiometric.value) const SizedBox(width: 8),
                          Expanded(
                            child: SubmitButton(
                              text: 'Masuk',
                              backgroundColor: green,
                              onPressed: () => _c.signInTap(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h(20)),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => _c.lupaPasswordTap(),
                        child: Text('Lupa PIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: w(14), color: t70)),
                      ),
                    ),
                    SizedBox(height: h(30)),
                    GestureDetector(
                      onTap: () => Get.offNamed(Signup.route.name),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Belum memiliki akun?',
                              style: TextStyle(fontSize: w(15), color: t70)),
                          Text(' Daftar',
                              style: TextStyle(
                                  fontSize: w(15),
                                  color: blue,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    VersionWidget.numberOnly(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
