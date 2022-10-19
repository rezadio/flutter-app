import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final String? text;
  final double? height;
  final int? fontSize;
  final String? iconUrl;
  final Color? iconColor;
  final bool? hasBorderSide;
  final Color? textColor;

  const SubmitButton(
      {Key? key,
      this.backgroundColor,
      this.onPressed,
      this.text,
      this.height,
      this.fontSize,
      this.borderRadius,
      this.hasBorderSide = false,
      this.iconUrl,
      this.textColor,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _iconUrl = iconUrl;
    final _iconColor = iconColor;
    final _backgroundColor = backgroundColor;
    final _hasBorderSide = hasBorderSide;

    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: onPressed == null
            ? MaterialStateProperty.all<Color>(t40)
            : _backgroundColor != null
                ? MaterialStateProperty.all<Color>(_backgroundColor)
                : MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: _hasBorderSide == true
                ? const BorderSide(width: 1, color: t50)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
          ),
        ),
      ),
      child: Container(
          height: height ?? 58,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_iconUrl != null && _iconUrl.isNotEmpty)
                Image(
                  image: AssetImage(_iconUrl),
                  height: 18,
                  width: 18,
                  color: _iconColor!,
                ),
              if (_iconUrl != null && _iconUrl.isNotEmpty)
                const SizedBox(width: 10),
              Text(
                text ?? 'Button Text',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: w(fontSize ?? 16),
                    color: _backgroundColor == null
                        ? blue
                        : textColor ?? Colors.white),
              ),
            ],
          )),
      onPressed: onPressed,
    );
  }
}
