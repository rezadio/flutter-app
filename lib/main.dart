import 'dart:io';

import 'package:eidupay/app_config.dart';
import 'package:eidupay/component/page_route.dart';
import 'package:eidupay/eidupay_module.dart';
import 'package:eidupay/view/notification/notification_page.dart';
import 'package:eidupay/view/opening.dart';
import 'package:eidupay/tools.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intl/date_symbol_data_local.dart';

final GetIt injector = GetIt.instance;
final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const _initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');
const _initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true);
const _initializationSettings = InitializationSettings(
    android: _initializationSettingsAndroid, iOS: _initializationSettingsIOS);

Future<void> _initiateLocalNotification() async =>
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: (payload) async {
      if (payload != null) {
        debugPrint('Notification Payload: $payload');
      }
    });

late AndroidNotificationChannel _channel;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
}

Future<void> initiateApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('in_ID');
  await _initiateLocalNotification();
  HttpOverrides.global = _MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();

  //Inject Module
  EidupayModule.injectModule(appConfig);

  debugPrint('in ${injector.get<AppConfig>().name} environment.');

  if (!kIsWeb) {
    _channel = const AndroidNotificationChannel(
      'notif_channel', // id
      'Notification Channel', // title
      description:
          'This channel is used for notification channel.', // description
      importance: Importance.high,
      playSound: true,
    );

    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final _name = injector.get<AppConfig>().name;

  @override
  void initState() {
    super.initState();
    messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      debugPrint('Message data: ${message.data}');

      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
          _channel.id, _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true);
      const iOSPlatformChannelSpecifics = IOSNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true);
      final platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

      if (notification != null && !kIsWeb) {
        debugPrint('Contain a notification: ${message.notification!.title}');
        _flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, platformChannelSpecifics);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('notif pressed aaa' + message.data.toString());
      Get.toNamed(NotificationPage.route.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: (_name == 'dev') ? true : false,
      navigatorObservers: <NavigatorObserver>[observer],
      getPages: pages,
      title: 'Eidupay',
      navigatorKey: navigatorKey,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              iconTheme: IconThemeData(color: blue),
              backgroundColor: Colors.transparent,
              elevation: 0),
          primarySwatch: createMaterialColor(green),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme),
          sliderTheme: const SliderThemeData(
              valueIndicatorColor: Colors.transparent,
              valueIndicatorShape: RectangularSliderValueIndicatorShape(),
              valueIndicatorTextStyle: TextStyle(fontSize: 16, color: t90))),
      initialRoute: OpenInit.route.name,
    );
  }
}

class _MyHttpOverrides extends HttpOverrides {
  bool _certificateCheck(X509Certificate cert, String host, int port) =>
      host == '45.64.96.43' || host == '45.64.96.45';

  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = _certificateCheck;
}
