import 'package:eidupay/controller/terms_signup_cont.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/small_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';

class TermSignup extends StatelessWidget {
  static final route = GetPage(name: '/term-signup', page: () => TermSignup());

  @override
  Widget build(BuildContext context) {
    final c = Get.put(TermSignupCont());
    //final signUpController = Get.find<SignupCont>();

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 33, right: 33),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h(64)),
            Container(
              width: w(122),
              height: w(42),
              child: Image.asset(
                'assets/images/logo_eidupay.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: h(13)),
            Text('Syarat &\nKetentuan',
                style: TextStyle(fontSize: w(30), fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SmallDivider(),
            SizedBox(height: h(24)),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 50 / 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: t70, width: 0.5)),
              child: Scrollbar(
                child: SingleChildScrollView(child: syarat()

                    // Text(c.terms,
                    //     style: TextStyle(
                    //         fontSize: w(14),
                    //         fontWeight: FontWeight.w300,
                    //         color: t60)),
                    ),
              ),
            ),
            SizedBox(height: h(10)),
            Row(
              children: [
                Obx(() => Checkbox(
                      value: c.termsAgree.value,
                      onChanged: (val) {
                        c.termsAgree.value = val!;
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )),
                Container(
                  child: Flexible(
                    child: Text(
                        'Dengan membuat akun, anda setuju dengan Syarat & Ketentuan Kami',
                        //Term and Conditions',
                        style: TextStyle(fontSize: w(14), color: t70)),
                  ),
                ),
              ],
            ),
            SizedBox(height: h(28)),
            Obx(() => SubmitButton(
                  text: 'Buat Akun',
                  backgroundColor: !c.termsAgree.value ? disabledGreen : green,
                  onPressed:
                      !c.termsAgree.value ? null : () => c.buatAkunTap(context),
                )),
          ],
        ),
      )),
    );
  }
}

