import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';

const _fontSize = 12.0;

class VersionWidget extends StatelessWidget {
  const VersionWidget({Key? key}) : super(key: key);

  static Widget numberOnly() => const Center(
      child: Text(appVersion,
          style: TextStyle(
              fontSize: _fontSize, fontWeight: FontWeight.w500, color: t70)));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: w(24),
          child: Image.asset('assets/images/logo_eidupay.png'),
        ),
        const Text(' | ', style: TextStyle(color: t70)),
        const Text(
          'App Version $appVersion',
          style: TextStyle(
              fontSize: _fontSize, fontWeight: FontWeight.w500, color: t70),
        ),
      ],
    );
  }
}
