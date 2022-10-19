import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EiduInfoDialog extends StatefulWidget {
  final String title;
  final String? icon;
  final String? description;

  const EiduInfoDialog._({
    Key? key,
    this.icon,
    required this.title,
    this.description,
  }) : super(key: key);

  static Future<void> showInfoDialog({
    String? icon,
    required String title,
    String? description,
  }) async =>
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => EiduInfoDialog._(
                title: title,
                icon: icon,
                description: description,
              ));

  @override
  _EiduInfoDialogState createState() => _EiduInfoDialogState();
}

class _EiduInfoDialogState extends State<EiduInfoDialog> {
  @override
  Widget build(BuildContext context) {
    final description = widget.description;
    return GestureDetector(
      onTap: () => Get.back(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
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
            children: <Widget>[
              Lottie.asset(widget.icon ?? 'assets/lottie/warning.json',
                  height: MediaQuery.of(context).size.height * 0.2),
              const SizedBox(height: 20.0),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xff525252),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(height: 12.0),
              if (description != null && description.isNotEmpty)
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff525252),
                    fontSize: 16,
                  ),
                ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}
