import 'package:flutter/material.dart';
import 'package:eidupay/tools.dart';

class SmallDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  const SmallDivider(
      {Key? key, this.height = 3, this.width = 28, this.color = green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: height, width: width, color: color);
  }
}
