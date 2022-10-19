import 'package:intl/intl.dart';

extension IntExtention on num {
  String get amountFormat => NumberFormat.decimalPattern().format(this);
}
