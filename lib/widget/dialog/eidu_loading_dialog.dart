import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:lottie/lottie.dart';

class EiduLoadingDialog extends StatefulWidget {
  const EiduLoadingDialog._({Key? key}) : super(key: key);

  static void showLoadingDialog() => showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (context) => const EiduLoadingDialog._());

  @override
  State<EiduLoadingDialog> createState() => _EiduLoadingDialogState();
}

class _EiduLoadingDialogState extends State<EiduLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset('assets/lottie/loading.json',
                height: MediaQuery.of(context).size.height * 0.2),
            const Text(
              'Mohon Menunggu...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff525252),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