Widget syarat() {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, terima kasih telah menggunakan EIDUPAY!',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: t100),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'MOHON MEMBACA DAN MEMAHAMI KETENTUAN LAYANAN INI DENGAN SEKSAMA SEBELUM MENGAKSES, MENDAFTAR ATAU MENGGUNAKAN APLIKASI EIDUPAY DAN DAPAT MENGHUBUNGI KAMI JIKA MEMILIKI PERTANYAAN. ',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: t70),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text:
                      'Aplikasi EIDUPAY adalah layanan uang elektronik yang terbitkan oleh PT Visi Jaya Indonesia (“VJI” atau “EIDUPAY” atau Kami”). Ketentuan layanan ini mengatur akses dan penggunaan terhadap aplikasi, website, dan produk-produk, termasuk didalamnya jasa-jasa pembayaran yang Kami sediakan. Pada saat mengakses dan menggunakan aplikasi EIDUPAY, pengguna mengakui dan menyetujui seluruh',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t70)),
              TextSpan(
                  text: " Syarat dan Ketentuan Layanan Aplikasi Eidupay",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              TextSpan(
                  text: " (selanjutnya disebut",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t70)),
              TextSpan(
                  text: " “Syarat dan Ketentuan”",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              TextSpan(
                  text: " ) juga",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t70)),
              TextSpan(
                  text: " “Kebijakan Privasi”",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              TextSpan(
                  text: "  yang tertera pada halaman yang berbeda.",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t70)),
            ],
          )),
          SizedBox(height: 30),
          Text('I. DEFINISI',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('a.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'EIDUPAY  ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah aplikasi layanan Uang Elektronik, transfer EIDUPAY dan layanan pendukung lainnya berbasis mobile yang saat ini dikenali dengan merek, nama, logo dan/atau tanda lainnya “EIDUPAY” dimiliki oleh PT Visi Jaya Indonesia (VJI). Yang merupakan pemegang lisensi uang elektronik dan transfer EIDUPAY dari Bank Indonesia.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),

          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('b.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'VJI   ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah PT Visi Jaya Indonesia, suatu perseroan terbatas yang didirikan berdasarkan hukum Negara Kesatuan Republik Indonesia.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('c.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Kami ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text: 'adalah PT Visi Jaya Indonesia (VJI).',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('d.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Akun ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah identifikasi khusus yang dibuat EIDUPAY berdasar atas permintaan pendaftaran pengguna, dikuasai dan dimanfaarkan oleh pengguna atas layanan yang Kami sediakan.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('e.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Akun Premium ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah akun EIDUPAY yang dimiliki oleh pengguna yang telah terverifikasi. Verifikasi dilakukan dengan cara mengunggah foto wajah dan KTP pada akun Pengguna.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('f.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Akun Reguler ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah akun EIDUPAY yang dimiliki oleh pengguna yang belum melakukan proses KYC atau belum menyelesaikan proses verifikasi.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('g.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Saldo EIDUPAY ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah jumlah uang yang tercatat dan tersimpan di EIDUPAY. Uang yang menjadi dasar penerbitan uang elektronik akan ditampung di Rekening Penampung dan dapat digunakan oleh Pengguna untuk melakukan transasi dengan menggunakan EIDUPAY.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('h.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Data ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah setiap informasi dan/atau keterangan dalam bentuk apapun yang dari waktu ke waktu yang Anda sampaikan kepada Kami/Penyedia Layanan atau yang Anda cantumkan atau sampaikan dalam, pada atau melalui Aplikasi.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('i.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Layanan ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah setiap jenis layanan, fitur, system, fasilitas dan/atau jasa, program, produk yang disediakan dan/atau ditawarkan melalui Aplikasi.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('j.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Layanan Pelanggan ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah fungsi customer service center untuk nasabah yang dapat dihubungi lewat panggilan telepon, chatting dan/atau email.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('k.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Syarat dan Ketentuan ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'berarti Syarat dan Ketentuan ini berikut setiap perubahan, penambahan, penggantian, penyesuaian dan/atau modifikasinya yang dibuat dari waktu ke waktu.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('l.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Merchant ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'adalah pihak-pihak baik perorangan maupun berbadan hukum usaha yang melayani transaksi menggunakan EIDUPAY berdasarkan perjanjian kerja sama dengan VJI dan/atau agregator EIDUPAY atau cara kerjasama lainnya.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('m.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Transaksi ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    ),
                    TextSpan(
                      text:
                          'berarti segala transaksi, kegiatan, aktivitas dan/atau aksi yang dilakukan pengguna melalui Aplikasi, Akun dan/atau person identification number di wilayah Indonesia maupun luar wilayah Indonesia (sebagaimana relevan) untuk Layanan atau fitur-fitur pada aplikasi, maupun transaksi yang akan dikembangkan pada  masa mendatang.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),

          // ktentuan umum
          SizedBox(height: 30),
          Text('II. KETENTUAN UMUM',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('a.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Syarat dan ketentuan ini berlaku untuk semua pengguna atas salah satu atau beberapa atau semua layanan yang tersedia di EIDUPAY, dan untuk setiap orang yang mengajukan permintaan dan/atau yang memberikan informasi kepada Kami.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('b.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Pengguna dapat melakukan Transaksi apapun apabila memiliki Saldo yang mencukupi. Jumlah Saldo dibatasi sebesar:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Rp 2.000.000 (dua juta Rupiah) untuk Akun Reguler yang dimiliki oleh Pengguna unregistered / Tidak Terverifikasi',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Rp 10.000.000 (sepuluh juta Rupiah) untuk Akun Premium, atau',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Jumlah lainnya sebagaimana ditentukan dari waktu ke waktu sesuai dengan peraturan perundang-undangan yang berlaku.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('c.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Batas maksimum Transaksi yang bersifat incoming (masuk) dalam 1 (satu) Akun EIDUPAY pada 1 (satu) bulan kalender adalah Rp 20.000.000 (dua puluh juta Rupiah).',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('d.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'VJI dapat melakukan penolakan Transaksi jika sewaktu-waktu sistem keamanan Kami menganggap bahwa Transaksi yang dilakukan tidak wajar.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t70),
                    )
                  ],
                ),
              )),
            ],
          ),

          //REGISTRASI, KODE VERIFIKASI (OTP) DAN PIN
          SizedBox(height: 30),
          Text('III. REGISTRASI, KODE VERIFIKASI (OTP) DAN PIN',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('a.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Registrasi',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
                'Untuk dapat menjadi pengguna EIDUPAY dapat dilakukan dengan cara berikut:',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: t70)),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Mengunduh aplikasi Eidupay  secara langsung melalui perangkat telekomunikasi yang dimiliki sebagaimana tersedia di Google Playstore (untuk android) dan Apple-App Store (untuk IOS) dan melakukan instalasi pada perangkat yang dimiliki.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Setelah melakukan instalasi EIDUPAY, Pengguna dapat melakukan proses registrasi dengan mengikuti petunjuk dan menyediakan informasi, antara lain:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Nama akun dari Pengguna',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Nomor ponsel aktif yang dibuktikan dengan memasukan kode verifikasi berupa kode One Time Password atau “OTP” yang dikirim kepada nomor ponsel tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'PIN (6 angka) yang dipilih sendiri oleh Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Apabila Pengguna bermaksud meningkatkan status Akun menjadi menjadi Akun Premium, maka Pengguna akan diminta dan bersedia untuk mengunggah foto wajah dan KTP melalui aplikasi EIDUPAY. Setiap permintaan pendaftaran Akun Premium tersebut akan dianggap sebagai permintaan yang sah dari Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Seluruh data atau informasi yang Pengguna kirimkan untuk pendaftaran Akun Premium akan disimpan oleh VJI dalam rangka melakukan verifikasi terhadap permintaan Akun Premium dari Pengguna, dan akan digunakan untuk metode otentikasi Verifikasi Wajah sebagaimana diatur dalam Syarat dan Ketentuan ini.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Persetujuan dan/atau penolakan atas permohonan verifikasi Pengguna merupakan kewenangan mutlak VJI dengan memperhatikan ketentuan hukum dan peraturan perundang-undangan yang berlaku. VJI dapat, sewaktu-waktu, membatalkan persetujuan atas permohonan verifikasi Pengguna sehingga status akun Pengguna menjadi tidak terverifikasi.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna wajib menjamin kebenaran dan keakuratan seluruh “Data” dan informasi yang disampaikan Pengguna dalam rangka registrasii akun EIDUPAY maupun verifikasi Akun Premium. Pengguna bertanggung jawab secara penuh apabila di kemudian hari ditemukan bahwa terdapat data dan informasi yang disampaikan Pengguna yang tidak akurat, salah, dan/atau palsu.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('7.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Anda wajib memastikan kebenaran dan keakuratan setiap data, informasi dan/atau keterangan dalam bentuk apapun yang dari waktu ke waktu Anda sampaikan kepada Kami atau yang Anda cantumkan atau sampaikan dalam, pada atau melalui aplikasi Merchant EIDUPAY (“Data”).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text('Registrasi Khusus Pelajar ',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text('Usia Member  < 12 Tahun ( SISWA SD)',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Telah memiliki Identitas Kartu Pelajar',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Untuk siswa setingkat SMP dan SMA (sederajat)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dokumen Pembukaan Identitas Pengguna:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 105),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'FC Kartu pelajar yang disahkan pihak sekolah (dengan membawa aslinya)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 105),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'C KTP Orang Tua / Wali',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 105),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Surat Pernyataan Orang Tua / Wali yang menyatakan mengetahui dan menyetujui permohonan pembukaan akun dan bertransaksi menggunakan Edupay.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Identitas diri :',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 105),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'WNI : Kartu Tanda Penduduk (KTP)*',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 105),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('e.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'WNA : Paspor dan KIMS/KITAP/KITAS',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('b.',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Koder Verifikasi (Kode OTP)',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: t100),
                    )
                  ],
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('8.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kode OTP (Kode Sandi Sekali Pakai / One Time Password) adalah kode sandi yang dikirim melalui Layanan Pesan Singkat (Short Messaging Service / SMS) ke nomor telepon Pengguna yang terdaftar pada aplikasi EIDUPAY, yang berfungsi untuk melakukan verifikasi atas Transaksi atau tindakan tertentu yang dilakukan melalui EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('9.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna wajib menjaga kerahasiaan OTP dan bertanggung jawab sepenuhnya atas data diri, informasi, maupun keamanan dan ketersediaan serta penguasaan atas Perangkat Telekomunikasi serta Nomor Ponsel (Handphone) yang digunakan untuk menerima kode OTP. Kerugian yang timbul akibat kegagalan/kelalaian Pengguna dalam menjaga kerahasiaan dan keamanan OTP merupakan tanggung jawab Pengguna sepenuhnya. Setiap kode OTP yang berhasil terverifikasi dari akun EIDUPAY akan dianggap sebagai Transaksi dan/atau aktivitas yang sah dari Pengguna, dari dan oleh karenanya akan mengikat dan memiliki akibat hukum terhadap Pengguna yang bersangkutan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('10.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna setuju untuk menanggung semua risiko yang terkait bila mengungkapkan kode OTP kepada pihak ketiga manapun dan untuk sepenuhnya bertanggung jawab atas setiap konsekuensi yang terkait dengan hal tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('11.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pihak VJI tidak mengetahui dan tidak akan pernah meminta Pengguna memberitahukan OTP kepada VJI.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Personal Identification Number (PIN)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('12.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pada saat proses registrasi akun baru, Pengguna EIDUPAY diwajibkan membuat Personal Identification Number (PIN).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('13.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'PIN adalah nomor identifikasi pribadi yang dibuat dan ditentukan oleh Pengguna pada saat Pengguna melakukan Registrasi akun EIDUPAY untuk melakukan verifikasi identitas Pengguna dalam sistem keamanan EIDUPAY, yang terdiri dari 6 (enam) digit angka yang tidak boleh berulang atau berurutan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('14.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna akan diminta memasukan PIN untuk memverifikasi suatu pembayaran tertentu dan/atau pemanfaatan fitur-fitur tertentu, sebagaimana ditentukan berdasarkan diskresi VJI, untuk memastikan keabsahan atau melakukan verifikasi bahwa Transaksi benar-benar dilakukan oleh Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('15.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami berhak untuk melakukan blokir sementara atas akun EIDUPAY apabila Pengguna EIDUPAY memasukkan PIN yang salah sebanyak 3 (tiga) kali berturut - turut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('16.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna wajib menjaga kerahasiaan PIN dan bertanggung jawab sepenuhnya atas kerahasiaan PIN. Kerugian yang timbul akibat kegagalan/kelalaian Pengguna dalam menjaga kerahasiaan kode PIN merupakan tanggung jawab Pengguna sepenuhnya. Setiap pengiriman PIN yang diverifikasi dari akun EIDUPAY milik Pengguna akan dianggap sebagai Transaksi dan/atau aktivitas yang sah dari Pengguna, dan oleh karenanya akan mengikat dan memiliki akibat hukum terhadap Pengguna yang bersangkutan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('17.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna setuju untuk menanggung semua risiko yang terkait bila mengungkapkan PIN kepada pihak ketiga manapun dan akan sepenuhnya bertanggung jawab atas setiap konsekuensi apapun yang timbul dari dan terkait dengan hal tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('18.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pihak VJI tidak mengetahui dan tidak akan pernah meminta Pengguna memberitahukan PIN kepada VJI.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('19.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Untuk beberapa smartphone tertentu, terdapat kapabilitas mengaktifkan biometric recognition sebagai pengganti PIN. Segala hal yang terjadi dengan diaktifkannya fitur tersebut merupakan tanggung jawab Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Verifikasi Wajah (Face Verification)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('20.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Face Verification adalah metode otentikasi pengenalan wajah yang disediakan oleh VJI sebagai fitur keamanan yang dapat dipilih oleh Pengguna. Pengguna akan diminta untuk memindai citra wajahnya secara real-time untuk keperluan verifikasi. Ketersediaan fungsi Verifikasi Wajah (Face Verification) akan bergantung pada fitur dan spesifikasi Perangkat Telekomunikasi Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('21.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dengan melakukan aktivasi Verifikasi Wajah (Face Verification), Pengguna mengerti dan menyetujui bahwa citra wajah Pengguna yang dipindai akan diverifikasi dengan foto wajah yang telah diunggah Pengguna ke aplikasi EIDUPAY saat hendak mendaftarkan diri sebagai Akun Premium, untuk mengidentifikasi Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('22.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dengan melakukan aktivasi Verifikasi Wajah (Face Verification), Pengguna juga mengerti dan menyetujui untuk memberikan akses kepada VJI terhadap sistem kamera dan/atau galeri yang terpasang pada Perangkat Telekomunikasi milik Pengguna, untuk selanjutnya dapat memindai citra wajah Pengguna dan menyimpan pada aplikasi EIDUPAY untuk mengidentifikasi Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('23.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Setiap rangkaian aktivasi Verifikasi Wajah (Face Verification) yang dilakukan oleh Pengguna akan dianggap sebagai permintaan yang sah dari Pengguna sendiri. Persetujuan dan/atau penolakan atas permintaan aktivasi Verifikasi Wajah (Face Verification) merupakan kewenangan mutlak VJI dengan memperhatikan ketentuan hukum dan peraturan perundang-undangan yang berlaku. VJI dapat, sewaktu-waktu, menarik persetujuan atas permintaan tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('24.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat menonaktifkan fitur Verifikasi Wajah (Face Verification) setiap saat melalui menu “Settings” yang tersedia pada aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('25.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna setuju untuk menanggung semua risiko yang terkait bila terjadi suatu proses akses yang tidak terotorisasi dan/atau penggunaan Perangkat Telekomunikasi secara tidak sah oleh pihak ketiga manapun dan untuk sepenuhnya bertanggung jawab atas setiap konsekuensi yang terkait dengan hal tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Jika Pengguna mengakses akun EIDUPAY melalui pihak ketiga termasuk namun tidak terbatas pada Merchant, Bank, aplikasi lain atau pihak ketiga manapun yang bekerja sama dengan VJI, maka Pengguna wajib menjaga keamanan penggunaan termasuk namun tidak terbatas terhadap metode otentikasi dan/atau otorisasi dari pihak ketiga (jika ada). EIDUPAY tidak bertanggung jawab terkait dengan metode otentikasi dan/atau otorisasi yang dimiliki pihak ketiga.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text('IV. KLASIFIKASI AKUN EIDUPAY',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Aplikasi EIDUPAY menawarkan 2 (dua) jenis klasifikasi pengguna dengan jenis layanan atau fitur-fitur yang berberda. Klasifikasi pengguna tersebut adalah EIDUPAY Reguler  dan EIDUPAY Premium.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'EIDUPAY Reguler adalah klasifikasi pengguna EIDUPAY unregistered sebagaimana diatur dalam Peraturan Bank Indonesia yang memungkinkan pengguna menikmati fasilitas layanan uang elektronik secara terbatas. ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Maksimum Saldo Rp. 2.000.000,- (dua juta rupiah)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Batas nilai transaksi dalam 1 (satu) bulan paling banyak Rp. 20.000.000,- (dua puluh juita rupiah), yang diperhitungkan dari transaksi yang bersifat incoming.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Fitur Pembelian & Pembayaran tagihan. Untuk dapat memanfaatkan fitur layanan lainnya pada aplikasi EIDUPAY, maka pengguna harus melakukan upgrade akun menjadi EIDUPAY Premium.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'EIDUPAY Premium adalah klasifikasi pengguna EIDUPAY registered sebagaimana diatur dalam Peraturan Bank Indonesia yang memungkinkan pengguna menikmati fasilitas layanan uang elektronik yang lebih luas dibandingkan EIDUPAY Reguler.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Maksimum saldo Rp. 10.000.000,- (sepuluh juta rupiah).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Batas nilai transaksi dalam 1 (satu) bulan paling banyak Rp. 20.000.000,- (dua puluh juita rupiah), yang diperhitungkan dari transaksi yang bersifat incoming',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Seluruh layanan yang di sediakan oleh EIDUPAY saat ini dan/atau ayang aka nada di kemudian hari, Termasuk namun tidak terbatas pada fitur transfer, layanan extended user, Tarik tunai, dan layanan yang lainnya.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Prosedur untuk meng-upgrade akun EIDUPAY Reguler menjadi EIDUPAY Premium:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna EIDUPAY dapat melakukan upgrade melalui prosedur Know Your Customer (KYC) melalui metode yang ditentukan oleh EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Untuk melakukan upgrade, Pengguna EIDUPAY wajib menyampaikan kartu identitas yang masih berlaku dan mengisi spesimen yang disediakan oleh Kami, melakukan swafoto (selfie) melalui media yang diatur oleh Kami.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kartu identitas yang digunakan untuk melakukan upgrade akun adalah Kartu Tanda Penduduk (KTP) elektronik yang masih berlaku (untuk WNI) dan/atau paspor yang masih berlaku (untuk WNA).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kartu identitas yang digunakan untuk melakukan upgrade akun adalah Kartu Tanda Penduduk (KTP) elektronik yang masih berlaku (untuk WNI) dan/atau paspor yang masih berlaku (untuk WNA).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('e.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami berhak sewaktu-waktu meminta Pengguna EIDUPAY untuk memberikan Data pendukung ketika melakukan upgrade dan Pengguna EIDUPAY setuju akan hal tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('f.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami berhak melakukan pengkinian data Pengguna EIDUPAY dalam hal termasuk namun tidak terbatas pada apabila Kami menemukan Data yang tidak berlaku lagi, dan Pengguna EIDUPAY setuju akan hal tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('g.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Apabila Pengguna EIDUPAY tidak berhasil melakukan pengkinian data di jangka waktu yang diberikan EIDUPAY dan apabila EIDUPAY menemukan Data yang tidak berlaku, atau tidak sesuai, EIDUPAY berhak untuk meng-downgrade akun pengguna tersebut dari status Premium ke Reguler.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('h.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami berhak menolak permintaan upgrade Pengguna EIDUPAY, jika Data yang diberikan tidak sesuai dengan Syarat dan Ketentuan Kami.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text('V. BIAYA LAYANAN',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami dapat mengenakan biaya dalam rangka penggunaan layanan pada Aplikasi EIDUPAY, termasuk namun tidak terbatas pada layanan pengisian saldo (top-up), pembayaran, transfer, redeem, dan/atau pencairan uang. Keterangan mengenai jumlah biaya yang dikenakan akan kami sediakan melalui media komunikasi, website, dan/atau media lain yang Kami tentukan dari waktu ke waktu.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Jenis Transaksi dan Biaya',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Notifikasi di dalam Aplikasi	-> Gratis (diperlukan akses internet)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'One Time Pasword SMS	-> Gratis (tidak memotong pulsa)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'TopUP (via inter Bank)	-> Sesuai tarif di Bank Pengirim',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'TopUP via Merchant	->	1.500,-',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Transfer Antar Member	->	Gratis',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Trasfer ke Rek Bank	-> 950,-',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('7.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pembayaran Tagihan ->	2.500,-',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('8.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pembayaran Merchant	->	Gratis',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text('VI. TRANSAKSI TOP UP (ISI SALDO)',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Transaksi top up adalah transaksi pengisian uang elektronik menjadi Saldo EIDUPAY. Terdapat beberapa metode untuk Transaksi top up sebagai berikut:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Anjungan Tunai Mandiri (ATM)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Fitur Debit Langsung (Direct Debit)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Internet Banking',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'SMS Banking; dan',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('e.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Merchant/Agen.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Panduan bertransaksi top up dengan metode di atas dapat diakses dengan mengklik menu “Top Up” pada aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'VJI tidak menyimpan informasi yang digunakan Pengguna dalam melakukan transaksi top up sehubungan dengan kata sandi (password) atau token atau kode keamanan lain dalam bentuk apapun, baik sementara atau permanen ke dalam sistem EIDUPAY. Proses validasi transaksi yang dilakukan melalui Bank atau penyelenggara transaksi akan langsung dilakukan oleh pihak Bank atau penyelenggara transaksi yang bersangkutan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Proses Transaksi top up melalui Bank menggunakan metode-metode di atas, akan diambilalih oleh dan diproses melalui sistem perbankan. Aplikasi EIDUPAY hanya akan meneruskan status Transaksi “Berhasil” atau “Gagal” dari Bank.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dalam hal Transaksi top up dinyatakan “Berhasil” maka saldo Pengguna di rekening pada Bank yang bersangkutan otomatis akan berkurang sedangkan Saldo EIDUPAY akan bertambah untuk jumlah yang sesuai. Apabila Saldo EIDUPAY belum bertambah maka Pengguna dapat menghubungi Kami melalui Layanan Pengguna (Customer Care).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('e.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pada metode SMS Banking, operator telekomunikasi akan mengenakan biaya pengiriman token melalui SMS, dimana biaya tersebut ditentukan secara langsung oleh operator telekomunikasi dan ditanggung oleh Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('f.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna memahami bahwa pengisian uang elektronik yang dilakukan melalui saluran pihak ketiga dapat mengalami gangguan sistem dan/atau jaringan dari waktu ke waktu, namun, yang sepenuhnya merupakan tanggung jawab pihak ketiga tersebut. VJI tidak bertanggung jawab atas gangguan tersebut, namun VJI akan berusaha secara wajar untuk menyelesaikan gangguan dengan saluran pihak ketiga.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('g.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dalam hal transaksi top up melalui fitur debit langsung (direct debit) dari sumber EIDUPAY Pengguna yang terdapat pada pihak ketiga, VJI akan meneruskan instruksi yang Pengguna berikan terkait aktivitas debit langsung (direct debit) tersebut kepada pihak ketiga terkait.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('h.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Informasi yang dimasukkan oleh Pengguna pada fitur debit langsung (direct debit) dapat melekat pada akun EIDUPAY Pengguna, sehingga risiko yang mungkin timbul pada akun EIDUPAY Pengguna dapat mempengaruhi fitur debit langsung (direct debit). Untuk menghindari keragu-raguan, segala risiko yang muncul akibat kesalahan, kelalaian Pengguna dan/atau faktor lain yang tidak disebabkan karena kesalahan VJI, bukan merupakan tanggung jawab VJI.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('i.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Biaya yang dibebankan kepada Pengguna EIDUPAY adalah biaya switching sebagaimana tunduk pada biaya jasa yang berlaku. VJI akan menginformasikan biaya jasa yang berlaku tersebut dari waktu ke waktu.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text('VII. TRANFSER (KIRIM UANG)',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'SALDO EIDUPAY',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Saldo EIDUPAY adalah saldo uang elektronik yang terdapat dalam akun pengguna yang dapat pengguna gunakan untuk berbagai macam transaksi melalui layanan yang tersedia di Aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Saldo EIDUPAY dapat digunakan atau ditransaksikan seluruhnya sampai bersaldo nihil.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat melakukan top-up (atau menambah) saldo EIDUPAY melalui media-media top-up resmi yang Kami sediakan dan diinformasikan melalui situs resmi EIDUPAY dan/atau media komunikasi lainnya.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Terhadap Saldo EIDUPAY tidak berlaku perhitungan bunga, sehingga Pengguna tidak akan memperoleh bunga dalam bentuk apapun. Saldo EIDUPAY bukan merupakan simpanan sebagaimana dimaksud dalam Undang-Undang tentang Perbankan dan Undang-Undang tentang Perbankan Syariah dan tidak akan dijamin oleh Lembaga Penjamin Simpanan sebagaimana diatur dalam Undang-Undang tentang Lembaga Penjamin Simpanan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('B.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'TRANFSER (KIRIM UANG)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Transfer (Kirim uang) merupakan fitur EIDUPAY dimana Pengguna dapat mengirimkan sebagian atau seluruh Saldo EIDUPAY yang tersedia kepada Pengguna EIDUPAY lain, maupun kepada non-Pengguna EIDUPAY melalui rekening Bank, dan/atau melalui media chat/messaging. Fitur ini juga memungkinkan Pengguna dapat mengirimkan sejumlah uang tunai kepada Pengguna EIDUPAY lain atau non-Pengguna EIDUPAY melalui agen yang bekerjasama dengan VJI (Send to Cashier), dengan terlebih dahulu pengirim memasukkan informasi identitas penerima (termasuk namun tak terbatas pada nomor telepon penerima, nama penerima sesuai kartu identitas, dan tanggal lahir penerima) serta nominal uang yang akan dikirimkan pada aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna akan diarahkan untuk memilih metode pengiriman yang tersedia, dan selanjutnya memasukkan informasi mengenai nomor telepon tujuan yang terdaftar sebagai Pengguna EIDUPAY atau nomor rekening Bank, nominal yang akan dikirim serta catatan (bila ada).',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dengan menggunakan fitur Transfer (Kirim Uang), Pengguna mengerti dan menyetujui untuk memberikan akses kepada VJI terhadap kontak nomor handphone pada perangkat elektronik Pengguna untuk digunakan sehubungan dengan pengiriman uang kepada sesama Pengguna EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna bertanggung jawab untuk memastikan bahwa seluruh informasi yang dimasukkan oleh Pengguna adalah benar dan akurat. Segala akibat hukum yang disebabkan oleh kesalahan Pengguna dalam memasukan informasi nomor telepon tujuan dan/atau kesalahan input nominal dan/atau identitas penerima (pada Send to Cashier) yang akan dikirimkan sepenuhnya menjadi tanggung jawab Pengguna, dan VJI tidak memiliki tanggung jawab dalam bentuk apapun.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna juga sepenuhnya setuju dan memahami untuk bertanggung jawab atas kerahasiaan dan kebenaran informasi data penerima yang dimasukkan Pengguna pada aplikasi EIDUPAY untuk fitur Send to Cashier. Segala akibat hukum yang disebabkan oleh kesalahan Pengguna dalam memasukan informasi penerima tersebut dan/atau adanya klaim penerima sepenuhnya menjadi tanggung jawab Pengguna, dan VJI tidak memiliki tanggung jawab dalam bentuk apapun. Pengguna setuju dan memahami bahwa informasi yang dimasukkan Pengguna akan sepenuhnya menjadi milik VJI sesuai Kebijakan Privasi VJI.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Fitur kirim uang atas Saldo EIDUPAY dan fitur Send to Cashier hanya dapat diakses dan digunakan oleh Akun Premium sesuai Syarat dan Ketentuan ini.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('C.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'TARIK SALDO',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Tarik saldo (Cash Out) adalah fitur penarikan Saldo EIDUPAY melalui rekening Bank yang terdaftar dalam aplikasi EIDUPAY atau melalui pihak lain yang bekerjasama dengan EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Jumlah saldo penarikan ditentukan oleh Pengguna EIDUPAY dengan ketentuan mengikuti jumlah maksimum dan minimum pada sekali penarikan, yang tertera dalam aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Biaya yang berlaku dalam penarikan ke rekening bank akan dibebankan ke Pengguna EIDUPAY dan akan dipotong dari Saldo EIDUPAY saat penarikan sedang diproses. Biaya yang berlaku akan diinformasikan dari waktu ke waktu oleh VJI kepada Pengguna, termasuk jika ada promo bebas biaya tarik saldo yang ditetapkan oleh EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'VJI tidak bertanggung jawab atas kesalahan Pengguna EIDUPAY dalam menginput informasi Bank yang didaftarkan oleh Pengguna EIDUPAY. VJI juga tidak bertanggung jawab apabila penarikan Saldo EIDUPAY dilakukan oleh Pengguna ke rekening tabungan di suatu Bank yang bukan atas nama Pengguna sebagai penerima uang kiriman. Seluruh akibat hukum yang timbul dari penarikan Saldo EIDUPAY yang dilakukan Pengguna merupakan tanggung jawab Pengguna sepenuhnya.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'VJI tidak bertanggung jawab jika terjadi masalah pada pihak Bank dan/atau Agen, sehingga tidak dapat memproses penarikan Saldo EIDUPAY sejauh VJI sudah berhasil mengirimkan instruksi transfer kepada Bank dan/atau Agen yang bersangkutan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Fitur tarik saldo hanya dapat diakses dan digunakan oleh Akun Premium sesuai Syarat dan Ketentuan ini.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('D.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PEMBELIAN/ISI ULANG DAN PEMBAYARAN TAGIHAN',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pembelian/ isi ulang pulsa operator telekomunikasi atau operator lainnya dapat dilakukan melalui aplikasi EIDUPAY dengan denominasi yang tersedia atau sesuai petunjuk yang ditampilkan dalam aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pembayaran tagihan pasca bayar atau tagihan rutin bulanan seperti tagihan sekolah, listrik, tagihan air, tagihan berlangganan internet, tagihan telkom, dan tagihan rutin lainnya dapat dilakukan melalui aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'VJI tidak bertanggung jawab atas kerugian akibat kesalahan/kelalaian Pengguna dalam menginput rincian informasi, nominal dan data pembayaran.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('E.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'PEMBELANJAAN DI MERCHANT ATAU PEMBELIAN BARANG/JASA',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat melakukan transaksi pembayaran untuk pembelanjaan di Merchant atau pembelian barang/jasa menggunakan aplikasi EIDUPAY termasuk sarana lainnya milik pihak ketiga yang terhubung dengan layanan EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dalam transaksi pembayaran untuk pembelanjaan di Merchant atau pembelian barang/jasa atau pembelian barang/jasa menggunakan aplikasi EIDUPAY, Pengguna akan juga akan tunduk pada syarat dan ketentuan pembelian yang diberlakukan pada / oleh Merchant dan/atau penyedia barang/jasa tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Segala bentuk promosi pada Merchant EIDUPAY tunduk pada masing-masing syarat dan ketentuan promosi yang berlaku serta periode promosi tertentu. Bentuk, syarat dan ketentuan, serta periode promosi merupakan wewenang mutlak VJI.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('F.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'EXTENTION USER',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Extention User adalah fitur untuk menambahkan keluarga/teman/sahabat untuk dapat mengakses alokasi EIDUPAY yang pengguna berikan. Penambahan dilakukan dengan mendaftarkan nama, nomor telepon, relasi dan PIN extention user.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat mengatur PIN extention user, jumlah saldo, limit transaksi yang dapat diubah-ubah sewaktu-waktu oleh Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Jumlah saldo Extention user ditentukan oleh Pengguna EIDUPAY dengan ketentuan mengikuti jumlah maksimum pemegang akun regular sebagaimana diatur dalam ketentuan ini.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'VJI tidak bertanggung jawab atas kesalahan Pengguna EIDUPAY dalam menginput informasi nama, nomor telepon, PIN pengguna tambahan yang didaftarkan oleh Pengguna EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Fitur extention user hanya dapat diakses dan digunakan oleh Akun Premium sesuai Syarat dan Ketentuan ini.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('G.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PENGATURAN TAGIHAN (E-LING)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'E-LING adalah fitur EIDUPAY yang memungkinkan Pengguna mengatur tagihan-tagihan yang dimilikinya dimana EIDUPAY akan memberikan notifikasi pengingat (reminder) untuk pembayaran tagihan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat mengatur pengingat (reminder) untuk layanan tagihan-tagihan dengan pihak-pihak yang telah bekerjasama dengan VJI sebagaimana yang tercantum dalam aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat mengatur tanggal penagihan yang dapat diubah-ubah sewaktu-waktu oleh Pengguna.r',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'EIDUPAY tidak akan memberikan reminder apabila Pengguna sudah melakukan pembayaran atas tagihannya.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna dapat melakukan pengecekan atas detil pembayaran yang berhasil atas tagihannya di laman statement (history) pada aplikasi EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'VJI dapat menyediakan fitur pengaturan tagihan lainnya, termasuk namun tidak terbatas pada adanya fitur langganan atas tagihan berdasarkan persetujuan Pengguna. Pengguna harus tunduk pada syarat dan ketentuan serta alur aktivasi fitur langganan, jika Pengguna ingin mengaktifkan fitur tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('H.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'EIDUPAY PADA APLIKASI PIHAK KETIGA',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna yang melakukan Transaksi menggunakan layanan pembayaran pada aplikasi EIDUPAY melalui aplikasi atau platform milik pihak ketiga/partner/merchant yang bekerjasama dengan VJI, maka Pengguna mengerti dan memahami untuk tunduk pada syarat dan ketentuan yang lebih khusus yang diatur oleh pihak ketiga tersebut dan/atau syarat dan ketentuan khusus yang ditetapkan lebih lanjut oleh VJI pada aplikasi pihak ketiga tersebut (sebagaimana relevan). VJI tidak bertanggung jawab atas kelalaian/kesalahan Pengguna yang melakukan Transaksi di aplikasi milik pihak ketiga tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('I.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'KERJASAMA PIHAK KETIGA DALAM APLIKASI EIDUPAY',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna setuju dan menundukan diri pada Syarat dan Ketentuan Aplikasi EIDUPAY serta syarat dan ketentuan yang lebih khusus dalam produk atau fitur kerjasama pihak ketiga dengan PT VJI yang dapat diakses dalam aplikasi EIDUPAY, baik yang tersedia saat ini maupun di masa mendatang dengan pemberitahuan sebelumnya, termasuk namun tidak terbatas pada bentuk kerjasama merchant, partner (termasuk bank), aggregator, maupun jasa layanan pembayaran/keuangan lainnya.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VIII.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'JANGKA WAKTU',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IX.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'PENONAKTIFAN AKUN (BLOKIR), ATAU PENURUAN STATUS (DOWNGRADE)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Penonaktifan (blockir) akun EIDUPAY baik secara sementara atau permanen, seluruhnya atau sebagian fitur dapat terjadi, sesuai dengan kebijakan VJI termasuk namun tidak terbataas pada kejadian-kejadian berikut ini:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna memasukkan PIN yang salah sebanyak 3 (tiga) kali berturut-turut;',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna mengajukan permintaan resmi, baik karena adanya laporan Pengguna bahwa telepon seluler telah hilang atau telah dicuri atau diretas. Pengguna wajib menyertakan informasi/dokumen tambahan sehubungan dengan keperluan permintaan Pengguna.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dilakukan secara sepihak oleh VJI dikarenakan terdapat hal yang menurut kebijakan VJI memiliki suatu indikasi yang merugikan VJI dan/atau indikasi pelanggaran serta ketentuan hukum yang berlaku, dengan atau tanpa pemberitahuan terlebih dahulu kepada Pengguna, termasuk namun tidak terbatas pada:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('i.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Permintaan blockir dari otoritas negara atau otoritas penegak hukum yang berwenang, atau;',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ii.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Apabila Pengguna menggunakan layanan EIDUPAY yang menyebabkan terjadinya pelanggaran terhadap Syarat dan Ketentuan Pengguna dan/atau Kebijakan Privasi EIDUPAY, atau;',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('iii.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Apabila Pengguna memberikan data/ informasi dan keterangan yang tidak benar atau menyesatkan sebagian atau seluruhnya pada saat melakukan pendaftaran atau selama menggunakan EIDUPAY, atau;',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('iv.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Adanya indikasi penyalahgunaan EIDUPAY untuk kegiatan yang melanggar hukum dan peraturan perundang-undangan yang berlaku, atau;',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('v.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pihak lain yang melaporkan adanya tindakan mencurigakan dari akun tersebut disertai dengan bukti-bukti yang dianggap cukup untuk keperluan investigasi.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('vi.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Akun EIDUPAY tidak digunakan untuk jangka waktu minimum selama 6 (enam) bulan berturut-turut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('vii.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Apabila VJI berdasarkan pertimbangannya sendiri yang cukup beralasan memiliki alasan kuat lainnya.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dalam hal akun Anda telah diblokir sementara dan berdasarkan bukti pendukung yang kuat yang Anda berikan tidak terdapat hal yang mencurigakan, Anda dapat menghubungi Kami sesuai ketentuan Syarat dan Ketentuan ini. Kami akan melakukan pemeriksaan lebih lanjut untuk menentukan apakah akan mengakhiri atau meneruskan pemblokiran akun Anda tersebut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami berhak untuk menonaktifkan secara permanen atau sementara akses Anda ke akun EIDUPAY Anda atau platform Partner EIDUPAY apabila ditemukan terjadinya indikasi penipuan atau kejahatan, baik yang Kami temukan atau atas bukti pendukung yang kuat yang diajukan oleh pihak ketiga atas akun Anda.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Di samping kami berwenang untuk melakukan penonaktifan (blokir) akun Anda berdasarkan salah satu atau lebih hal yang disebutkan dalam poin (1) di atas, kami juga berhak untuk melakukan penurunan status (downgrade) akun EIDUPAY Premium anda menjadi EIDUPAY Reguler, sesuai dengan ketentuan yang berlaku.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('X.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'AKUN TIDAK AKTIF (DORMANT ACCOUNT)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '“Akun Tidak Aktif” atau Dormant Account adalah akun yang tidak terdapat transaksi keuangan selama 6 (enam) bulan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Pengguna EIDUPAY dapat mengaktifkan kembali Akun Tidak Aktif, dengan cara melakukan 1 kali transaksi selambat-lambatnya dalam waktu 1 (satu) bulan sejak tanggal dinyatakan Akun Tidak Aktif. Akun Tidak Aktif tidak dapat melakukan transaksi finansial dan pembayaran di Merchant EIDUPAY.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('c.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Segera setelah jangka waktu sesuai angka (2) di atas berakhir, maka:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Jika Akun Saldo EIDUPAY anda Rp 0 (nol Rupiah), kami akan melakukan penutupan atas Akun Tidak Aktif Anda tersebut secara permanen.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('b.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Jika anda masih mempunyai saldo EIDUPAY, kami akan melakukan penonaktifan akun.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('d.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Setelah akun EIDUPAY udah di non-aktifkan, EIDUPAY akan memberlakukan biaya pemeliharaan akun yang sudah di blokir karena Dormant Account yang akan diambil dari saldo EIDUPAY yang tersisa di dalam akun EIDUPAY. Ketentuan mengenai biaya pemeliharaan akun akan ditentukan kemudian oleh kami sebagai bagian yang tidak terpisahkan dari Syarat dan Ketentuan ini.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('e.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Anda dapat mengklaim saldo EIDUPAY anda dengan cara menghubungi Customer Service EIDUPAY setelah akun anda dinonaktifkan.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('f.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Dalam jangka waktu 1 (satu) bulan tersebut, Anda juga dapat melakukan penarikan saldo EIDUPAY dalam Akun Tidak Aktif Anda tersebut, dan Anda dapat juga menghubungi kami untuk meminta informasi lebih lanjut.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('XI.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PENUTUPAN AKUN',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t100),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('a.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Kami berhak untuk menutup akun Anda, di mana untuk jangka waktu tertentu atau untuk seterusnya berdasarkan pertimbangan atau keputusan Kami yang Kami anggap baik, apabila terjadinya satu atau lebih kondisi di bawah ini:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: t100)),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Permintaan sendiri selaku pemilik akun yang disampaikan melalui jalur pengaduan resmi Layanan Pelanggan (Customer Care), dengan memenuhi rangkaian proses dan persyaratan yang diminta oleh VJI;',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: t70),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: desc('2.',
                'Adanya permintaan dari otoritas negara atau otoritas penegak hukum yang berwenang'),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: desc('3.',
                'Kebijakan VJI berdasarkan hukum dan peraturan perundang-undangan yang berlaku.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('4.',
                'Akun atau Transaksi dalam akun Anda dinyatakan fraud (berdasarkan hasil investigasi Kami sendiri dan/atau dengan pihak kepolisian, dan/atau pihak ketiga);'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('5.',
                'Keadaan Memaksa yang terjadi selama 3 (tiga) bulan atau lebih secara berturut-turut; dan/atau'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('6.',
                'Penghentian kegiatan operasional EIDUPAY karena alasan apapun.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('b.',
                'VJI akan mengembalikan saldo uang elektronik EIDUPAY kepada Pengguna atas adanya penutupan akun EIDUPAY setelah dikurangi biaya terutang (bila ada), kecuali jika berdasarkan pertimbangan VJI diperlukan adanya penahanan bagian tertentu dari saldo EIDUPAY, misalnya karena keyakinan yang wajar bahwa bagian tersebut sehubungan dengan atau disebabkan oleh penipuan, penyalahgunaan, tindak pelanggaran hukum lainnya, atau pelanggaran terhadap Syarat dan Ketentuan ini.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('c.',
                'Sehubungan dengan penutupan akun EIDUPAY, Pengguna dan EIDUPAY setuju untuk mengesampingkan keberlakuan Pasal 1266 Kitab Undang-Undang Hukum Perdata, sepanjang mengenai diperlukannya suatu putusan pengadilan untuk penutupan akun EIDUPAY dan/atau pengakhiran Syarat dan Ketentuan ini.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XII.', 'HAK MELAKUKAN KOREKSI'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('a.',
                'VJI berhak untuk melakukan koreksi atas Saldo dan/atau transaksi pada akun Anda, apabila menurut catatan Kami telah terjadi kesalahan dalam transaksi, sistem, jaringan, maupun kesalahan dalam bentuk lain, koreksi tersebut termasuk atas pertimbangan dan keyakinan Kami yang wajar untuk melakukan penahanan sebagian atau seluruh saldo berhubungan dengan atau disebabkan oleh penipuan, penggelapan, penyelahgunaan dan/atau tindakan pelanggaran hukum lain.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('b.',
                'Terhadap permintaan koreksi oleh pihak ketiga, VJI akan melakukan tinjauan dan memutuskan berdasarkan penilaian dan kebijakan VJI. VJI tidak akan melakukan koreksi terhadap Saldo EIDUPAY tanpa adanya informasi yang dianggap cukup bagi VJI untuk membuktikan adanya kesalahan dalam Transaksi.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('c.',
                'Sehubungan dengan kepentingan koreksi sebagaimana disebutkan dalam angka 1) dan angka 2), Pengguna dengan ini memberikan kuasa yang tidak dapat ditarik kembali kepada VJI untuk mendebet dan/atau mengkredit Saldo EIDUPAY Pengguna. Kuasa sebagaimana dimaksud akan terus berlaku dan tidak dapat berakhir karena alasan apapun juga termasuk karena alasan-alasan sebagaimana diatur dalam Pasal 1813, 1814, dan 1816 Kitab Undang-Undang Hukum Perdata.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XIII.', 'INFORMASI DAN JALUR PENGADUAN RESMI'),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc2(
                'Pengguna dapat mengajukan pertanyaan seputar layanan EIDUPAY atau menyampaikan keluhan dengan menghubungi Layanan Pengguna (Customer Care) EIDUPAY melalui:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('-', 'WhatsApp Chat ke nomor 08119007911'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('-', 'Melalui email ke supprt@eidupay.com; atau'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('-', 'Sambungan telepon ke nomor 021-7994444.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc2(
                'Informasi terkait layanan EIDUPAY serta promosi yang berlangsung dapat dilihat di aplikasi EIDUPAY atau situs: www.eidupay.com.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XIV.', 'KEWAJIBAN, PERNYATAAN DAN JAMINAN'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('a.',
                'Anda hanya dapat mengakses atau menggunakan Aplikasi EIDUPAY (a) sesuai dengan Syarat dan Ketentuan ini, (b) untuk tujuan yang sah, dan (c) tidak digunakan untuk tujuan atau tindakan penipuan, pelanggaran hukum, kriminal maupun tindakan, aktivitas, perbuatan atau tujuan lain yang melanggar atau bertentangan dengan hukum, peraturan perundang-undangan yang berlaku maupun hak atau kepentingan pihak manapun. Anda bertanggung jawab penuh untuk memeriksa dan memastikan bahwa Anda telah mengunduh (download) perangkat lunak yang benar untuk perangkat Anda. Kami tidak bertanggung jawab jika Anda tidak memiliki perangkat yang kompatibel dengan Aplikasi EIDUPAY atau jika Anda telah mengunduh (download) versi software yang salah untuk perangkat Anda.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('b.',
                'Anda dilarang untuk menggunakan Aplikasi EIDUPAY atau melakukan Transaksi: (a) untuk tujuan, kegiatan, aktivitas atau aksi yang melanggar hukum atau melanggar hak atau kepentingan (termasuk Hak Kekayaan Intelektual atau hak privasi) milik pihak manapun; (b) yang memiliki materi atau unsur yang berbahaya atau yang merugikan pihak manapun; (c) yang mengandung virus software, worm, trojan horses atau kode komputer berbahaya lainnya, file, script, agen atau program; dan (d) yang mengganggu integritas atau kinerja Aplikasi EIDUPAY dan sistem pendukungnya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('c.',
                'Penggunaan atas Akun EIDUPAY dan/atau layanan EIDUPAY merupakan pengakuan dan persetujuan Pengguna untuk tunduk pada (i) Syarat dan Ketentuan Aplikasi EIDUPAY; (ii) syarat dan ketentuan khusus EIDUPAY yang bekerja sama dengan penyedia aplikasi pihak ketiga; (iii) syarat dan ketentuan khusus terkait promo; (iv) syarat dan ketentuan khusus yang berlaku untuk masing-masing fitur layanan yang tersedia dalam aplikasi EIDUPAY; (v) kebijakan privasi; dan (vi) setiap ketentuan hukum dan peraturan perundang-undangan yang berlaku.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('d.',
                'Anda dilarang untuk melakukan tindakan apapun termasuk dalam atau melalui Aplikasi EIDUPAY yang dapat merusak atau mengganggu reputasi Kami.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('e.',
                'Pengguna dengan ini menyatakan dan menjamin bahwa pihaknya akan bertanggung jawab sepenuhnya atas semua layanan EIDUPAY yang diakses menggunakan nomor ID Pengguna miliknya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('f.',
                'Anda diwajibkan untuk memastikan tidak memberitahukan informasi keamanan Anda kepada pihak lain manapun, termasuk pegawai EIDUPAY. Setiap perintah Transaksi yang dibuat melalui akun EIDUPAY Anda dari Aplikasi EIDUPAY atau merchant yang telah Anda berikan otorisasi baik dengan pin dan/atau biometric recognition untuk beberapa smartphone tertentu, akan dianggap sebagai perintah/instruksi Anda yang benar, sah, atau valid kepada EIDUPAY untuk memproses transaksi tersebut. Anda akan menanggung segala kerugian yang ditimbulkan karena kelalaian Anda, termasuk apabila Anda lalai dalam menjaga keamanan akun EIDUPAY Anda, dan dengan ini menyatakan untuk menyetujui dan membebaskan EIDUPAY dari segala tuntutan, gugatan, dan/atau ganti kerugian yang timbul atas kelalaian tersebut.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('g.',
                'Anda dengan ini secara tegas menyetujui serta menyatakan dan menjamin bahwa:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('1.',
                'Anda adalah individu yang secara hukum cakap untuk melakukan tindakan hukum berdasarkan hukum negara Republik Indonesia termasuk untuk mengikatkan diri dalam Syarat dan Ketentuan ini. Jika anda di bawah usia 18 (delapan belas) tahun atau di bawah pengampuan, Anda menjamin bahwa pembukaan akun EIDUPAY telah disetujui oleh orang tua, wali atau pengampu Anda yang sah.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('2.',
                'Anda memiliki hak, wewenang dan kapasitas untuk menggunakan Aplikasi EIDUPAY serta untuk mematuhi dan melaksanakan seluruh Syarat dan Ketentuan ini.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('3.',
                'Jika Anda melakukan pendaftaran atau mengunduh Aplikasi atas nama suatu badan hukum, persekutuan perdata atau pihak lain, Anda dengan ini menyatakan dan menjamin bahwa Anda memiliki kapasitas, hak dan wewenang yang sah untuk bertindak untuk dan atas nama badan usaha atau pihak lain tersebut termasuk tetapi tidak terbatas pada mengikat badan usaha atau pihak lain tersebut untuk tunduk pada seluruh isi Syarat dan Ketentuan ini.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('4.',
                'Anda menyatakan dan menjamin bahwa EIDUPAY yang dipergunakan dalam rangka transaksi bukan EIDUPAY yang berasal dari tindak pidana yang dilarang berdasarkan peraturan perundang-undangan yang berlaku di Republik Indonesia, pembukaan rekening ini tidak dimaksudkan dan/atau ditujukan dalam rangka upaya melakukan tindak pidana pencucian uang sesuai dengan ketentuan peraturan perundang-undangan yang berlaku, transaksi tidak dilakukan untuk maksud mengelabui, mengaburkan, atau menghindari pelaporan kepada Pusat Pelaporan dan Analisis Transaksi Keuangan (PPATK) berdasarkan ketentuan peraturan perundang-undangan yang berlaku, dan Anda bertanggung jawab sepenuhnya serta melepaskan Kami dari segala tuntutan, klaim, atau ganti rugi dalam bentuk apapun, apabila Anda melakukan tindak pidana pencucian uang berdasarkan ketentuan peraturan perundang-undangan yang berlaku.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('5.',
                'Seluruh Data baik yang telah Anda sampaikan atau cantumkan maupun yang akan Anda sampaikan atau cantumkan baik langsung maupun tidak langsung di kemudian hari atau dari waktu ke waktu adalah benar, lengkap, akurat terkini dan tidak menyesatkan serta tidak melanggar hak (termasuk tetapi tidak terbatas pada Hak Kekayaan Intelektual) atau kepentingan pihak manapun. Penyampaian Data oleh Anda kepada Kami atau pada atau melalui Aplikasi atau sistem tidak bertentangan dengan hukum yang berlaku serta tidak melanggar akta, perjanjian, kontrak, kesepakatan atau dokumen lain di mana Anda merupakan pihak atau di mana Anda atau aset Anda terikat.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('6.',
                'Aplikasi EIDUPAY akan digunakan untuk kepentingan Anda sendiri atau untuk kepentingan badan usaha atau pihak lain yang secara sah Anda wakili sebagaimana dimaksud huruf (c) di atas.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('7.',
                'Anda tidak akan memberikan hak, wewenang dan/atau kuasa dalam bentuk apapun dan dalam kondisi apapun kepada orang atau pihak lain untuk menggunakan Data, akun EIDUPAY, OTP dan/atau Personal Identication Number (PIN), dan Anda karena alasan apapun dan dalam kondisi apapun tidak akan dan dilarang untuk mengalihkan akun EIDUPAY kepada orang atau pihak manapun.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('8.',
                'Dalam atau pada saat menggunakan Aplikasi EIDUPAY, Anda setuju untuk mematuhi dan melaksanakan seluruh ketentuan hukum dan peraturan perundang-undangan yang berlaku termasuk hukum dan peraturan perundang-undangan di negara asal Anda maupun di negara atau kota dimana Anda berada.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('h.',
                'Dengan melaksanakan transaksi melalui Aplikasi EIDUPAY, Anda memahami bahwa seluruh komunikasi dan instruksi dari Anda yang diterima oleh Kami akan diperlakukan sebagai bukti solid meskipun tidak dibuat dalam bentuk dokumen tertulis atau diterbitkan dalam bentuk dokumen yang ditandatangani, dan, dengan demikian, Anda setuju untuk mengganti rugi dan melepaskan Kami dan rekanan-rekanan Kami dari segala kerugian, tanggung jawab, tuntutan dan pengeluaran (termasuk biaya litigasi) yang dapat muncul terkait dengan eksekusi dari instruksi Anda.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('i.',
                'Pengguna dengan ini menyatakan memahami dan setuju bahwa layanan yang disediakan melalui EIDUPAY disediakan “sebagaimana adanya” dan “sebagaimana tersedia”, tanpa adanya jaminan dari VJI bahwa layanan yang disediakan melalui EIDUPAY sesuai untuk tujuan atau kebutuhan tertentu dari Pelanggan. Dalam hal ini, EIDUPAY tidak memberikan jaminan bahwa (i) penggunaan EIDUPAY dapat memenuhi seluruh kebutuhan Pelanggan, (ii) EIDUPAY akan tersedia terus menerus tanpa gangguan/error, (iii) setiap ketidaksesuaian dalam aplikasi EIDUPAY akan diperbaiki untuk memenuhi keinginan Pengguna. Namun VJI tetap akan berusaha sebaik-baiknya dan sewajarnya untuk menyediakan layanan yang terbaik bagi Pengguna.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XV.', 'BATASAN TANGGUNG JAWAB'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('a.',
                'Untuk mencegah terjadinya penyalahgunaan data atau Akun EIDUPAY Pengguna maka Pengguna wajib mengingat dan menjaga kerahasiaan informasi data yang dimilikinya, termasuk namun tidak terbatas pada Nomor Ponsel (Handphone) yang digunakan pada akun EIDUPAY atau Nomor Ponsel alternatif , kata sandi (password) atau PIN atau kode verifikasi maupun Kode OTP, jawaban dari pertanyaan rahasia yang didaftarkan atau data lainnya yang diberikan Pengguna atau diterima oleh Pengguna terkait Transaksi atau atas setiap kegiatan atau Transaksi yang terjadi/dilakukan oleh Pengguna dengan tidak mengungkapkannya kepada pihak manapun. Pengguna bertanggung jawab sepenuhnya atas segala akibat dan risiko yang timbul sehubungan dengan kelalaian Pengguna dalam menjaga kerahasiaan informasi data Pengguna yang dimilikinya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('b.',
                'Pengguna wajib menjaga informasi sebagaimana disebut di atas, dari peristiwa antara lain kehilangan, kerusakan, penyalahgunaan oleh pihak yang tidak bertanggungjawab atau pemalsuan. Pengguna dengan ini mengetahui dan menyetujui untuk melepaskan VJI dari tanggung jawab dan ganti kerugian dalam bentuk apapun kepada Pengguna atau pihak manapun atas hal-hal yang terjadi di luar kesalahan dan/atau kelalaian VJI termasuk tetapi tidak terbatas pada hal-hal:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('a.',
                'Kehilangan atau kerusakan Perangkat Telekomunikasi atau Nomor Ponsel;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('b.',
                'Akses tidak sah terhadap informasi pribadi Pengguna yang terjadi di luar lingkup tanggung jawab VJI atau pada/melalui aplikasi milik pihak ketiga;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('c.',
                'Setiap kerugian yang terjadi yang diakibatkan karena Pengguna EIDUPAY terindikasi melanggar hukum dan/atau terdapat penyalahgunaan oleh pihak lain yang tidak berwenang;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('c.',
                'Dalam hal terjadi kehilangan Telepon Genggam baik karena pencurian, kehilangan atau alasan apapun maka Pengguna wajib segera menghubungi Layanan Pengguna (Customer Care) EIDUPAY untuk melakukan pemblokiran atas Rekening EIDUPAY. Pengguna dengan ini membebaskan dan melepaskan VJI dari segala risiko dan akibat yang timbul dan diderita oleh Pengguna sehubungan dengan kehilangan Nomor Ponsel atau Nomor Ponsel alternatif atau kelalaian Pengguna.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('d.',
                'VJI sesuai kebijakannya berhak untuk menolak permohonan pendaftaran layanan EIDUPAY oleh Pengguna tanpa memberitahukan alasannya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('e.',
                'Pengguna dengan ini diwajibkan untuk memeriksa, memastikan dan menjamin bahwa seluruh informasi dan data yang didaftarkan atau diberikan selama mempergunakan EIDUPAY adalah akurat, benar, dan lengkap, serta tidak menyesatkan. Oleh sebab itu Pengguna membebaskan dan melepaskan VJI dari segala bentuk gugatan, tuntutan dan/atau ganti kerugian baik yang berasal dari Pengguna atau pihak manapun dan dalam bentuk apapun sehubungan dengan kelalaian dan/atau kegagalan Pengguna dalam mematuhi seluruh ketentuan dalam Syarat dan Ketentuan ini.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('f.',
                'Apabila Transaksi telah diselesaikan maka Pengguna dengan ini mengakui dan menyetujui bahwa transaksi TIDAK DAPAT ditarik kembali dengan alasan apapun juga dan Transaksi akan tetap diproses sesuai dengan informasi dan data yang telah didaftarkan dan dimasukkan oleh Pengguna.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('g.',
                'Pengguna akan dikenakan biaya-biaya sehubungan dengan layanan EIDUPAY sesuai dengan peraturan yang berlaku di EIDUPAY termasuk namun tidak terbatas pada biaya Transaksi, biaya layanan pesan singkat (SMS) dan biaya-biaya lainnya yang akan diinformasikan kepada Pengguna melalui media komunikasi yang digunakan untuk produk EIDUPAY. Pengguna layanan aplikasi EIDUPAY harus menggunakan layanan telekomunikasi data, dan Pengguna bertanggung jawab untuk mengadakan konektivitas telekomunikasi data tersebut, termasuk sehubungan dengan tarif akses data atas konektivitas tersebut. Biaya dan ketentuan penggunaannya akan diatur oleh operator jasa telekomunikasi yang digunakan oleh Pengguna.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('h.',
                'Dalam hal terjadi gangguan teknis pada jaringan atau dalam hal sedang dilakukan peningkatan layanan atau jaringan, perubahan layanan atau jaringan, perbaikan dan/atau pemeliharaan layanan atau jaringan yang digunakan oleh VJI sehingga menyebabkan gangguan pada layanan EIDUPAY, maka VJI akan segera menangani dan/atau memperbaikinya dalam jangka waktu maksimum 1 (satu) hari kerja dan atas hal tersebut Pengguna akan menerima pemberitahuan dari aplikasi EIDUPAY. VJI akan menyampaikan pemberitahuan lebih lanjut apabila diperlukan waktu yang lebih lama untuk menangani dan/atau memperbaiki gangguan teknis tersebut.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('i.',
                'Dalam hal terjadi kesalahan sistem EIDUPAY karena alasan apapun yang mengakibatkan terganggunya layanan EIDUPAY atau kesalahan dalam pelaksanaan layanan atau Transaksi yang bukan disebabkan oleh Pengguna, maka VJI akan memperbaiki kesalahan tersebut dengan sesegera mungkin.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('j.',
                'Anda dengan ini setuju dan mengikatkan diri untuk membebaskan Kami dari setiap dan seluruh klaim dalam bentuk apapun, dari pihak manapun dan dimanapun yang diajukan, timbul atau terjadi sehubungan dengan atau sebagai akibat dari:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('a.',
                'penggunaan Data oleh Kami berdasarkan Syarat dan Ketentuan ini atau berdasarkan persetujuan, pengakuan, wewenang, kuasa dan/atau hak yang Anda berikan baik secara langsung maupun tidak langsung kepada Kami dalam Syarat dan Ketentuan ini;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('b.',
                'pemberian Data baik secara langsung maupun tidak langsung oleh Anda kepada Kami atau dalam atau melalui Aplikasi EIDUPAY yang Anda lakukan secara (i) melanggar atau melawan hukum atau peraturan perundang-undangan yang berlaku, (ii) melanggar hak (termasuk hak kekayaan intelektual) dari atau milik orang atau pihak manapun, atau (iii) melanggar kontrak, kerjasama, kesepakatan, akta, pernyataan, penetapan, keputusan dan/atau dokumen apapun dimana Anda merupakan pihak atau dimana Anda atau aset Anda terikat;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('c.',
                'penggunaan Aplikasi, Akun dan/atau Layanan (i) secara tidak sah, (ii) melanggar hukum yang berlaku, (iii) melanggar Syarat dan Ketentuan ini, dan/atau (iv) untuk tindakan atau tujuan penipuan, kriminal, tindakan tidak sah atau tindakan pelanggaran hukum lainnya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XVI.', 'KEAMANAN DAN KERAHASIAAN TRANSAKSI'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('a.',
                'VJI sangat memperhatikan keamanan dan kenyamanan Pengguna pada saat menggunakan layanan EIDUPAY. Oleh karena itu VJI memiliki sistem keamanan ketika Pengguna melakukan transaksi untuk memberikan kepastian kepada Pengguna bahwa Transaksi Pengguna aman dan Informasi serta data pribadi Pengguna disimpan dan dipergunakan sesuai dengan Kebijakan Privasi aplikasi EIDUPAY dengan tunduk pada peraturan dan perundang-undangan yang berlaku.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('b.',
                'EIDUPAY menggunakan server yang memadai dalam menjaga keamanan informasi rahasia Pengguna. Seluruh informasi yang bersifat sensitif akan dikirimkan melalui teknologi Secure Socket Layer (SSL) dalam keadaan mana data tersebut hanya dapat diakses oleh personil yang memiliki wewenang khusus yang disyaratkan untuk selalu menjaga kerahasiaan informasi tersebut.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('c.',
                'VJI menerapkan langkah-langkah wajar untuk memastikan PIN milik Pengguna tidak diketahui oleh siapapun kecuali oleh Pengguna untuk menghindari terjadinya penyalahgunaan oleh pihak lain. Dengan demikian, Pengguna bertanggung jawab penuh atas kerahasiaan PIN milik Pengguna.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('d.',
                'Dalam hal VJI memiliki kerjasama dengan pihak ketiga lainnya sehubungan dengan penyediaan akses ke layanan EIDUPAY untuk Pengguna melalui sarana pihak ketiga tersebut maka:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('i.',
                'VJI dapat menampilkan informasi Pengguna dan informasi lain kepada pihak ketiga tersebut untuk tujuan pemeliharaan keamanan sistem.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('ii.',
                'VJI dapat menggunakan sarana otorisasi selain EIDUPAY yang ditentukan bersama oleh VJI dan pihak ketiga yang bekerjasama dengan VJI.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('iii.',
                'VJI menjamin bahwa ketentuan pelaksanaan sebagaimana yang dimaksud di bagian i) dan ii) telah memenuhi standar keamanan dan ketentuan EIDUPAY serta peraturan perundang-undangan yang berlaku.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XVII.', 'PERLINDUNGAN DAN KERAHASIAAN DATA'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc2(
                'Anda setuju bahwa pengumpulan, pemanfaatan dan penyerahan Data yang Anda sampaikan kepada Kami akan dilakukan dengan tunduk kepada Syarat dan Ketentuan ini dan kebijakan privasi yang terdapat di: www.eidupay.com/kebijakan-privasi yang menjadi satu kesatuan yang tak terpisahkan dengan Syarat dan Ketentuan ini.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XVIII', 'HAK KEKAYAAAN INTELEKTUAL'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('a.',
                'Seluruh Aplikasi EIDUPAY dan sistem pendukungnya termasuk tetapi tidak terbatas pada seluruh: (a) layout, desain dan tampilan Aplikasi EIDUPAY yang terdapat dalam atau ditampilkan pada media Aplikasi EIDUPAY; (b) logo, foto, gambar, nama, merek, kata, huruf-huruf, angka-angka, tulisan, dan susunan warna yang terdapat dalam Aplikasi EIDUPAY; dan (c) kombinasi dari unsur-unsur sebagaimana dimaksud dalam huruf (a) dan (b), sepenuhnya merupakan Hak Kekayaan Intelektual milik Kami dan tidak ada pihak lain yang turut memiliki hak atas Aplikasi maupun atas layout, desain dan tampilan Aplikasi.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: desc('b.',
                'Anda tidak diperkenankan dari waktu ke waktu untuk (i) menyalin, memodifikasi, mengadaptasi, menerjemahkan, membuat karya turunan dari, mendistribusikan, menjual, mengalihkan, menampilkan di muka umum, membuat ulang, mentransmisikan, memindahkan, menyiarkan, menguraikan, atau membongkar bagian manapun dari atau dengan cara lain mengeksploitasi Aplikasi EIDUPAY (termasuk sistem pendukung dan layanan di dalamnya) yang dilisensikan kepada Anda, kecuali sebagaimana diperbolehkan dalam Syarat dan Ketentuan ini, (ii) memberikan lisensi, mensublisensikan, menjual, menjual kembali, memindahkan, mengalihkan, mendistribusikan atau mengeksploitasi secara komersial atau membuat tersedia kepada pihak ketiga dan/atau perangkat lunak dengan cara; (iii) menerbitkan, mendistribusikan atau memperbanyak dengan cara apapun materi yang dilindungi hak cipta, merek dagang, atau informasi yang Kami miliki lainnya tanpa memperoleh persetujuan terlebih dahulu dari Kami atau pemilik hak yang memberikan lisensi hak-nya kepada Kami, (iv) menghapus setiap hak cipta, merek dagang atau pemberitahuan hak milik lainnya yang terkandung dalam Aplikasi EIDUPAY, (v) merekayasa ulang atau mengakses Aplikasi EIDUPAY dan/atau sistem pendukungnya untuk (a) membangun produk atau layanan tandingan, (b) membangun produk dengan menggunakan ide, fitur, fungsi atau grafis sejenis, atau (c) menyalin ide, fitur , fungsi atau grafis, (vi) meluncurkan program otomatis atau script, termasuk, namun tidak terbatas pada, web crawlers, web robots, web indexers, bots, virus, worm, atau aplikasi lain sejenis dan segala program apapun yang mungkin membuat beberapa permintaan server per detik, menciptakan beban berat atau menghambat operasi dan/atau kinerja Aplikasi EIDUPAY, (vii) menggunakan robot, spider, pencarian situs/aplikasi pengambilan kembali, atau perangkat manual atau otomatis lainnya atau proses untuk mengambil, indeks, "tambang data" (data mine), atau dengan cara apapun memperbanyak atau menghindari struktur navigasi atau presentasi dari Aplikasi EIDUPAY dan isi yang terdapat di dalamnya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title(
                'XIX.', 'HUKUM YANG BERLAKU DAN PENYELESAIAN PERSELISIHAN'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('a.',
                'Syarat dan Ketentuan ini diatur dan ditafsirkan berdasarkan hukum Negara Republik Indonesia.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('b.',
                'Segala perselisihan atau pertentangan yang timbul sehubungan dengan atau terkait dengan hal-hal yang diatur dalam Syarat dan Ketentuan (maupun bagian daripadanya) termasuk perselisihan yang disebabkan karena adanya atau dilakukannya perbuatan melawan hukum atau pelanggaran atas satu atau lebih Syarat dan Ketentuan ini (“Perselisihan”) wajib diselesaikan dengan cara sebagai berikut:'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('1.',
                'salah satu pihak baik Anda atau Kami (“Pihak Pertama”) wajib menyampaikan pemberitahuan tertulis kepada pihak lainnya (“Pihak Kedua”) atas telah terjadinya Perselisihan (“Pemberitahuan Perselisihan”). Perselisihan wajib diselesaikan secara musyawarah mufakat dalam waktu paling lambat 90 (sembilan puluh) hari kalender sejak tanggal Pemberitahuan Perselisihan Perselisihan (“Periode Penyelesaian Musyawarah”);'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('2.',
                'jika Perselisihan tidak dapat diselesaikan secara musyawarah mufakat sampai dengan berakhirnya Periode Penyelesaian Musyawarah, Pihak Pertama dan Pihak Kedua wajib untuk bersama-sama menunjuk pihak ketiga (“Mediator”) sebagai mediator untuk menyelesaikan Perselisihan dan penunjukan tersebut wajib dituangkan dalam bentuk tertulis yang ditandatangani bersama oleh Pihak Pertama dan Pihak Kedua.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('3.',
                'proses mediasi oleh Mediator khusus akan diselesaikan oleh satu arbiter yang ditunjuk berdasarkan Peraturan Badan Arbitrase Nasional Indonesia yang beralamat di gedung Wahana Graha Lantai 2, Jl. Mampang Prapatan Nomor 2 Jakarta Selatan 12760, Republik Indonesia (BANI).'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('4.',
                'Ketentuan mengenai seluruh biaya, ongkos dan pengeluaran dalam rangka penyelesaian Perselisihan diputuskan berdasarkan putusan arbitrase yang final dan mengikat;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 10),
            child: desc('5.',
                'Kecuali disyaratkan berdasarkan hukum yang berlaku atau diminta berdasarkan permintaan, keputusan atau penetapan resmi yang diterbitkan, dikeluarkan atau dibuat oleh pengadilan atau instansi pemerintah yang berwenang, selama proses penyelesaian Perselisihan sebagaimana diatur di atas sampai dengan adanya keputusan yang sah, final dan mengikat Pihak Pertama dan Pihak Kedua, maka Pihak Pertama dan Pihak Kedua wajib untuk merahasiakan segala informasi terkait dengan Perselisihan maupun proses penyelesaiannya dan karenanya dilarang untuk dengan cara apapun menginformasikan, memberitahukan atau mengumumkan kepada pihak manapun adanya Perselisihan tersebut maupun proses penyelesaiannya termasuk tetapi tidak terbatas melalui media massa (koran, televisi atau media lainnya) dan/atau media sosial. Jika Anda melanggar ketentuan butir (e) ini, Anda dengan ini mengetahui dan setuju bahwa seluruh atau sebagian hak Anda untuk menggunakan Layanan, Aplikasi, Akun dan/atau PIN dapat sewaktu-waktu diakhiri atau di non-aktifkan oleh Kami baik untuk sementara waktu maupun untuk seterusnya.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('c.',
                'Sehubungan dengan kuasa yang tidak ditarik kembali yang Anda berikan kepada Kami berdasarkan Syarat dan Ketentuan ini, kuasa tersebut akan terus berlaku dan tidak dapat berakhir karena alasan apapun juga termasuk alasan-alasan yang dimaksud dan diatur dalam Pasal 1813, 1814, dan 1816 Kitab Undang-Undang Hukum Perdata, kecuali dalam hal Anda menutup akun EIDUPAY Anda.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XX.', 'PERUBAHAN'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc2(
                'Kami berhak untuk, dari waktu ke waktu, melakukan perubahan, penambahan, dan/atau modifikasi atas seluruh atau sebagian dari isi Syarat dan Ketentuan ini dan Kebijakan Privasi dengan mengumumkannya kepada Anda antara lain melalui aplikasi OVO atau situs OVO. Anda memahami dan menyetujui bahwa apabila Anda menggunakan layanan Aplikasi OVO secara terus-menerus dan berlanjut setelah perubahan, penambahan dan/atau modifikasi atas seluruh atau sebagian dari isi Syarat dan Ketentuan merupakan bentuk persetujuan Anda atas perubahan, penambahan dan/atau modifikasi tersebut. Apabila Anda tidak setuju atas perubahan, penambahan dan/atau modifikasi tersebut, Anda diminta berhenti mengakses dan/atau menggunakan Aplikasi OVO dan/atau Layanan Kami.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XXI.', 'KEADAAN MEMAKSA (Force Majeur)'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc2(
                'Tidak dilaksanakannya atau tertundanya pelaksanaan sebagian atau keseluruhan kewajiban berdasarkan Syarat dan Ketentuan oleh VJI tidak akan dianggap sebagai pelanggaran terhadap Syarat dan Ketentuan apabila hal tersebut disebabkan oleh suatu peristiwa yang berada di luar kendali VJI atau lazim disebut dengan istilah Keadaan Memaksa (Force Majeur) termasuk namun tidak terbatas pada (a) bencana alam (b) kebakaran, pemogokan buruh, perang, huru-hara, pemberontakan atau tindakan militer lainnya (c) tindakan pihak/instansi yang berwenang yang mempengaruhi kelangsungan penyediaan layanan telekomunikasi (d) tindakan pihak ketiga yang menyebabkan VJI tidak dapat memberikan layanan telekomunikasi (e) adanya keputusan dari instansi yang berwenang atau perubahan keputusan dari pemerintah yang berdampak pada pelaksanaan layanan EIDUPAY termasuk diantaranya perubahaan pemberlakuan tarif kepada Pengguna dan (f) wabah, epidemi, dan/atau pandemi penyakit. Pengguna setuju untuk melepaskan VJI dari setiap klaim, jika VJI tidak dapat memenuhi instruksi Pengguna melalui akun EIDUPAY baik sebagian maupun seluruhnya karena adanya Keadaan Memaksa.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 10),
            child: title('XXII.', 'LAIN-LAIN'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('1.',
                'Syarat dan Ketentuan ini tunduk dan diatur serta dilaksanakan sesuai dengan hukum Republik Indonesia;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('2.',
                'Apabila terjadi perselisihan dalam penafsiran atau pelaksanaan dari Syarat dan Ketentuan maka VJI dan Pengguna setuju untuk menyelesaikan perselisihan tersebut melalui jalan musyawarah. Dalam hal musyawarah mufakat tidak tercapai dalam jangka waktu 30 (tiga puluh) hari kalender, maka selanjutnya perselisihan akan diselesaikan melalui Pengadilan Negeri Jakarta Selatan;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('3.',
                'Syarat dan Ketentuan ini dibuat dalam Bahasa Indonesia dan Bahasa Inggris. Dalam hal terdapat ketidaksesuaian diantara keduanya, maka VJI dan Pengguna setuju untuk menggunakan Bahasa Indonesia sebagai bahasa yang mengikat;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('4.',
                'EIDUPAY, termasuk nama dan logo, kode, desain, teknologi dan formula bisnisnya, dilindungi oleh suatu hak cipta, merek, paten dan hak atas kekayaan intelektual lainnya serta tunduk pada hukum dan peraturan perundang-undangan yang berlaku di Republik Indonesia. VJI (dan pihak-pihak yang terkait dengan perizinan EIDUPAY, jika ada) memiliki semua hak dan kepentingan EIDUPAY terkait hak atas kekayaan intelektual yang mengikutinya. Syarat dan Ketentuan ini tidak mengakibatkan beralihnya atau memberikan hak bagi Pengguna untuk menggunakan hak atas kekayaan intelektual EIDUPAY dalam arti yang seluas-luasnya terhadap hak-hak atas kekayaan intelektual sebagaimana disebutkan di atas;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('5.',
                'Kegagalan atau tertundanya VJI dalam mengambil tindakan langsung, mengenakan sanksi, atau melaksanakan hak atau kewajiban VJI, dan/atau mengajukan gugatan atau tuntutan terhadap pelanggaran Syarat dan Ketentuan ini, tidak menghapuskan kewajiban Pengguna dan bukan merupakan suatu pengesampingan atas hak VJI untuk mengambil tindakan apapun yang diperlukan di kemudian hari.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('6.',
                'Pengguna dilarang dan/atau tidak dapat mengalihkan hak dan kewajibannya dalam Syarat dan Ketentuan ini tanpa persetujuan terlebih dahulu dari VJI berdasarkan pertimbangan dan kebijakan VJI semata. Pengalihan seluruh atau sebagian Saldo EIDUPAY yang dilakukan oleh Pengguna kepada pihak lain manapun, bukan merupakan pengalihan atau suatu bentuk pengalihan rekening atau akun EIDUPAY;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('7.',
                'Jika terdapat suatu ketentuan dalam Syarat dan Ketentuan ini yang ternyata diketahui melanggar ketentuan perundang-undangan yang berlaku baik sebagian maupun seluruhnya, maka ketentuan yang dianggap melanggar tersebut dikesampingkan dari Syarat dan Ketentuan ini dan atas syarat dan ketentuan lain tetap berlaku dan mengikat;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('8.',
                'Syarat dan Ketentuan ini baik sebagian maupun seluruhnya termasuk fitur atau layanan yang ditawarkan oleh VJI dapat diubah, diperbaharui, dan/atau ditambah dari waktu ke waktu dengan berdasarkan kepada kebijakan yang berlaku di EIDUPAY dan terhadap perubahan, pembaharuan dan/atau penambahan tersebut Pengguna EIDUPAY dengan ini menyatakan menerima perubahan, pembaharuan dan/atau penambahan tersebut;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('9.',
                'Pengguna dengan ini mengetahui dan memberikan persetujuan kepada VJI untuk menggunakan data pribadi/informasi Pengguna pada fitur-fitur yang tersedia pada aplikasi EIDUPAY (atau yang akan ada dikemudian hari) untuk pengembangan jenis/model layanan dan penggunaan aplikasi EIDUPAY, dengan tetap memperhatikan ketentuan Kebijakan Privasi serta ketentuan perundang-undangan yang berlaku.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('10.',
                'Pengelolaan data pribadi Pengguna EIDUPAY diatur dalam Kebijakan Privasi (Privacy Policy) dimana Kebijakan Privasi tersebut merupakan satu kesatuan dan bagian yang tidak terpisahkan Syarat dan Ketentuan ini dan karenanya dengan ini menyatakan bahwa Pengguna menerima dan menyetujui Kebijakan Privasi (Privacy Policy) yang terkait;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('11.',
                'Transaksi Pengguna yang dilakukan melalui EIDUPAY disimpan secara otomatis pada server EIDUPAY. Pengguna mengakui dan memahami bahwa VJI dengan upaya terbaiknya telah menjaga keamanan sistemnya. Namun demikian, dalam hal terdapat perbedaan atau ketidaksesuaian antara data, saldo atau catatan Transaksi Pengguna maka Pengguna menyetujui bahwa data, saldo atau catatan Transaksi yang berlaku dan diakui adalah yang dimiliki oleh VJI;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('12.',
                'Pengguna memahami bahwa dalam menggunakan EIDUPAY, data pribadi dari Pengguna akan dikumpulkan, digunakan maupun diperlihatkan sehingga Pengguna dapat menikmati layanan EIDUPAY secara maksimal, karenanya Pengguna dengan ini mengizinkan VJI untuk menggunakan data pribadi tersebut kepada pihak ketiga yang memiliki kerja sama dengan VJI;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('13.',
                'Pengguna dapat menghubungi Layanan Pelanggan (Customer Care) EIDUPAY di nomor 021-7994444 atau melalui WA Center di 08119007911 atau secara tertulis melalui email support@eidupay.com masuk ke dalam aplikasi dan situs web EIDUPAY untuk mengetahui informasi sehubungan dengan layanan EIDUPAY;'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: desc('14.',
                'Pengguna akan menerima pemberitahuan mengenai layanan atau promosi terbaru dari EIDUPAY melalui media komunikasi pribadi atau melalui aplikasi EIDUPAY. Bila Pengguna keberatan untuk menerima pemberitahuan tersebut maka Pengguna dapat menghubungi Layanan Pelanggan (Customer Care) EIDUPAY.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 20),
            child: title('XX.', 'KETENTUAN PENUTUP'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: desc2(
                'Pengguna mengerti dan menyetujui bahwa Syarat dan Ketentuan ini merupakan perjanjian dalam bentuk elektronik dan tindakan Pengguna menekan tombol daftar atau tombol masuk atau menandai kotak persetujuan saat akan mengakses EIDUPAY merupakan persetujuan Pengguna untuk mengikatkan diri dalam perjanjian dengan VJI sehingga keberlakuan Syarat dan Ketentuan ini adalah sah dan mengikat secara hukum dan terus berlaku sepanjang penggunaan aplikasi EIDUPAY oleh Pengguna.'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10, bottom: 40),
            child: desc2(
                'VJI dapat mengalihkan hak VJI berdasarkan Syarat dan Ketentuan ini tanpa perlu mendapatkan persetujuan terlebih dahulu dari Pengguna atau pemberitahuan sebelumnya kepada Pengguna.'),
          ),
        ],
      )
    ],
  );
}

Widget title(String simbol, String isi) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(simbol,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
      SizedBox(
        width: 10,
      ),
      Flexible(
          child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isi,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t100),
            )
          ],
        ),
      )),
    ],
  );
}

Widget desc(String simbol, String isi) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(simbol,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
      SizedBox(
        width: 10,
      ),
      Flexible(
          child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isi,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t70),
            )
          ],
        ),
      )),
    ],
  );
}

Widget desc2(String isi) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
          child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isi,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t70),
            )
          ],
        ),
      )),
    ],
  );
}
