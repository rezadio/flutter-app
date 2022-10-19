import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TransferWithdrawalPage extends StatefulWidget {
  static final route =
      GetPage(name: '/withdrawal/', page: () => TransferWithdrawalPage());
  const TransferWithdrawalPage({Key? key}) : super(key: key);

  @override
  _TransferWithdrawalPageState createState() => _TransferWithdrawalPageState();
}

class _TransferWithdrawalPageState extends State<TransferWithdrawalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal'),
      ),
      body: _BodyTransferWithdrawalPage(),
    );
  }
}

class _BodyTransferWithdrawalPage extends StatelessWidget {
  _BodyTransferWithdrawalPage({Key? key}) : super(key: key);

  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static const mySelf = 'diri-sendiri';
  static const others = 'lainnya';

  @override
  Widget build(BuildContext context) {
    String _name(String text) =>
        text.split('-').map((e) => e.capitalizeFirst).join(' ');

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kemana akan\nmelakukan penarikan?',
            style: TextStyle(fontSize: w(24), fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Jumlah',
            style: TextStyle(fontSize: w(16), fontWeight: FontWeight.bold),
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _amountController,
              decoration: underlineInputDecoration.copyWith(hintText: '0.00'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          _CustomCard(
            text: _name(mySelf),
            icon: Image(
              image: AssetImage('assets/images/user_square.png'),
            ),
            color: green,
            onPressed: () {
              Get.toNamed('/withdrawal/$mySelf');
            },
          ),
          SizedBox(
            height: 20,
          ),
          _CustomCard(
            text: _name(others),
            icon: Image(
              image: AssetImage('assets/images/tag_user.png'),
            ),
            color: blue,
            onPressed: () {
              Get.toNamed('/withdrawal/$others');
            },
          ),
        ],
      ),
    ));
  }
}

class _CustomCard extends StatelessWidget {
  final Color? color;
  final String text;
  final Widget icon;
  final VoidCallback? onPressed;

  const _CustomCard({
    Key? key,
    this.color,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: color?.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Row(
          children: [
            SizedBox(
              width: w(28),
            ),
            Container(
              height: 45,
              width: 45,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: icon,
            ),
            SizedBox(
              width: w(38),
            ),
            Text(
              text,
              style: TextStyle(fontSize: w(18), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
