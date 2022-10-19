import 'package:eidupay/model/page_argument.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/view/kyc/instruction_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EiduKycBottomSheet extends StatefulWidget {
  const EiduKycBottomSheet._({Key? key}) : super(key: key);

  static void showBottomSheet() => showModalBottomSheet(
      isScrollControlled: true,
      shape: const StadiumBorder(),
      context: navigatorKey.currentContext!,
      builder: (context) => const EiduKycBottomSheet._());

  @override
  _EiduKycBottomSheet createState() => _EiduKycBottomSheet();
}

class _EiduKycBottomSheet extends State<EiduKycBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 20),
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
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: orange1.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: const Image(
                      color: orange1,
                      image: AssetImage('assets/images/ico_warning_big1.png'),
                    ),
                  ),
                  SizedBox(height: h(12)),
                  Text(
                    'KYC belum terverifikasi',
                    style:
                        TextStyle(fontSize: w(22), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Image(image: AssetImage('assets/images/kyc.png')),
              const SizedBox(height: 8),
              const Text(
                'Upgrade akun kamu untuk menikmati layanan ini',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: t70, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              SubmitButton(
                backgroundColor: orange1,
                text: 'Upgrade Sekarang',
                onPressed: () {
                  Get.back();
                  Get.toNamed(InstructionPage.route.name,
                      arguments: PageArgument.kycPage1());
                },
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: Container(
                      height: 58,
                      alignment: Alignment.center,
                      child: Text(
                        'Nanti',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: w(14),
                        ),
                      )))
            ],
          )),
    ]);
  }
}
