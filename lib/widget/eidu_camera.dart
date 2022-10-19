import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

enum CameraType { front, back, external }
enum CameraResolution { low, medium, high, veryHigh, ultraHigh, max }

class EiduCamera extends StatefulWidget {
  final EiduCameraController controller;
  final CameraResolution cameraResolution;
  final CameraType defaultCameraType;

  EiduCamera(
      {required this.controller,
      required this.defaultCameraType,
      this.cameraResolution = CameraResolution.high})
      : super(key: controller._key);

  @override
  _EiduCameraState createState() => _EiduCameraState();
}

class _EiduCameraState extends State<EiduCamera> with WidgetsBindingObserver {
  CameraController? _controller;
  late List<CameraDescription> _cameras;
  late int _selectedCameraIdx;
  bool isDisposed = false;
  CameraLensDirection get _lensDirection =>
      widget.defaultCameraType.toCameraLensDirection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    availableCameras().then((availableCameras) {
      _cameras = availableCameras;
      if (_cameras.isNotEmpty) {
        final cameraId = _cameras.indexWhere((cameraDescription) =>
            cameraDescription.lensDirection == _lensDirection);
        setState(() {
          _selectedCameraIdx = cameraId;
        });
        _startCamera();
      }
    });
  }

  @override
  void dispose() {
    _stopCamera();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = _controller;
    if (!isDisposed ||
        cameraController == null ||
        !cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _controller = this._controller;
    if (isDisposed || _controller == null || !_controller.value.isInitialized) {
      return const Center(
        child: Text('Please allow permission to use the camera'),
      );
    }
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * _controller.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Transform.scale(
      scale: scale,
      child: Center(child: CameraPreview(_controller)),
    );
  }

  void _startCamera() => _initCameraController(
      _controller?.description ?? _cameras[_selectedCameraIdx]);

  Future _initCameraController(CameraDescription cameraDescription) async {
    await _stopCamera();
    ResolutionPreset resolutionPreset;
    switch (widget.cameraResolution) {
      case CameraResolution.max:
        resolutionPreset = ResolutionPreset.max;
        break;
      case CameraResolution.ultraHigh:
        resolutionPreset = ResolutionPreset.ultraHigh;
        break;
      case CameraResolution.veryHigh:
        resolutionPreset = ResolutionPreset.veryHigh;
        break;
      case CameraResolution.medium:
        resolutionPreset = ResolutionPreset.medium;
        break;
      case CameraResolution.low:
        resolutionPreset = ResolutionPreset.low;
        break;
      case CameraResolution.high:
      default:
        resolutionPreset = ResolutionPreset.high;
        break;
    }
    final _controller = CameraController(cameraDescription, resolutionPreset);
    this._controller = _controller;
    _controller.addListener(_cameraUpdate);
    await _controller.initialize();
    await _controller.lockCaptureOrientation();
    await _controller.setFlashMode(FlashMode.off);
    if (!widget.controller._completer.isCompleted) {
      widget.controller._completer.complete(true);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _stopCamera() async {
    if (_controller == null) return;
    _controller?.removeListener(_cameraUpdate);
    await _controller?.dispose();
    isDisposed = true;
  }

  void _cameraUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<XFile?> _takePicture() async {
    final _controller = this._controller;
    if (_controller != null) {
      final file = await _controller.takePicture();
      return file;
    }
    return null;
  }

  void _switchCamera() {
    _selectedCameraIdx =
        _selectedCameraIdx < _cameras.length - 1 ? _selectedCameraIdx + 1 : 0;
    final selectedCamera = _cameras[_selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  IconData? _toggleFlash(IconData icon) {
    final _controller = this._controller;
    if (_controller != null) {
      if (icon == Icons.flash_off) {
        _controller.setFlashMode(FlashMode.always);
        return Icons.flash_on;
      }
      if (icon == Icons.flash_on) {
        _controller.setFlashMode(FlashMode.auto);
        return Icons.flash_auto;
      }
      if (icon == Icons.flash_auto) {
        _controller.setFlashMode(FlashMode.off);
        return Icons.flash_off;
      }
    }
    return null;
  }
}

class EiduCameraController {
  final _key = GlobalKey<_EiduCameraState>();
  late final _completer = Completer();

  Size? get previewSize => _key.currentState?._controller?.value.previewSize;

  Future<XFile?> takePicture() async => _key.currentState?._takePicture();

  void startCamera() => _key.currentState?._startCamera();

  void stopCamera() => _key.currentState?._stopCamera();

  void switchCamera() => _key.currentState?._switchCamera();

  IconData? toggleFlash(IconData icon) => _key.currentState?._toggleFlash(icon);
}

extension CameraTypes on CameraType {
  CameraLensDirection toCameraLensDirection() {
    switch (this) {
      case CameraType.front:
        return CameraLensDirection.front;
      case CameraType.external:
        return CameraLensDirection.external;
      case CameraType.back:
      default:
        return CameraLensDirection.back;
    }
  }
}
