import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EiduPinCodeTextField extends StatelessWidget {
  final bool? obscureText;
  final void Function(String value) onCompleted;
  final void Function(String value)? onChanged;
  final bool Function(String? value)? beforeTextPaste;
  final Duration? animationDuration;
  final bool? enableActiveFill;
  final bool? autoFocus;
  final TextInputType? keyboardType;
  final int? length;
  final AnimationType? animationType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintCharacter;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  const EiduPinCodeTextField({
    Key? key,
    this.obscureText,
    required this.onCompleted,
    this.onChanged,
    this.beforeTextPaste,
    this.animationDuration,
    this.enableActiveFill,
    this.autoFocus,
    this.keyboardType,
    this.length,
    this.animationType,
    this.inputFormatters,
    this.hintCharacter,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      autoFocus: autoFocus ?? true,
      textStyle: TextStyle(color: Color(0xFF004B84), fontSize: 40),
      keyboardType: keyboardType ?? TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      appContext: context,
      length: length ?? 6,
      cursorColor: Color(0xFF004B84),
      animationType: animationType ?? AnimationType.fade,
      obscureText: obscureText ?? true,
      onChanged: onChanged ?? (value) {},
      hintCharacter: hintCharacter ?? '-',
      showCursor: false,
      pinTheme: PinTheme(
        inactiveColor: Colors.transparent,
        activeColor: Colors.transparent,
        selectedColor: Colors.transparent,
      ),
      validator: validator,
      onCompleted: onCompleted,
      beforeTextPaste: beforeTextPaste,
    );
  }
}
