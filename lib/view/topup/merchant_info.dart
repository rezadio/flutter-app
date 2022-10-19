import 'package:eidupay/controller/topup/merchant_info_cont.dart';
import 'package:eidupay/view/home_page.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/dash_line_divider.dart';
import 'package:eidupay/widget/small_bullet_list.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class MerchantInfo extends StatelessWidget {
  const MerchantInfo({Key? key, required this.listMerchant}) : super(key: key);
  static final route = GetPage(
      name: '/merchant_info', page: () => const MerchantInfo(listMerchant: {}));

  final Map<String, dynamic> listMerchant;
  @override
  Widget build(BuildContext context) {
    final _c = Get.put(MerchantInfoCont());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchant & Partner'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              width: w(59),
              height: w(59),
              //color: Colors.red,
              child: Image.asset(
                listMerchant['img'],
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: h(10)),
            const SmallDivider(),
            SizedBox(height: h(24)),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Payment Code Generated',
                      style: TextStyle(
                          fontSize: w(16),
                          fontWeight: FontWeight.w400,
                          color: t90),
                    ),
                    SizedBox(height: h(8)),
                    Text(
                      listMerchant['va'],
                      style: TextStyle(
                          fontSize: w(24),
                          fontWeight: FontWeight.w500,
                          color: t90),
                    )
                  ],
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () => _c.copyData(listMerchant['va']),
                  child: Container(
                    width: w(50),
                    height: w(50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: green.withOpacity(0.2)),
                    child: Image.asset('assets/images/ico_copy.png'),
                  ),
                )
              ],
            ),
            SizedBox(height: h(32)),
            Row(
              children: [
                const SmallBulletList(),
                SizedBox(width: w(10)),
                Text(
                  'Maximum Balance - ',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.w500,
                      color: t100),
                ),
                Text(
                  'Rp 2.000.000',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.bold,
                      color: t100),
                ),
              ],
            ),
            SizedBox(height: h(24)),
            Row(
              children: [
                const SmallBulletList(),
                SizedBox(width: w(10)),
                Text(
                  'Maximum Topup - ',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.w500,
                      color: t100),
                ),
                Text(
                  'Rp 2.000.000',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.bold,
                      color: t100),
                ),
              ],
            ),
            SizedBox(height: h(24)),
            Row(
              children: [
                const SmallBulletList(),
                SizedBox(width: w(10)),
                Text(
                  'Sit corporis autem ipsum molestiae facilis.',
                  style: TextStyle(
                      fontSize: w(12),
                      fontWeight: FontWeight.w500,
                      color: t100),
                ),
              ],
            ),
            SizedBox(height: h(37)),
            Text(
              'INSTRUCTION',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w500, color: t90),
            ),
            SizedBox(height: h(27)),
            instruction(context, 'Step 01', 'Lacus, tellus in'),
            SizedBox(height: h(16)),
            instruction(context, 'Step 02', 'Viverra ut interdum'),
            SizedBox(height: h(16)),
            instruction(context, 'Step 03', 'Vitae adipiscing facilisis'),
            SizedBox(height: h(16)),
            instruction(context, 'Step 04', 'Nibh orci suspendisse'),
            SizedBox(height: h(16)),
            instruction(context, 'Step 05', 'Natoque odio velit'),
            SizedBox(height: h(53)),
            const DashLineDivider(),
            SizedBox(height: h(27)),
            Row(
              children: [
                const Icon(Icons.warning, color: orange1, size: 20),
                Text(
                  ' Caution',
                  style: TextStyle(
                      fontSize: w(14),
                      fontWeight: FontWeight.w500,
                      color: t100),
                ),
              ],
            ),
            SizedBox(height: h(8)),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Arcu amet non congue pellentesque posuere nisl purus. Neque ornare felis pharetra ac sit. Metus sagittis id neque imperdiet commodo tortor sapien in.',
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w400, color: t60),
              ),
            ),
            SizedBox(height: h(32)),
            Text(
              'How to do ?',
              style: TextStyle(
                  fontSize: w(14), fontWeight: FontWeight.w500, color: t90),
            ),
            SizedBox(height: h(32)),
            SizedBox(
              width: double.infinity,
              height: w(173),
              child: ClipRRect(
                child: Image.asset('assets/images/tmp_video1.png'),
              ),
            ),
            SizedBox(height: h(20)),
            SubmitButton(
              backgroundColor: green,
              text: 'Back to home',
              onPressed: () {
                Get.offNamed(Home.route.name);
              },
            ),
            SizedBox(height: h(60)),
          ],
        ),
      )),
    );
  }

  Widget instruction(BuildContext context, String step, String desc) {
    return Row(
      children: [
        Text(
          step,
          style: TextStyle(
              fontSize: w(12), fontWeight: FontWeight.w300, color: t60),
        ),
        const SizedBox(width: 20),
        Text(
          desc,
          style: TextStyle(
              fontSize: w(14), fontWeight: FontWeight.w400, color: t90),
        ),
      ],
    );
  }
}
