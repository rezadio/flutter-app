import 'package:eidupay/controller/sub_account/sub_account_on_board_controller.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class SubAccountOnBoardPage extends StatelessWidget {
  static final route = GetPage(
      name: '/sub-account/initial/', page: () => SubAccountOnBoardPage());

  const SubAccountOnBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: const Scaffold(
        backgroundColor: green,
        body: _BodySubAccountOnBoardPage(),
      ),
    );
  }
}

class _BodySubAccountOnBoardPage extends StatefulWidget {
  const _BodySubAccountOnBoardPage({Key? key}) : super(key: key);

  @override
  __BodySubAccountOnBoardPageState createState() =>
      __BodySubAccountOnBoardPageState();
}

class __BodySubAccountOnBoardPageState
    extends State<_BodySubAccountOnBoardPage> {
  final _c = Get.put(SubAccountOnBoardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Image.asset('assets/images/extended-0.png'),
            SizedBox(height: 25),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: Color(0xFF377775),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(4, 4))
                ],
              ),
              child: Center(
                child: Text(
                  'Extended User',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              _c.textContent.first,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 25),
            Text(
              'Langsung aja cobain.\nMengapa?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Column(children: _getContent()),
            SizedBox(height: 25),
            SubmitButton(
              backgroundColor: Colors.white,
              text: 'Coba Sekarang',
              fontSize: 20,
              textColor: green,
              onPressed: () => _c.toSubAccountList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getContent() {
    final contents = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      contents.add(
        _ContentWidget(
          imageUrl: 'assets/images/extended-$i.png',
          text: _c.textContent[i],
        ),
      );
    }
    return contents;
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key, required this.imageUrl, required this.text})
      : super(key: key);

  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Image.asset(imageUrl, height: 180),
          SizedBox(height: 25),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
