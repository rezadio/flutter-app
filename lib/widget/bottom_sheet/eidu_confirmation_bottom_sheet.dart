import 'package:cached_network_image/cached_network_image.dart';
import 'package:eidupay/tools.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EiduConfirmationBottomSheet extends StatefulWidget {
  final String title;
  final Widget? body;
  final String? description;
  final String? imageUrl;
  final String? firstButtonText;
  final VoidCallback? firstButtonOnPressed;
  final VoidCallback? secondButtonOnPressed;
  final String? secondButtonText;
  final Color? color;
  final Color? firstButtonColor;
  final Color? secondButtonColor;
  final String? iconUrl;

  const EiduConfirmationBottomSheet._({
    Key? key,
    this.imageUrl,
    required this.title,
    this.description,
    this.firstButtonOnPressed,
    this.firstButtonText,
    this.secondButtonOnPressed,
    this.secondButtonText,
    this.body,
    this.color,
    this.firstButtonColor,
    this.secondButtonColor,
    this.iconUrl,
  }) : super(key: key);

  static Future<T?> showBottomSheet<T>({
    required String title,
    Widget? body,
    String? description,
    String? imageUrl,
    String? firstButtonText,
    VoidCallback? firstButtonOnPressed,
    VoidCallback? secondButtonOnPressed,
    Color? color,
    Color? firstButtonColor,
    Color? secondaryColor,
    String? iconUrl,
    String? secondButtonText,
  }) =>
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const StadiumBorder(),
          context: navigatorKey.currentContext!,
          builder: (context) => EiduConfirmationBottomSheet._(
                title: title,
                body: body,
                description: description,
                imageUrl: imageUrl,
                firstButtonText: firstButtonText,
                firstButtonOnPressed: firstButtonOnPressed,
                secondButtonOnPressed: secondButtonOnPressed,
                color: color,
                firstButtonColor: firstButtonColor,
                secondButtonColor: secondaryColor,
                iconUrl: iconUrl,
                secondButtonText: secondButtonText,
              ));

  @override
  _EiduConfirmationBottomSheet createState() => _EiduConfirmationBottomSheet();
}

class _EiduConfirmationBottomSheet extends State<EiduConfirmationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final _imageUrl = widget.imageUrl;
    final _body = widget.body;
    final _iconUrl = widget.iconUrl;

    return Wrap(children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: w(65),
                    height: 5,
                    color: Colors.grey[350],
                  ),
                  const SizedBox(height: 26),
                  // SizedBox(
                  //   width: w(37),
                  //   height: w(37),
                  //   child: Image.asset('assets/images/ico_logout_btm.png'),
                  // ),
                  const SizedBox(height: 18),
                  if (_iconUrl != null)
                    Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: widget.color?.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Image(
                        color: widget.color,
                        image: AssetImage(_iconUrl),
                      ),
                    ),
                  if (_imageUrl != null) Image(image: AssetImage(_imageUrl)),
                  SizedBox(height: h(22)),
                  Text(
                    widget.title,
                    style:
                        TextStyle(fontSize: w(22), fontWeight: FontWeight.bold),
                  ),
                  if (widget.description != null) SizedBox(height: h(22)),
                  if (widget.description != null)
                    Text(
                      widget.description ?? '',
                      style: TextStyle(
                          fontSize: w(16), fontWeight: FontWeight.w400),
                    ),
                ],
              ),
              if (_body != null) SizedBox(height: h(22)),
              if (_body != null) _body,
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SubmitButton(
                      backgroundColor: widget.firstButtonColor,
                      text: widget.firstButtonText ?? 'Batal',
                      onPressed:
                          widget.firstButtonOnPressed ?? () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: SubmitButton(
                      backgroundColor: widget.secondButtonColor,
                      text: widget.secondButtonText,
                      onPressed: widget.secondButtonOnPressed,
                    ),
                  ),
                ],
              ),
            ],
          )),
    ]);
  }
}
