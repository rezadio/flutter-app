import 'package:flutter/material.dart';

import '../tools.dart';

class SmallBulletList extends StatelessWidget {
  const SmallBulletList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: const BoxDecoration(
        color: darkBlue,
        shape: BoxShape.circle,
      ),
    );
  }
}