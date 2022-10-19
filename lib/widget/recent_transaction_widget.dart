import 'package:eidupay/controller/services/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';

class RecentTransactionWidget extends StatelessWidget {
  final String title;
  final String id;
  final String date;
  final String price;

  const RecentTransactionWidget({
    Key? key,
    required this.title,
    required this.id,
    required this.date,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12, color: t80, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  id,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  StringUtils.minifyDate(date),
                  style: const TextStyle(
                      fontSize: 12, color: t60, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  StringUtils.stringToIdr(price),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: blue),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 30, color: t60),
      ],
    );
  }
}
