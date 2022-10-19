import 'package:eidupay/controller/topup/topup_bank_info_cont.dart';
import 'package:eidupay/widget/small_bullet_list.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TopupBankInfo extends StatefulWidget {
  const TopupBankInfo({Key? key}) : super(key: key);

  static var route = GetPage(name: '/topup-bank', page: () => TopupBankInfo());

  @override
  _TopupBankInfoState createState() => _TopupBankInfoState();
}

class _TopupBankInfoState extends State<TopupBankInfo> {
  final _c = Get.put(TopupBankInfoCont());
  final Map<String, dynamic> dataBank = Get.arguments;
  late List<String> atmInstructions;
  late List<String> mobileBankingInstructions;

  @override
  void initState() {
    super.initState();
    atmInstructions = _c.getAtmInstruction(dataBank['name']);
    mobileBankingInstructions =
        _c.getMobileBankingInstruction(dataBank['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bank transfer')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(dataBank['icon'] ?? dataBank['img'].first,
                    fit: BoxFit.fitWidth),
              ),
              SmallDivider(),
              SizedBox(height: h(24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Virtual account number',
                        style: TextStyle(
                            fontSize: w(16),
                            fontWeight: FontWeight.w400,
                            color: t90),
                      ),
                      SizedBox(height: h(8)),
                      Text(
                        _c.checkVirtualAccNo(dataBank),
                        style: TextStyle(
                            fontSize: w(24),
                            fontWeight: FontWeight.w500,
                            color: t90),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _c.copyData(_c.checkVirtualAccNo(dataBank)),
                    child: Container(
                      width: w(50),
                      height: w(50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: green.withOpacity(0.2)),
                      child: Icon(Icons.copy, color: Colors.green),
                    ),
                  )
                ],
              ),
              SizedBox(height: h(32)),
              Row(
                children: [
                  SmallBulletList(),
                  SizedBox(width: w(10)),
                  Text(
                    'Maximum Balance - ',
                    style: TextStyle(
                        fontSize: w(12),
                        fontWeight: FontWeight.w500,
                        color: t100),
                  ),
                  Text(
                    _c.maxBalance(),
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
                  SmallBulletList(),
                  SizedBox(width: w(10)),
                  Text(
                    'Maximum Topup - ',
                    style: TextStyle(
                        fontSize: w(12),
                        fontWeight: FontWeight.w500,
                        color: t100),
                  ),
                  Text(
                    'Rp ${_c.maxTopUp()}',
                    style: TextStyle(
                        fontSize: w(12),
                        fontWeight: FontWeight.bold,
                        color: t100),
                  ),
                ],
              ),
              SizedBox(height: h(37)),
              Text(
                'INSTRUCTION',
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.bold, color: t90),
              ),
              SizedBox(height: h(27)),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: atmInstructions.length,
                  itemBuilder: (context, index) => _InstructionContainer(
                      index: index, instructions: atmInstructions)),
              SizedBox(height: h(28)),
              if (mobileBankingInstructions.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile Banking & Internet Banking \nINSTRUCTION',
                      style: TextStyle(
                          fontSize: w(14),
                          fontWeight: FontWeight.bold,
                          color: t100),
                    ),
                    SizedBox(height: h(27)),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: mobileBankingInstructions.length,
                        itemBuilder: (context, index) => _InstructionContainer(
                            index: index,
                            instructions: mobileBankingInstructions)),
                  ],
                ),
              SizedBox(height: h(28)),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionContainer extends StatelessWidget {
  final int index;
  final List<String> instructions;

  const _InstructionContainer(
      {Key? key, required this.index, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              child: Text(
                'Step ${index + 1}',
                style: TextStyle(
                    fontSize: w(12), fontWeight: FontWeight.w300, color: t60),
              ),
            ),
            SizedBox(width: 20),
            Flexible(
              child: Text(
                instructions[index],
                style: TextStyle(
                    fontSize: w(14), fontWeight: FontWeight.w400, color: t90),
              ),
            ),
          ],
        ),
        if (index + 1 < instructions.length) SizedBox(height: h(16))
      ],
    );
  }
}
