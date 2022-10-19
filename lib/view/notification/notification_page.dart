import 'package:eidupay/controller/notification/notification_controller.dart';
import 'package:eidupay/model/message.dart';
import 'package:eidupay/model/notification.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/app_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  static final route =
      GetPage(name: '/notification/', page: () => const NotificationPage());

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Notifikasi')),
        body: const _BodyNotificationPage());
  }
}

class _BodyNotificationPage extends StatefulWidget {
  const _BodyNotificationPage({Key? key}) : super(key: key);

  @override
  _BodyNotificationPageState createState() => _BodyNotificationPageState();
}

class _BodyNotificationPageState extends State<_BodyNotificationPage>
    with SingleTickerProviderStateMixin {
  final _c = Get.put(NotificationController(injector.get()));
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _c.refreshAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [Tab(text: 'Notifikasi'), Tab(text: 'Pesan')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Obx(
                  () => (_c.isNotifLoaded.value == false)
                      ? const Center(child: CircularProgressIndicator())
                      : (_c.notificationDatas.isEmpty)
                          ? const Center(child: Text('Data Notifikasi Kosong'))
                          : SmartRefresher(
                              controller: _c.notificationRefreshController,
                              onRefresh: () async =>
                                  await _c.refreshNotification(),
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(15),
                                  itemCount: _c.notificationDatas.length,
                                  itemBuilder: (context, index) {
                                    final notificationData =
                                        _c.notificationDatas[index];
                                    return _NotificationCard(
                                        notificationData: notificationData,
                                        onTap: () =>
                                            _c.notifTap(notificationData));
                                  }),
                            ),
                ),
                Obx(
                  () => (_c.isMessageLoaded.value == false)
                      ? const Center(child: CircularProgressIndicator())
                      : (_c.dataMessages.isEmpty)
                          ? const Center(child: Text('Data Kosong'))
                          : SmartRefresher(
                              controller: _c.messageRefreshController,
                              onRefresh: () async => await _c.refreshMessage(),
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(15),
                                  itemCount: _c.dataMessages.length,
                                  itemBuilder: (context, index) {
                                    return _MessageCard(
                                      dataMessage: _c.dataMessages[index],
                                    );
                                  }),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationData notificationData;
  final void Function()? onTap;
  const _NotificationCard(
      {Key? key, required this.notificationData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _createdAt = notificationData.createdAt;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: (notificationData.read == false)
                  ? const Color(0xffebffed)
                  : Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notificationData.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        notificationData.body,
                        softWrap: true,
                        style: const TextStyle(color: t80, fontSize: 16),
                      ),
                      if (_createdAt != null) const SizedBox(height: 3),
                      if (_createdAt != null)
                        Text(
                          DateFormat.yMMMMd('in_ID')
                              .add_jm()
                              .format(_createdAt),
                          style: const TextStyle(color: t80, fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 20)
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  final DataMessage dataMessage;
  final baseUrl = injector.get<AppConfig>().port;
  _MessageCard({Key? key, required this.dataMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: h(150),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          '$baseUrl:$port/image/register_agent/${dataMessage.img}'),
                      fit: BoxFit.fitHeight),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataMessage.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    dataMessage.body,
                    softWrap: true,
                    style: const TextStyle(color: t80, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 20)
      ],
    );
  }
}
