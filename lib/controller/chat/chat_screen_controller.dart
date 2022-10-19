import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatScreenController extends GetxController {
  var isPaid = false.obs;
  var isDeclined = false.obs;
  var isRequested = false.obs;

  final formKey = GlobalKey<FormState>();
  final chatController = TextEditingController();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    chatController.dispose();
    super.dispose();
  }
}
