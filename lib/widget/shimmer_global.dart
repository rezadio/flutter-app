import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';

class ShimmerBodyAll extends StatelessWidget {
  const ShimmerBodyAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: w(50)),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: w(193),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: w(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: w(152),
                height: w(96),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
              Container(
                width: w(152),
                height: w(96),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: h(20)),
          Container(
            width: double.infinity,
            height: w(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
          SizedBox(height: h(20)),
          Container(
            width: double.infinity,
            height: w(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
          SizedBox(height: h(20)),
          Container(
            width: double.infinity,
            height: w(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
        ],
      ),
    ));
  }
}
