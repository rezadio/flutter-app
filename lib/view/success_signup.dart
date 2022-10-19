import 'package:eidupay/controller/signup_cont.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class SuccessSignUp extends StatelessWidget {
  static final route =
      GetPage(name: '/success-signUp', page: () => const SuccessSignUp());

  const SuccessSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _signUpController = Get.find<SignupCont>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 33, right: 33),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  width: w(122),
                  height: w(42),
                  child: Image.asset('assets/images/logo_eidupay.png'),
                ),
                SizedBox(height: h(90)),
                SizedBox(
                  width: w(275),
                  height: w(255),
                  child: Image.asset('assets/images/success.png'),
                ),
                SizedBox(height: h(72)),
                Text('Sukses Membuat Akun!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: w(25),
                        color: blue,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: h(40)),
                SizedBox(
                  width: double.infinity,
                  height: w(58),
                  child: SubmitButton(
                    text: 'Mulai',
                    backgroundColor: green,
                    onPressed: () async {
                      await _signUpController.signIn();
                      await Get.offAllNamed(Home.route.name);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
