import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';

class EiduBottomSheet extends StatefulWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final Color? iconColor;
  final String? buttonText;
  final VoidCallback? onPressed;
  final String? imageUrl;

  const EiduBottomSheet._(
      {Key? key,
      this.icon,
      this.iconColor,
      required this.title,
      this.description,
      this.onPressed,
      this.buttonText,
      this.imageUrl})
      : super(key: key);

  static Future<void> showBottomSheet({
    required String title,
    String? description,
    IconData? icon,
    Color? iconColor,
    String? buttonText,
    VoidCallback? onPressed,
    String? imageUrl,
  }) =>
      showModalBottomSheet(
          shape: const StadiumBorder(),
          context: navigatorKey.currentContext!,
          builder: (context) => EiduBottomSheet._(
                title: title,
                description: description,
                icon: icon,
                iconColor: iconColor,
                buttonText: buttonText,
                onPressed: onPressed,
                imageUrl: imageUrl,
              ));

  @override
  _EiduBottomSheetState createState() => _EiduBottomSheetState();
}

class _EiduBottomSheetState extends State<EiduBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final _description = widget.description;
    final _icon = widget.icon;
    final _imageUrl = widget.imageUrl;

    return Wrap(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 3, width: 38, color: const Color(0xFFEBEBED)),
                if (_icon != null) const SizedBox(height: 10),
                if (_icon != null)
                  Icon(_icon, color: widget.iconColor, size: 75),
                if (_imageUrl != null) Image.asset(_imageUrl, height: 150),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    if (_description != null && _description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          _description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFF92929D)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 17),
                SubmitButton(
                  backgroundColor: const Color(0xFF44CCC0),
                  text: widget.buttonText,
                  onPressed: widget.onPressed,
                )
              ],
            )),
      ],
    );
  }
}
