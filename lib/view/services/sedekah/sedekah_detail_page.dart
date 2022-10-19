import 'package:eidupay/model/sedekah.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SedekahDetailPage extends StatefulWidget {
  static final route =
      GetPage(name: '/services/sedekah/:id', page: () => SedekahDetailPage());
  const SedekahDetailPage({Key? key}) : super(key: key);

  @override
  _SedekahDetailPageState createState() => _SedekahDetailPageState();
}

class _SedekahDetailPageState extends State<SedekahDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sedekah')),
      body: _BodySedekahDetailPage(),
    );
  }
}

class _BodySedekahDetailPage extends StatefulWidget {
  const _BodySedekahDetailPage({Key? key}) : super(key: key);

  @override
  _BodySedekahDetailPageState createState() => _BodySedekahDetailPageState();
}

class _BodySedekahDetailPageState extends State<_BodySedekahDetailPage> {
  List<DataSedekah> dataSedekah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: dataSedekah.length,
        itemBuilder: (context, index) {
          return _InstitutionWidget(
            imageUrl: dataSedekah[index].programLogo,
            institutionName: dataSedekah[index].programName ?? '-',
            onTap: () async {
              Get.toNamed(
                  '/services/sedekah/${dataSedekah[index].merchantId}/amount',
                  arguments: dataSedekah[index]);
            },
          );
        },
      ),
    );
  }
}

class _InstitutionWidget extends StatelessWidget {
  final String? imageUrl;
  final String institutionName;
  final void Function()? onTap;

  const _InstitutionWidget({
    Key? key,
    this.imageUrl,
    required this.institutionName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: w(50),
                        width: w(50),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: green.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Image(
                            image: NetworkImage(imageUrl ??
                                'https://android.edupay.info:8999/eidupay/home/getIcon/sedekah.png')),
                      ),
                      SizedBox(width: 24),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          institutionName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            Divider(height: 25),
          ],
        ),
      ),
    );
  }
}
