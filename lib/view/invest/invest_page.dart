import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/extension.dart';

class InvestPage extends StatefulWidget {
  static final route = GetPage(name: '/invest/', page: () => InvestPage());

  const InvestPage({Key? key}) : super(key: key);

  @override
  _InvestPageState createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          height: w(35),
          image: AssetImage('assets/images/logo_eidupay.png'),
        ),
      ),
      body: _BodyInvestPage(),
    );
  }
}

class _BodyInvestPage extends StatefulWidget {
  const _BodyInvestPage({Key? key}) : super(key: key);

  @override
  _BodyInvestPageState createState() => _BodyInvestPageState();
}

class _BodyInvestPageState extends State<_BodyInvestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      children: [
        Image(image: AssetImage('assets/images/sample_card.png')),
        Padding(
          padding: EdgeInsets.symmetric(vertical: h(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Investing Options',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h(17)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InvestingOption(
                    title: 'Stocks',
                    iconUrl: 'assets/images/ico_invest.png',
                    color: green,
                    onTap: () {},
                  ),
                  _InvestingOption(
                    title: 'Forex',
                    iconUrl: 'assets/images/forex.png',
                    color: orange1,
                    onTap: () {},
                  ),
                  _InvestingOption(
                    title: 'Crypto',
                    iconUrl: 'assets/images/crypto.png',
                    color: red,
                    onTap: () {},
                  ),
                  _InvestingOption(
                    title: 'Gold',
                    iconUrl: 'assets/images/gold_bars.png',
                    color: blue,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: w(120),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _sampleCardList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == _sampleCardList.length - 1
                    ? EdgeInsets.all(0)
                    : EdgeInsets.only(right: 17),
                child: _sampleCardList[index],
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: h(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Portfolio',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h(16)),
              _PortfolioCard(
                iconUrl: 'assets/images/vw.png',
                companyName: 'Lorem ipsum dolor sit amet conse ctetur Pvt. Ltd',
                type: 'Mutual Funds',
                monthlyProfit: '+5.09%',
                investedAmount: 245000.amountFormat,
                profitAmount: 4000.amountFormat,
                onTap: () {
                  Get.toNamed('/invest/portfolio/1');
                },
              ),
              SizedBox(height: h(16)),
              _PortfolioCard(
                iconUrl: 'assets/images/gulf.png',
                companyName: 'Lorem ipsum dolor sit amet conse ctetur Pvt. Ltd',
                type: 'Mutual Funds',
                monthlyProfit: '-8.06%',
                investedAmount: 245000.amountFormat,
                profitAmount: 4000.amountFormat,
                onTap: () {
                  Get.toNamed('/invest/portfolio-2/2');
                },
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: h(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Watchlist',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h(16)),
              _PortfolioCard(
                iconUrl: 'assets/images/vw.png',
                companyName: 'Lorem ipsum dolor sit amet conse ctetur Pvt. Ltd',
                type: 'Mutual Funds',
                monthlyProfit: '+5.09%',
                investedAmount: 245000.amountFormat,
                profitAmount: 4000.amountFormat,
                onTap: () {
                  Get.toNamed('/invest/portfolio/1');
                },
              ),
              SizedBox(height: h(16)),
              _PortfolioCard(
                iconUrl: 'assets/images/gulf.png',
                companyName: 'Lorem ipsum dolor sit amet conse ctetur Pvt. Ltd',
                type: 'Mutual Funds',
                monthlyProfit: '-8.06%',
                investedAmount: 245000.amountFormat,
                profitAmount: 4000.amountFormat,
                onTap: () {
                  Get.toNamed('/invest/portfolio-2/2');
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class _PortfolioCard extends StatelessWidget {
  final String iconUrl;
  final String companyName;
  final String type;
  final String monthlyProfit;
  final String investedAmount;
  final String profitAmount;
  final void Function()? onTap;

  const _PortfolioCard({
    Key? key,
    required this.iconUrl,
    required this.companyName,
    required this.type,
    required this.monthlyProfit,
    required this.investedAmount,
    required this.profitAmount,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 2, color: t30)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image(height: 43, image: AssetImage(iconUrl)),
                      SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companyName,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: h(4)),
                            Text(
                              type,
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
                Divider(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monthly Profit',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: t60),
                          ),
                          Text(
                            monthlyProfit,
                            style: TextStyle(
                                color: monthlyProfit.contains('+')
                                    ? green
                                    : monthlyProfit.contains('-')
                                        ? red
                                        : t60,
                                fontSize: 12,
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
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: t60),
                          ),
                          Row(
                            children: [
                              Text(
                                'Rp ',
                                style: TextStyle(
                                    color: t60,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                investedAmount,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: blue),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profit Amount',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: t60),
                          ),
                          Row(
                            children: [
                              Text(
                                'Rp ',
                                style: TextStyle(
                                    color: t60,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                profitAmount,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: blue),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _InvestingOption extends StatelessWidget {
  final String iconUrl;
  final String title;
  final Color color;
  final void Function()? onTap;

  const _InvestingOption({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Image(
              color: color,
              image: AssetImage(iconUrl),
            ),
          ),
          SizedBox(height: h(13)),
          Text(title),
        ],
      ),
    );
  }
}

final _sampleCardList = [
  Image(image: AssetImage('assets/images/sample_card_2.png')),
  Image(image: AssetImage('assets/images/sample_card.png')),
];
