import 'package:eidupay/controller/profile/edit_profile_cont.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/account.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/shimmer_global.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eidupay/tools.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/edit_profile', page: () => const EditProfile());

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _c = Get.put(ProfileEditCont(injector.get()));
  final Account account = Get.arguments;

  @override
  void initState() {
    super.initState();
    _c.getProfilePicture(account.fotoProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lihat Profile')),
        body: Obx(() {
          return _c.inProgress.value
              ? Shimmer.fromColors(
                  child: const ShimmerBodyAll(),
                  baseColor: (Colors.grey[300])!,
                  highlightColor: (Colors.grey[100])!)
              : const _Body();
        }));
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Account account = Get.arguments;
    final _c = Get.find<ProfileEditCont>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.065),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          colorFilter:
                              ColorFilter.mode(green, BlendMode.hardLight),
                          image: AssetImage(
                            'assets/images/card_bg.png',
                          ),
                          fit: BoxFit.fill),
                      border: Border.all(color: (Colors.grey[300])!)),
                  child:
                      _checkVerifiStatus(context, account.idStatusVerifikasi),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => _c.profilePictureTap(),
                      child: Obx(
                        () => CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: w(45),
                          foregroundImage: _c.photoWidget.first,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: w(14)),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama',
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
                ),
                TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value == '') {
                        return 'Name can not be empty!';
                      } else {
                        return null;
                      }
                    },
                    controller: _c.nameCont,
                    decoration: mainInputDecoration.copyWith(
                        hintText: 'Masukkan nama')),
                SizedBox(height: w(16)),
                Text(
                  'No Handphone',
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
                ),
                TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == '') {
                        return 'Phone number can not be empty!';
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    controller: _c.phoneCont,
                    keyboardType: TextInputType.number,
                    decoration: mainInputDecoration.copyWith(
                        hintText: 'Enter phone number')),
                SizedBox(height: w(16)),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
                ),
                TextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value == '') {
                        return 'Email can not be empty!';
                      } else {
                        return null;
                      }
                    },
                    controller: _c.emailCont,
                    keyboardType: TextInputType.emailAddress,
                    decoration: mainInputDecoration.copyWith(
                        hintText: 'Email masih kosong')),
                SizedBox(height: w(16)),
                Text(
                  'Tanggal lahir (ex. 1980-11-20)',
                  style: TextStyle(
                      fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
                ),
                TextFormField(
                    readOnly: true,
                    validator: (value) {},
                    controller: _c.dateOfBirthCont,
                    keyboardType: TextInputType.number,
                    decoration: mainInputDecoration.copyWith(
                        hintText: 'Tanggal lahir masih kosong')),
                SizedBox(height: w(16)),
                SubmitButton(
                  backgroundColor: green,
                  text: 'Kembali',
                  onPressed: () => Get.back(),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget _checkVerifiStatus(BuildContext context, String idVerifyStatus) {
  switch (idVerifyStatus) {
    case ('1'):
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: t10,
            size: 15,
          ),
          Text(
            ' Sudah terverifikasi',
            style: TextStyle(
                fontSize: w(12), fontWeight: FontWeight.w600, color: t10),
          ),
        ],
      );
    case ('3'):
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.loop, color: blue, size: 15),
          Text(
            ' Proses verifikasi',
            style: TextStyle(
                fontSize: w(12), fontWeight: FontWeight.w600, color: blue),
          ),
        ],
      );
    default:
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_rounded, color: orange2, size: 15),
          Text(
            ' Belum terverifikasi',
            style: TextStyle(
                fontSize: w(12), fontWeight: FontWeight.w600, color: blue),
          ),
        ],
      );
  }
}
