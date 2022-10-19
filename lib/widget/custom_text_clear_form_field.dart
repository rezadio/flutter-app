import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eidupay/tools.dart';

class CustomTextClearFormField extends StatefulWidget {
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
  const CustomTextClearFormField({
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
  _CustomTextClearFormFieldState createState() =>
      _CustomTextClearFormFieldState();
}

class _CustomTextClearFormFieldState extends State<CustomTextClearFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(alignment: const Alignment(1.0, 1.0), children: [
                  TextFormField(
                    controller: widget.controller,
                    readOnly: widget.readOnly,
                    validator: widget.validator,
                    obscureText: widget.obscureText,
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    maxLength: widget.maxLength,
                    decoration: underlineInputDecoration.copyWith(
                        hintText: widget.hintText, enabled: widget.enableEdit),
                  ),
                  widget.controller!.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              widget.controller!.clear();
                            });
                          })
                      : const Text('')
                ]),
              ),
            ],
          ),
        ],
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.only(bottom: 24.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         title,
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //       ),

    //     ],
    //   ),
    // );
  }
}
