import 'package:eidupay/controller/profile/support_cont.dart';
import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  static final route =
      GetPage(name: '/profile/support/', page: () => const SupportPage());
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Support')),
        body: const _BodySupportPage());
  }
}

class _BodySupportPage extends StatelessWidget {
  const _BodySupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(SupportController());
    return SafeArea(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _c.supportContent.length,
            itemBuilder: (context, index) {
              final content = _c.supportContent[index];
              return _SupportCard(
                icon: content['icon'],
                title: content['title'],
                body: content['body'],
                type: content['type'],
              );
            }));
  }
}

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final SupportType type;
  final String title;
  final String body;

  const _SupportCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.body,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    Future<void> tap() async {
      switch (type) {
        case (SupportType.phone):
          await launch('tel:${body.numericOnly()}');
          break;
        case (SupportType.chat):
          final waNo = body.replaceAll('-', '').substring(1);
          final url = 'https://wa.me/+62$waNo?text=Halo+EiduPay';
          await launch(url);
          break;
        case (SupportType.email):
          final emailLaunchUri = Uri(
            scheme: 'mailto',
            path: body,
            query:
                encodeQueryParameters(<String, String>{'subject': 'Support: '}),
          );
          await launch(emailLaunchUri.toString());
          return;
        default:
      }
    }

    return GestureDetector(
      onTap: () => tap(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                SizedBox(width: 75, child: Icon(icon, color: green)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(body),
                    ],
                  ),
                ),
                const SizedBox(width: 75, child: Icon(Icons.navigate_next)),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
