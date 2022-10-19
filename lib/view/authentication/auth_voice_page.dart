import 'package:eidupay/view/authentication/auth_pin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthVoicePage extends StatefulWidget {
  static final route =
      GetPage(name: '/auth-voice', page: () => AuthVoicePage());
  const AuthVoicePage({Key? key}) : super(key: key);

  @override
  _AuthVoicePageState createState() => _AuthVoicePageState();
}

class _AuthVoicePageState extends State<AuthVoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BodyAuthVoicePage(),
    );
  }
}

class _BodyAuthVoicePage extends StatefulWidget {
  const _BodyAuthVoicePage({
    Key? key,
  }) : super(key: key);

  @override
  __BodyAuthVoicePageState createState() => __BodyAuthVoicePageState();
}

class __BodyAuthVoicePageState extends State<_BodyAuthVoicePage> {
  @override
  void initState() {
    super.initState();
  }

  String resultText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Spacer(),
            Column(
              children: [
                Text(
                  'Log in with Voice',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                Image(
                  height: 142,
                  image: AssetImage('assets/images/microphone.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Please record your voice to log in',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'or',
                    style: TextStyle(
                        color: Color(0xFF878DBA),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextButton(
                    child: Text(
                      'Use login pin',
                      style: TextStyle(
                          color: Color(0xFF004B84),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () async {
                      Get.to(() => AuthPinPage());
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Image(
                width: 113,
                image: AssetImage('assets/images/logo_eidupay.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
