import 'package:eidupay/controller/invest/portfolio_controller.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/extension.dart';
import 'package:expandable/expandable.dart';

class PortfolioPage extends StatefulWidget {
  static final route =
      GetPage(name: '/invest/portfolio/:id', page: () => PortfolioPage());

  const PortfolioPage({Key? key}) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      body: _BodyPortfolioPage(),
    );
  }
}

class _BodyPortfolioPage extends StatefulWidget {
  const _BodyPortfolioPage({Key? key}) : super(key: key);

  @override
  _BodyPortfolioPageState createState() => _BodyPortfolioPageState();
}

class _BodyPortfolioPageState extends State<_BodyPortfolioPage> {
  final _getController = Get.put(PortfolioController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 2, color: t30)),
          child: Row(
            children: [
              Image(image: AssetImage('assets/images/vw.png')),
              SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet conse ctetur Pvt. Ltd',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: h(4)),
                    Text(
                      'Mutual Funds',
                      style: TextStyle(
                          color: t60,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: h(16)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Profit',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: t60),
                ),
                Text(
                  ('+5.09%'),
                  style: TextStyle(
                      color: ('+5.09%').contains('+')
                          ? green
                          : ('+5.09%').contains('-')
                              ? red
                              : t60,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invested Amount',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: t60),
                ),
                Text(
                  'Rp ' + 245000.amountFormat,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: blue),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profit Amount',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: t60),
                ),
                Text(
                  'Rp ' + 4000.amountFormat,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: blue),
                )
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: h(32)),
          height: MediaQuery.of(context).size.height * 0.35,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(drawVerticalLine: false),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: SideTitles(showTitles: false),
                topTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  interval: 1,
                  getTextStyles: (context, value) => const TextStyle(
                      color: t50, fontWeight: FontWeight.bold, fontSize: 12),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 1:
                        return '14:5';
                      case 3:
                        return '18:4';
                      case 5:
                        return '22:3';
                      case 7:
                        return '02:2';
                      case 9:
                        return '06:1';
                      case 11:
                        return '10:3';
                    }
                    return '';
                  },
                  margin: 0,
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTextStyles: (context, value) => const TextStyle(
                    color: t50,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 1:
                        return '43,8';
                      case 3:
                        return '44,0';
                      case 5:
                        return '44,2';
                      case 7:
                        return '44,4';
                    }
                    return '';
                  },
                  reservedSize: 32,
                  margin: 12,
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 8,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 3),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 3.1),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  colors: [green, green],
                  isCurved: false,
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 30,
          width: double.infinity,
          child: Center(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: time.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => _TimeWidget(
                      time: time[index],
                      isSelected: _getController.timeToggle.contains(index)
                          ? true
                          : false,
                      onTap: () {
                        if (_getController.timeToggle.isNotEmpty) {
                          _getController.timeToggle.clear();
                          _getController.timeToggle.add(index);
                          return;
                        }
                        _getController.timeToggle.add(index);
                      },
                    ),
                  );
                }),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: ExpandableNotifier(
            child: ScrollOnExpand(
              child: ExpandablePanel(
                collapsed: Container(),
                header: Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: t40)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                              color: t60,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: t60,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: t40)),
                    ),
                  ),
                ]),
                theme: ExpandableThemeData(
                  hasIcon: false,
                  tapHeaderToExpand: true,
                  animationDuration: Duration(milliseconds: 500),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 325,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Manager Investasi',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: h(17)),
                                      Flexible(
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/dbs_bank.png'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bank Kustodian',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: h(17)),
                                      Flexible(
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/icici_bank.png'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: 0),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tingkat Risiko',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Rendah',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Dana Kelolaan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Rp 39.13 Milyar',
                                        style: TextStyle(
                                            color: blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Minimal Pembelian',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Rp ' + 10000.amountFormat,
                                        style: TextStyle(
                                            color: blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Minimal Pejualan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Rp ' + 10000.amountFormat,
                                        style: TextStyle(
                                            color: blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Biaya Penjualan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Gratis',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Biaya Penjualan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: t60,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Gratis',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SubmitButton(
                                    hasBorderSide: true,
                                    iconUrl: 'assets/images/pdf.png',
                                    text: 'Prospectus',
                                    fontSize: 14,
                                    borderRadius: 10,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: SubmitButton(
                                    hasBorderSide: true,
                                    iconUrl: 'assets/images/pdf.png',
                                    text: 'Balance Sheet',
                                    fontSize: 12,
                                    borderRadius: 10,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SubmitButton(
                iconUrl: 'assets/images/receive_square.png',
                text: 'Sell',
                backgroundColor: red,
                borderRadius: 10,
                onPressed: () {},
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SubmitButton(
                iconUrl: 'assets/images/send_square.png',
                text: 'Buy',
                backgroundColor: green,
                borderRadius: 10,
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class _TimeWidget extends StatelessWidget {
  final String time;
  final void Function() onTap;
  final bool? isSelected;

  const _TimeWidget({
    Key? key,
    required this.time,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 46,
        height: 30,
        decoration: BoxDecoration(
            border: isSelected == true
                ? Border.all(color: blue, width: 1)
                : Border.fromBorderSide(BorderSide.none),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        duration: Duration(milliseconds: 200),
        child: Center(
            child: Text(
          time,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isSelected == true ? Color(0xFF6162FB) : t80),
        )),
      ),
    );
  }
}

final time = ['1H', '1D', '1W', '1M', '6M', '1Y', 'ALL'];
