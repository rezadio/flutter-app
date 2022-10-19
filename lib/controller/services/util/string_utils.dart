import 'package:intl/intl.dart';

class StringUtils {
  static String stringToIdr(String number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(int.parse(number));
  }

  static String minifyDate(String date) {
    return date.split('.')[0];
  }

  static String getMonth(String periode) {
    return DateFormat('MMMM').format(DateTime(0, int.parse(periode)));
  }

  static String stringToThousands(String value) {
    var formatter = NumberFormat('#,##0');
    return formatter.format(int.parse(value));
  }

  static String stringToSecureHalfText(String value) {
    List<String> arrayText = value.split(' ');
    String resp = '';
    for (var i = 0; i < arrayText.length; i++) {
      num length = arrayText[i].length / 2;
      String secure = arrayText[i].substring(0, length.round());
      for (var i = 0; i < length.floor(); i++) {
        secure += '*';
      }
      resp += ' ' + secure;
    }
    return resp;
  }

  static String stringToSecureFullText(String value) {
    List<String> arrayText = value.split(' ');
    String resp = '';
    for (var i = 0; i < arrayText.length; i++) {
      num length = arrayText[i].length;
      String secure = '';
      for (var i = 0; i < length; i++) {
        secure += '*';
      }
      resp += ' ' + secure;
    }
    return resp;
  }

  static String stringToErrorMessage(String value) {
    String result = value;
    if (value.contains(']')) {
      List<String> splitted = value.split(' ');
      result = '';
      for (var i = 0; i < splitted.length; i++) {
        if (i > 1) {
          result += ' ' + splitted[i];
        }
      }
      result = result.substring(1);
    }

    return result;
  }

  static String stringToFixPhoneNumber(String value) {
    String result = value;

    if (value.contains('62')) {
      if (value.contains('+')) {
        result = '';
        result = '0' + value.substring(3).replaceAll(' ', '');
        result = result.replaceAll('-', '');
      } else {
        result = '';
        result = '0' + value.substring(2).replaceAll(' ', '');
        result = result.replaceAll('-', '');
      }
    }
    return result;
  }

  static String stringToNumber(String value) {
    var str = value.replaceAll(',', '');
    return str;
  }

  static String toTitleCase(String str) {
    return str.toLowerCase().replaceAllMapped(
        RegExp(
            r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
        (Match match) {
      // ignore: prefer_single_quotes
      return "${match[0]![0].toUpperCase()}${match[0]!.substring(1).toLowerCase()}";
    }).replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}
