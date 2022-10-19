import 'dart:io';

import 'package:flutter/material.dart';

class PageArgument {
  final String title;
  final String? subtitle;
  final Color? color;
  final String? step;
  final String? description;
  final String? imageUrl;
  final bool? hasButton;
  final String? trxId;
  final String? nominal;
  final String? biayaAdmin;
  final String? total;
  final String? ket1;
  final String? ket2;
  final String? ket3;
  final File? image1;
  final File? image2;

  const PageArgument({
    required this.title,
    this.subtitle,
    this.color,
    this.step,
    this.description,
    this.imageUrl,
    this.hasButton = true,
    this.trxId,
    this.nominal,
    this.biayaAdmin,
    this.total,
    this.ket1,
    this.ket2,
    this.ket3,
    this.image1,
    this.image2,
  });

  const PageArgument.kycPage1()
      : this(
            title: 'Foto Wajah & KTP Anda',
            description:
                'Mohon foto wajah dan ktp anda untuk memastikan bahwa ini benar-benar anda',
            imageUrl: 'assets/images/upgrade_diri_benar.png');

  const PageArgument.kycPage2(File? image1)
      : this(
            title: 'Foto KTP Anda',
            description:
                'Ambil foto eKTP kamu agar kami bisa membantu mengisi datamu. Pastikan foto terlihat dengan jelas.',
            imageUrl: 'assets/images/phone_with_ktp.png',
            image1: image1);
}
