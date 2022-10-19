import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SupportType { email, phone, chat }

class SupportController extends GetxController {
  final supportContent = <Map<String, dynamic>>[
    {
      'icon': Icons.phone,
      'title': 'Call Center',
      'body': '021 799444',
      'type': SupportType.phone,
    },
    {
      'icon': Icons.email,
      'title': 'E-mail',
      'body': 'support@eidupay.com',
      'type': SupportType.email,
    },
    {
      'icon': Icons.chat,
      'title': 'WhatsApp',
      'body': '0811-9007-911',
      'type': SupportType.chat,
    },
  ];
}
