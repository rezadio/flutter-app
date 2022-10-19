import 'package:eidupay/controller/services/services_cont.dart';
import 'package:eidupay/model/home.dart';
import 'package:eidupay/tools.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesPage extends StatefulWidget {
  static final route =
      GetPage(name: '/services', page: () => const ServicesPage());
  const ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layanan')),
      body: const _BodyServicesPage(),
    );
  }
}

class _BodyServicesPage extends StatefulWidget {
  const _BodyServicesPage({Key? key}) : super(key: key);

  @override
  _BodyServicesPageState createState() => _BodyServicesPageState();
}

class _BodyServicesPageState extends State<_BodyServicesPage>
    with SingleTickerProviderStateMixin {
  final getController = Get.put(ServiceCont());
  List<Menu> serviceApps = Get.arguments;

  @override
  Widget build(BuildContext context) {
    List<Widget> _billPaymentApps = serviceApps
        .where((element) => element.type.contains('Bill Payments'))
        .map((e) => _ServiceCard(
              color: red,
              imageUrl: e.icon,
              serviceName: e.title,
              idMenu: e.idMenu,
            ))
        .toList(growable: false);
    List<Widget> _billPaymentApps2 = serviceApps
        .where((element) => element.type.contains('Bill Payments'))
        .map((e) => _ServiceMinifyCard(
              color: red,
              imageUrl: e.icon,
              serviceName: e.title,
              idMenu: e.idMenu,
            ))
        .toList(growable: false);
    List<Widget> _educationApps = serviceApps
        .where((element) => element.type.contains('Education'))
        .map((e) => _ServiceCard(
            color: red,
            imageUrl: e.icon,
            serviceName: e.title,
            idMenu: e.idMenu))
        .toList(growable: false);
    List<Widget> _educationApps2 = serviceApps
        .where((element) => element.type.contains('Education'))
        .map((e) => _ServiceMinifyCard(
            color: red,
            imageUrl: e.icon,
            serviceName: e.title,
            idMenu: e.idMenu))
        .toList(growable: false);
    // _educationApps.removeWhere((element) => false);
    List<Widget> _prepaidApps = serviceApps
        .where((element) => element.type.contains('Prepaid'))
        .map((e) => _ServiceCard(
            color: red,
            imageUrl: e.icon,
            serviceName: e.title,
            idMenu: e.idMenu))
        .toList(growable: false);
    List<Widget> _prepaidApps2 = serviceApps
        .where((element) => element.type.contains('Prepaid'))
        .map((e) => _ServiceMinifyCard(
            color: red,
            imageUrl: e.icon,
            serviceName: e.title,
            idMenu: e.idMenu))
        .toList(growable: false);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: ExpandableNotifier(
                  initialExpanded: true,
                  child: ExpandablePanel(
                    header: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Pembayaran Tagihan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    collapsed: Container(
                      child: const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      ),
                    ),

                    // ignore: avoid_unnecessary_containers
                    expanded: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _billPaymentApps2.length,
                          itemBuilder: (BuildContext ctx, i) {
                            return _billPaymentApps2[i];
                          }),
                    ),
                    theme: const ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h(24)),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: ExpandableNotifier(
                  child: ExpandablePanel(
                    header: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Top-Up',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    collapsed: Container(
                      child: const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      ),
                    ),

                    // ignore: avoid_unnecessary_containers
                    expanded: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _prepaidApps2.length,
                          itemBuilder: (BuildContext ctx, i) {
                            return _prepaidApps2[i];
                          }),
                    ),
                    theme: const ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h(24)),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: ExpandableNotifier(
                  child: ExpandablePanel(
                    header: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Pendidikan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    collapsed: Container(
                      child: const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      ),
                    ),

                    // ignore: avoid_unnecessary_containers
                    expanded: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _educationApps2.length,
                          itemBuilder: (BuildContext ctx, i) {
                            return _educationApps2[i];
                          }),
                    ),
                    theme: const ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                    ),
                  ),
                ),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text('Education',
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //     SizedBox(height: h(8)),
              //     Column(children: _educationApps),
              //   ],
              // ),
              SizedBox(height: h(24)),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text('Bill Payments',
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //     SizedBox(height: h(8)),
              //     Column(children: _billPaymentApps),
              //   ],
              // ),
              SizedBox(height: h(24)),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text('Prepaid',
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //     SizedBox(height: h(8)),
              //     Column(children: _prepaidApps),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.setBool(kIsShowCasePrompted, true);

    super.dispose();
  }
}

class _ServiceMinifyCard extends StatelessWidget {
  final Color color;
  final String imageUrl;
  final String serviceName;
  final String idMenu;
  final bool? isNew;

  const _ServiceMinifyCard({
    Key? key,
    required this.color,
    required this.imageUrl,
    required this.serviceName,
    required this.idMenu,
    this.isNew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _serviceCont = Get.find<ServiceCont>();
    return GestureDetector(
      onTap: () => _serviceCont.serviceTap(serviceName, idMenu),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: t80.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Image(image: NetworkImage(imageUrl)),
            ),
            const SizedBox(height: 5),
            SizedBox(
              child: Text(
                serviceName,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w300, color: darkBlue),
              ),
            ),
            if (isNew == true)
              Container(
                height: 12,
                width: 31,
                decoration: const BoxDecoration(
                    color: orange1,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                  child: Text(
                    'New',
                    style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            // Expanded(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           const SizedBox(width: 24),
            //           Text(
            //             serviceName,
            //             style: const TextStyle(
            //                 fontSize: 14, fontWeight: FontWeight.w400),
            //           ),
            //           const SizedBox(width: 8),
            //           if (isNew == true)
            //             Container(
            //               height: 12,
            //               width: 31,
            //               decoration: const BoxDecoration(
            //                   color: orange1,
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(4))),
            //               child: const Center(
            //                 child: Text(
            //                   'New',
            //                   style: TextStyle(
            //                       fontSize: 9,
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ),
            //             )
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Color color;
  final String imageUrl;
  final String serviceName;
  final String idMenu;
  final bool? isNew;

  const _ServiceCard({
    Key? key,
    required this.color,
    required this.imageUrl,
    required this.serviceName,
    required this.idMenu,
    this.isNew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _serviceCont = Get.find<ServiceCont>();
    return GestureDetector(
      onTap: () => _serviceCont.serviceTap(serviceName, idMenu),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.5, color: t70),
        )),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: t80.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Image(image: NetworkImage(imageUrl)),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 8),
                      if (isNew == true)
                        Container(
                          height: 12,
                          width: 31,
                          decoration: const BoxDecoration(
                              color: orange1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: const Center(
                            child: Text(
                              'New',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
