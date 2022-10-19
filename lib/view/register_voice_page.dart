import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterVoicePage extends StatefulWidget {
  static final route = GetPage(
      name: '/sub-account/:id/edit/voice', page: () => RegisterVoicePage());
  const RegisterVoicePage({Key? key}) : super(key: key);

  @override
  _RegisterVoicePageState createState() => _RegisterVoicePageState();
}

class _RegisterVoicePageState extends State<RegisterVoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Authentication'),
      ),
      body: _BodyRegisterVoicePage(),
    );
  }
}

class _BodyRegisterVoicePage extends StatefulWidget {
  const _BodyRegisterVoicePage({Key? key}) : super(key: key);

  @override
  _BodyRegisterVoicePageState createState() => _BodyRegisterVoicePageState();
}

class _BodyRegisterVoicePageState extends State<_BodyRegisterVoicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          Text(
            'Register your Voice',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Image(image: AssetImage('assets/images/microphone.png')),
          SizedBox(height: 30),
          Text(
            'Please record your voice to authenticate this account',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Spacer(),
          Image(
            height: 40,
            image: AssetImage('assets/images/logo_eidupay.png'),
          )
        ],
      ),
    ));
  }
}
