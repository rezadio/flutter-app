import 'package:eidupay/app_config.dart';
import 'package:eidupay/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initiateApp(const AppConfig.dev());
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const MyApp()));
}
