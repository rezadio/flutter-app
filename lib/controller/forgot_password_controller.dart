import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var isButtonDisable = true.obs;
  var isPasswordHide = true.obs;
  var isConfirmPasswordHide = true.obs;
  var questionNumber = 0.obs;

  final formKey = GlobalKey<FormState>();
  final answerController = TextEditingController();
}
