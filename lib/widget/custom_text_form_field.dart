import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eidupay/tools.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final bool enableEdit;
  final bool readOnly;
  final int? maxLength;

  const CustomTextFormField({
    Key? key,
    required this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enableEdit = true,
    this.readOnly = false,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: controller,
            readOnly: readOnly,
            validator: validator,
            obscureText: obscureText,
            onChanged: onChanged,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            decoration: underlineInputDecoration.copyWith(
                hintText: hintText,
                suffixIcon: suffixIcon,
                enabled: enableEdit),
          ),
        ],
      ),
    );
  }
}
