import 'dart:developer';
import 'package:eidupay/controller/qris/qris_scan_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/view/qris/qris_payment_page.dart';
import 'package:eidupay/widget/dialog/eidu_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrisScanPage extends StatefulWidget {
  static final route =
      GetPage(name: '/qris/', page: () => const QrisScanPage());

  const QrisScanPage({Key? key}) : super(key: key);

  @override
  _QrisScanPageState createState() => _QrisScanPageState();
}

class _QrisScanPageState extends State<QrisScanPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: _BodyQrisScanPage(),
      ),
    );
  }
}

class _BodyQrisScanPage extends StatefulWidget {
  const _BodyQrisScanPage({Key? key}) : super(key: key);

  @override
  _BodyQrisScanPageState createState() => _BodyQrisScanPageState();
}

class _BodyQrisScanPageState extends State<_BodyQrisScanPage>
    with WidgetsBindingObserver {
  final _c = Get.put(QrisScanController(injector.get()));
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller?.pauseCamera();
    }
    if (state == AppLifecycleState.resumed) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildQrView(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 25, top: 50, left: 40, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.highlight_off,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Scan untuk membayar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox
                            .shrink(), // change this with below when feature is available
                        // GestureDetector(
                        //   onTap: () async {
                        //     final qris =
                        //         await _c.checkQris(context, _dummyResultScan);
                        //     Get.toNamed(QrisVerificationPage.route.name,
                        //         arguments: qris);
                        //   },
                        //   child: Container(
                        //     height: 45,
                        //     width: 45,
                        //     decoration: BoxDecoration(
                        //         color: Color(0xFFFCFBFC).withOpacity(0.3),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(10))),
                        //     child: Icon(
                        //       Icons.info_outline,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => GestureDetector(
                            child: Icon(
                              (_c.isFlashOn.value)
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              try {
                                await controller?.toggleFlash();
                                _c.isFlashOn.value = !_c.isFlashOn.value;
                              } catch (e) {
                                if (e is CameraException) {
                                  await EiduInfoDialog.showInfoDialog(
                                      title: e.description ?? 'error');
                                }
                              }
                            },
                          ),
                        ),
                        //TODO: implement when service is available
                        // GestureDetector(
                        //   child: Image(
                        //     image: AssetImage('assets/images/gallery.png'),
                        //     height: 24,
                        //   ),
                        //   onTap: () async {
                        //     await controller?.pauseCamera();
                        //     final _picker = ImagePicker();
                        //     final image = await _picker
                        //         .pickImage(source: ImageSource.gallery)
                        //         .whenComplete(() => controller?.resumeCamera());
                        //   },
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Powered by ', style: TextStyle(fontSize: 14)),
                  Image.asset('assets/images/logo_qris.png', height: 14)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 350.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: const Color.fromRGBO(0, 0, 0, 100),
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 36,
          borderWidth: 4,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _cameraUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    if (_isProcessing) return;
    _isProcessing = true;
    this.controller = controller;
    final listData = <String>[];
    controller.scannedDataStream.listen((scanData) async {
      _cameraUpdate();
      _c.result = scanData;
      final data = _c.result?.code;
      if (data != null) {
        listData.add(data);
        if (listData.length == 1) {
          final qris = await _c.checkQris(context, listData.first);
          await Get.offNamed(QrisPaymentPage.route.name,
              arguments: [listData.first, qris]);
        }
        if (listData.length == 85) {
          listData.removeRange(2, listData.length);
          final qris = await _c.checkQris(context, listData.last);
          await Get.offNamed(QrisPaymentPage.route.name,
              arguments: [listData.first, qris]);
        }
        if (listData.first == listData.last) {
          return;
        }
        if (listData.first != listData.last) {
          listData.clear();
        }
      }
    });
    _isProcessing = false;
  }

  @override
  void dispose() {
    qrKey.currentState?.dispose();
    controller?.stopCamera();
    controller?.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
