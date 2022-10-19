import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSingleRowCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final int? valueSize;
  final bool? copyable;

  const CustomSingleRowCard(
      {Key? key,
      required this.title,
      required this.value,
      this.valueColor,
      this.valueSize,
      this.copyable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool copyText = false;
    if (copyable != null) {
      copyText = true;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: copyText
                ? GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: valueColor,
                            fontSize: w(valueSize ?? 13),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Icon(
                          Icons.content_copy,
                          size: 17,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: value.toString().substring(15)));
                      Fluttertoast.showToast(
                          msg: 'Berhasil Disalin',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                  )
                : Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: w(valueSize ?? 14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class CustomSingleRowSelectableTextCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final int? valueSize;

  const CustomSingleRowSelectableTextCard(
      {Key? key,
      required this.title,
      required this.value,
      this.valueColor,
      this.valueSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: w(14), fontWeight: FontWeight.w400, color: t60),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SelectableText(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: valueColor,
                fontSize: w(valueSize ?? 14),
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
