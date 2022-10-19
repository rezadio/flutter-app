import 'package:eidupay/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class NotificationInfoDetailPage extends StatefulWidget {
  static final route = GetPage(
      name: '/notification/info/:id',
      page: () => const NotificationInfoDetailPage());
  const NotificationInfoDetailPage({Key? key}) : super(key: key);

  @override
  _NotificationInfoDetailPageState createState() =>
      _NotificationInfoDetailPageState();
}

class _NotificationInfoDetailPageState
    extends State<NotificationInfoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi')),
      body: const _BodyNotificationInfoDetailPage(),
    );
  }
}

class _BodyNotificationInfoDetailPage extends StatefulWidget {
  const _BodyNotificationInfoDetailPage({Key? key}) : super(key: key);

  @override
  _BodyNotificationInfoDetailPageState createState() =>
      _BodyNotificationInfoDetailPageState();
}

class _BodyNotificationInfoDetailPageState
    extends State<_BodyNotificationInfoDetailPage> {
  NotifInfo notifInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notifInfo.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(notifInfo.body, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
