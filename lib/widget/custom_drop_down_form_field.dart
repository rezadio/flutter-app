import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String title;
  final String? value;
  final String? hint;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String? value)? onPressed;
  final String? Function(String? value)? validator;

  const CustomDropdownFormField({
    Key? key,
    required this.title,
    this.hint,
    this.value,
    this.items,
    this.onPressed,
    this.validator,
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
          DropdownButtonFormField(
            value: value,
            items: items,
            icon: Icon(Icons.expand_more),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xFFD5D5DC), fontSize: 14),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD5D5DC)))),
            onChanged: onPressed,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
