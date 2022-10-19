import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../tools.dart';

class BtmWarning extends StatelessWidget {
  BtmWarning({
    this.title = '',
    this.message = '',
    this.buttonTittle = '',
    this.icon = Icons.warning,
  });

  final String title;
  final String message;
  final String buttonTittle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Icon(icon, size: 45, color: Colors.red),
          Text(title,
              style: TextStyle(
                  fontSize: 22, color: t100, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 11,
          ),
          Text(message,
              style: TextStyle(
                  fontSize: 16, color: t70, fontWeight: FontWeight.w400)),
          SizedBox(
            height: 27,
          ),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )),
                backgroundColor: MaterialStateProperty.all(green),
              ),
              child: Text(
                buttonTittle,
                style: TextStyle(
                    fontSize: 16, color: t10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class CustomBtmWarning extends StatelessWidget {
  CustomBtmWarning(
      {this.title = '',
      this.message = '',
      this.buttonTittle = '',
      this.icon = Icons.warning,
      this.warna = Colors.red,
      required this.onPress});

  final String title;
  final String message;
  final String buttonTittle;
  final IconData icon;
  final VoidCallback onPress;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          Icon(icon, size: 45, color: warna),
          Text(title,
              style: TextStyle(
                  fontSize: 22, color: t100, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 11,
          ),
          Text(message,
              style: TextStyle(
                  fontSize: 16, color: t70, fontWeight: FontWeight.w400)),
          SizedBox(
            height: 27,
          ),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: onPress,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )),
                backgroundColor: MaterialStateProperty.all(green),
              ),
              child: Text(
                buttonTittle,
                style: TextStyle(
                    fontSize: 16, color: t10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
