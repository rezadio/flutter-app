import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';

class EiduSaldoCard extends StatelessWidget {
  final String saldo;
  const EiduSaldoCard({Key? key, required this.saldo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: double.infinity,
      height: 64,
      decoration: const BoxDecoration(
        color: green,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: AssetImage('assets/images/card_bg.png'),
            fit: BoxFit.fitWidth),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Saldo',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w800, color: t10),
          ),
          Text('Rp $saldo',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
