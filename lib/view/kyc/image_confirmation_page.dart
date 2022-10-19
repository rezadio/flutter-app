import 'package:eidupay/controller/kyc/image_confirmation_controller.dart';
import 'package:eidupay/model/page_argument.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageConfirmationPage extends StatefulWidget {
  static final route = GetPage(
      name: '/kyc/image-confirmation',
      page: () => const ImageConfirmationPage());
  const ImageConfirmationPage({Key? key}) : super(key: key);

  @override
  _ImageConfirmationPageState createState() => _ImageConfirmationPageState();
}

class _ImageConfirmationPageState extends State<ImageConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Konfirmasi'), automaticallyImplyLeading: false),
        body: const _BodyImageConfirmationPage(),
      ),
    );
  }
}

class _BodyImageConfirmationPage extends StatefulWidget {
  const _BodyImageConfirmationPage({Key? key}) : super(key: key);

  @override
  _BodyImageConfirmationPageState createState() =>
      _BodyImageConfirmationPageState();
}

class _BodyImageConfirmationPageState
    extends State<_BodyImageConfirmationPage> {
  final _c = Get.put(ImageConfirmationController());
  final PageArgument argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final image1 = argument.image1;
    final image2 = argument.image2;
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          child: Center(
              child: (image2 != null)
                  ? Image.file(image2)
                  : (image1 != null)
                      ? Image.file(image1)
                      : const Text('Gagal mengambil foto')),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  child: const Text('Ulangi'),
                  onPressed: () => _c.retake(image1: image1, image2: image2),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const VerticalDivider()),
              Expanded(
                child: TextButton(
                  child: const Text('Gunakan'),
                  onPressed: () {
                    if (image1 != null && image2 != null) {
                      _c.process(context, image1: image1, image2: image2);
                      return;
                    }
                    if (image1 != null) {
                      _c.process(context, image1: image1);
                      return;
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
