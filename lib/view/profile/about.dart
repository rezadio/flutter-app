import 'package:eidupay/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static final route =
      GetPage(name: '/aboutEidupay', page: () => const AboutPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Kebijakan Privasi')),
        body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hi, terima kasih telah menggunakan EIDUPAY!',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400, color: t100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 20),
                    child: desc2(
                        'PT Visi Jaya Indonesia (“VJI” atau “EIDUPAY” atau “Kami”) ingin memberikan pengalaman sebaik mungkin bagi Anda dalam menikmati setiap layanan jasa keuangan yang kami berikan baik untuk saat ini maupun di masa mendatang. Keamanan Data Pribadi dan Privasi Anda akan selalu menjadi hal yang sangat penting bagi Kami. Oleh karena itu kami menyusun dan menguraikan secara transparan bagaimana cara kami mengumpulkan, menganalisis, menyimpan, menggunakan, menghapus dan memusnahkan Data Pribadi anda sebagaimana di jelaskan dibawah ini.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: desc2(
                        'Kami harap Anda membaca Kebijakan Privasi ini dengan seksama untuk memastikan bahwa sebagai pengguna, Anda memahami dan menyetujui bagaimana proses pengolahan data Kami. Dengan menggunakan Aplikasi EIDUPAY berarti Anda mengakui bahwa Anda telah membaca, memahami dan menyetujui seluruh ketentuan yang terdapat dalam Kebijakan Privasi ini, yang adalah satu kesatuan yang tak terpisahkan dengan Syarat dan Ketentuan EIDUPAY.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: desc2(
                        'Kecuali didefinisikan lain dalam Kebijakan Privasi ini, istilah yang ditulis dengan huruf kapital memiliki arti yang sama dengan yang diberikan dalam Syarat dan Ketentuan.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('I.', 'UMUM'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Kebijakan Privasi ini berlaku untuk layanan-layanan yang disediakan oleh PT Visi Jaya Indonesia (“VJI”) (atau dikenal sebagai “EIDUPAY”, “kami”, “kepunyaan kami”) dan menjelaskan bagaimana kami mengumpulkan, menggunakan, menyimpan, mentransfer, melindungi dan mengungkapkan “Data Pribadi” Pengguna, sehubungan dengan akses pengguna ke dan penggunaan layanan atau produk EIDUPAY, kecuali diatur pada kebijakan privasi yang terpisah.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Anda menyatakan bahwa Data Pribadi Anda merupakan data yang benar dan sah, serta Anda memberikan persetujuan kepada Kami untuk memperoleh, mengumpulkan, mengolah,menganalisis, menyimpan, menampilkan, mengumumkan, mengirimkan, menyebarluaskan, menghapus dan memusnahkan sesuai dengan Kebijakan Privasi ini dan peraturan perundang-undangan yang berlaku. '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Siapa pun dapat mendaftar untuk memiliki akun pada Aplikasi EIDUPAY (“Akun EIDUPAY”) dengan PT VJI yang merupakan lembaga bukan bank yang telah memperoleh izin sebagai penerbit uang elektronik (stored value facility), dan penyelenggara transfer dana, yang berada di bawah pengawasan Bank Indonesia selaku otoritas yang berwenang mengawasi penyelenggaraan sistem pembayaran.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child:
                        title('II.', 'PEROLEHAN DAN PENGUMPULAN DATA PRIBADI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: title('A.', 'DATA PRIBADI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc2(
                        '“Data Pribadi” adalah setiap data, informasi, dan/atau keterangan dalam bentuk apapun yang dapat mengidentifikasikan diri Anda, yang dari waktu ke waktu Anda sampaikan kepada Kami atau yang Anda cantumkan atau sampaikan dalam, pada, dan/atau melalui Aplikasi yang menyangkut informasi mengenai pribadi Anda, termasuk namun tidak terbatas pada nama lengkap, alamat, tempat tanggal lahir, jenis kelamin, e-mail, nomor identitas yang diterbitkan oleh instansi atau otoritas yang berwenang (termasuk KTP, SIM, dan Paspor) atau tanda pengenal lainnya yang dikeluarkan oleh pemerintah, foto, kewarganegaraan, nomor telepon pengguna dan non-pengguna EIDUPAY yang terdapat dalam daftar kontak telepon seluler Pengguna EIDUPAY, rekening bank, (termasuk namun tidak terbatas pada:IP address, informasi lokasi, data perangkat Anda, nomor IMEI, nama aplikasi yang telah dilekatkan pada perangkat Anda), data yang menyangkut informasi mengenai kegiatan transaksi Anda pada Aplikasi EIDUAPY, dan serta informasi biometrik (termasuk namun tidak terbatas pengenalan wajah), serta informasi lain yang secara langsung maupun tidak langsung, baik secara terpisah atau bersama-sama dengan informasi lain, dapat digunakan untuk mengidentifikasi Pengguna.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: title('B.', 'KEAKURATAN DATA PRIBADI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc2(
                        'Kami membutuhkan Data Pribadi Anda, salah satunya adalah untuk dapat melakukan pemrosesan transaksi. Oleh karena itu, Data Pribadi yang Anda berikan kepada Kami haruslah seakurat mungkin dan tidak menyesatkan. Anda harus memperbaharui dan memberitahukan kepada Kami apabila ada perubahan terhadap Data Pribadi Anda. Anda dengan ini membebaskan Kami dari setiap tuntutan, gugatan, ganti rugi, dan/atau klaim sehubungan dengan kegagalan pemrosesan transaksi pada Aplikasi EIDUPAY yang disebabkan oleh ketidakakuratan Data Pribadi yang Anda berikan kepada Kami.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc2(
                        'Apabila Anda belum berusia 18 tahun, belum menikah atau berada di bawah pengampuan maka Anda memerlukan persetujuan dari orang tua, wali atau pengampu Anda yang sah untuk memberikan Data Pribadi kepada Kami. Jika Data Pribadi Anda tersebut diberikan kepada Kami, Anda dengan ini menyatakan dan menjamin bahwa orang tua, wali yang sah atau pengampu Anda telah menyetujui pemrosesan Data Pribadi anda tersebut dan secara pribadi menerima dan setuju untuk terikat oleh Kebijakan Privasi ini dan bertanggung jawab atas tindakan Anda. '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc2(
                        'Dalam keadaan tertentu, Anda mungkin memberikan Data Pribadi yang berkaitan dengan orang lain (seperti pasangan, anggota keluarga, dan/atau teman Anda). Dalam keadaan tersebut, Anda menyatakan dan menjamin bahwa Anda telah memiliki wewenang dan persetujuan dari pemilik Data Pribadi tersebut untuk memberikan Data Pribadi mereka kepada Kami untuk digunakan sesuai dengan tujuan-tujuan yang diuraikan dalam Kebijakan Privasi ini.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: title('C.', 'PENGUMPULAN DATA PRIBADI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('1.',
                        'Penyediaan Data Pribadi Anda bersifat sukarela. Namun, jika Anda tidak memberikan Data Pribadi Anda kepada Kami, Kami tidak akan dapat memproses Data Pribadi Anda untuk tujuan yang diuraikan di bawah ini, dan dapat menyebabkan Kami tidak dapat memberikan layanan-layanan atau produk-produk kepada, atau memproses pembayaran-pembayaran dari Anda.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('2.',
                        'EIDUPAY dapat memperoleh Data Pribadi Pengguna dari berbagai sumber (misalnya dari Pengguna atau melalui pihak ketiga) pada setiap saat, termasuk namun tidak terbatas, pada saat Pengguna mengakses Aplikasi EIDUPAY atau melakukan transaksi menggunakan Aplikasi EIDUPAY, di antaranya data sehubungan dengan:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 10),
                    child: desc('a.',
                        'Informasi yang didapatkan (secara langsung atau tidak langsung) pada saat Pengguna mengakses Aplikasi EIDUPAY, sehubungan dengan informasi tentang komputer, perangkat telepon, bagian dari perangkat keras lain, perangkat lunak, serta jaringan telekomunikasi yang digunakan oleh Pengguna untuk mengakses dan menggunakan Aplikasi EIDUPAY (termasuk alamat IP Pengguna, lokasi geografis, tipe dan versi browser/platform, penyedia layanan internet, sistem operasi, sumber rujukan/laman keluar, lama kunjungan/penggunaan, tampilan halaman dan istilah pencarian apapun yang Pengguna gunakan) (“Informasi Perangkat”).'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 10),
                    child: desc('b.',
                        'Informasi yang didapatkan (secara langsung atau tidak langsung) ketika Pengguna mendaftar dengan rekening EIDUPAY untuk membuat Akun EIDUPAY termasuk nama, tanggal lahir, alamat, nomor telepon, alamat surel Pengguna, foto, dan kartu identitas (termasuk KTP, SIM, dan Paspor) (“Informasi Pendaftaran”).'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 10),
                    child: desc('c.',
                        'Informasi yang didapatkan (secara langsung atau tidak langsung) selama Pengguna menggunakan Aplikasi EIDUPAY, termasuk nomor rekening bank Pengguna, informasi tagihan dan pengiriman, data transaksi, dan informasi lainnya (“Infomasi Rekening”).'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 10),
                    child: desc('d.',
                        'Informasi yang didapatkan pada saat Pengguna melakukan pengkinian informasi atau pada saat lainnya sebagaimana dapat diminta oleh EIDUPAY kepada Pengguna apabila dibutuhkan dari waktu ke waktu.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75, top: 10),
                    child: desc('e.',
                        'Kami telah mengambil langkah-langkah untuk memastikan bahwa kami tidak mengumpulkan informasi (tanpa melihat apakah informasi tersebut merupakan Data Pribadi atau tidak) dari Pengguna lebih dari apa yang kami perlukan untuk menyediakan layanan kami kepada Pengguna, untuk melakukan fungsi-fungsi sebagaimana diatur dalam Bagian 3 dari Kebijakan Privasi ini, untuk melindungi Akun EIDUPAY Pengguna, mematuhi kewajiban hukum kami, melindungi hak-hak kami berdasarkan hukum, dan untuk mengoperasikan kegiatan usaha kami.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('III.', 'PENGGUNAAN DATA PRIBADI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Kami dapat mengolah, menganalisis, dan/atau menggunakan Data Pribadi yang kami dapatkan tentang Pengguna untuk tujuan sebagai berikut maupun tujuan lain yang diizinkan oleh peraturan perundang-undangan yang berlaku, di antaranya:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('1.',
                        'Melakukan verifikasi kelayakan dan/atau kesesuaian data pengguna untuk menggunakan fitur-fitur dan fungsi-fungsi dalam Aplikasi EIDUPAY, termasuk namun tidak terbatas pada proses mengenal pelanggan (Know Your Customer);'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('2.',
                        'Memproses pendaftaran, memelihara dan mengelola Akun EIDUPAY pengguna;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('3.',
                        'Memproses dan mengelola saldo EIDUPAY pengguna;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('4.',
                        'Menyediakan layanan yang pengguna minta atau memproses transaksi yang pengguna minta dan layanan pelanggan berkaitan dengan penggunaan akun EIDUPAY termasuk berkolaborasi dengan DANA untuk memfasilitasi pembayaran atas pembelian barang dan jasa, pengiriman dan layanan terkait lainnya untuk pembelian, pengenaan pembayaran kembali (charge-back), mengirimkan pemberitahuan tentang transaksi-transaksi dan tagihan-tagihan Pengguna dan menjawab pertanyaan, masukan, keluhan, tuntutan atau perselisihan dari Pengguna;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('5.',
                        'Mengelola risiko, melakukan pengecekan atas kelayakan kredit dan kemampuan membayar (solvensi), atau menilai, mendeteksi, menyelidiki, mencegah dan/atau menangani penipuan atau kegiatan-kegiatan yang berpotensi yang dilarang atau illegal dan sebaliknya melindungi integritas platform teknologi informasi kami;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('6.',
                        'Mendeteksi, menyelidiki, mencegah terjadinya tindakan yang merupakan kejahatan, illegal, dilarang, tidak sah atau curang, yang mungkin terjadi dalam penggunaan aplikasi EIDUPAY (termasuk namun tidak terbatas pada penipuan (fraud), penggelapan, pencurian dan pencucian uang) atau kegiatan-kegiatan yang berpotensi melanggar atau yang melanggar peraturan perundang-undangan atau untuk menghadapi setiap gugatan atau potensi gugatan yang diajukan terhadap kami atau afiliasi kami;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('7.',
                        'Meningkatkan, mengembangkan, menambah dan menyediakan produk dan layanan baru yang mungkin akan kami tawarkan dari waktu ke waktu guna memenuhi kebutuhan pengguna;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('8.',
                        'Meningkatkan, mengembangkan, menambah dan menyediakan produk dan layanan baru yang mungkin akan kami tawarkan dari waktu ke waktu guna memenuhi kebutuhan pengguna;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('9.',
                        'Melakukan analisis tren, penggunaan dan perilaku-perilaku lainnya (baik secara individual atau secara keseluruhan) yang membantu kami untuk lebih memahami bagaimana Pengguna dan kumpulan pengguna kami mengakses serta menggunakan Aplikasi EIDUPAY dan kegiatan komersial yang dilakukan melalui Aplikasi EIDUPAY, termasuk untuk tujuan peningkatkan layanan dan tanggapan terhadap pertanyaan serta preferensi pelanggan;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('10.',
                        'Melakukan suatu pengungkapan untuk mencegah terjadinya suatu bahaya atau kerugian finansial, untuk melaporkan setiap dugaan kegiatan illegal atau untuk menghadapi setiap gugatan atau potensi gugatan yang diajukan terhadap kami atau afiliasi kami;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('11.',
                        'Memantau dan menganalisis aktivitas, perilaku, dan data demografis Pengguna EIDUPAY termasuk kebiasaan dan penggunaan berbagai layanan yang tersedia di Aplikasi EIDUPAY;.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('12.',
                        'Pengiriman informasi yang Kami anggap berguna untuk Anda termasuk informasi tentang layanan dari Kami setelah Anda memberikan persetujuan kepada Kami bahwa Anda tidak keberatan dihubungi mengenai layanan Kami;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('13.',
                        'Tujuan administratif internal, seperti; audit, analisis data, rekaman-rekaman dalam database;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('14.',
                        'Tujuan administratif internal, seperti; audit, analisis data, rekaman-rekaman dalam database;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('15.',
                        'Memfasilitasi transaksi aset bisnis (yang dapat berupa penggabungan, akuisisi, spinoff/pemisahan atau penjualan asset) yang melibatkan EIDUPAY dan/atau afiliasi EIDUPAY;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('16.',
                        'Berkomunikasi dengan Anda sehubungan dengan segala hal mengenai Aplikasi EIDUPAY, layanan-layanan Kami, dan/atau fitur-fitur daripadanya; dan'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('17.',
                        'Untuk tujuan bisnis yang sah seperti melindungi pengguna dari kerugian, melindungi nyawa, menjaga keselamatan, keamanan produk dan sistem dan melindungi hak dan/atau properti kami lainnya.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('IV.', 'PENGUNGKAPAN DATA PRIBADI'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('1.',
                        'Data Pribadi pengguna yang kami simpan akan di jaga kerahasiaannya, namun kami dapat memberikan Data Pribadi pengguna kepada pihak-pihak untuk tujuan-tujuan sebagai mana diatur dalam ketentuan Bagian 3 di atas, termasuk namun tidak terbatas pada:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('a.',
                        'Perusahaan anggota group EIDUPAY dan perusahaan yang memiliki afiliasi dengan group EIDUPAY untuk atau berhubungan dengan tujuan terkait dengan penyediaan Aplikasi EIDUPAY, pengelolaan bisnis dan kegiatan lainnya; dan '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('b.',
                        'Otoritas atau institusi pemerintahan jika (i) disyaratkan atau diperintahkan oleh peraturan perundang-undangan yang berlaku (termasuk namun tidak terbatas pada menanggapi pertanyaan terkait regulasi, penyelidikan atau pedoman, atau mematuhi persyaratan atau ketentuan pengarsipan dan pelaporan berdasarkan peraturan perundang-undangan yang berlaku) dan/atau (ii) terdapat proses hukum yang terkait dengan Kami;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('c.',
                        'Pihak ketiga apabila terdapat transaksi perusahaan, seperti: pembentukan perusahaan patungan, penjualan anak perusahaan atau divisi, penggabungan, konsolidasi, pengambilalihan, penjualan aset, ataupun likuidasi;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('d.',
                        'pihak ketiga lainnya (termasuk agen, vendor, pemasok, kontraktor, mitra dan pihak lain yang memberikan layanan kepada kami atau pengguna, melakukan tugas atas nama Kami atau Pihak dengan siapa Kami mengadakan kerja sama komersial) untuk atau sehubungan dengan tujuan dimana pihak ketiga tersebut terlibat atau tujuan kerja sama Kami;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('2.',
                        'EIDUPAY juga dapat mengungkapkan dan membagikan Data Pribadi Pengguna dengan pihak-pihak yang disebutkan di atas untuk tujuan sebagai berikut ini:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('a.',
                        'Untuk meningkatkan kualitas layanan yang diberikan EIDUPAY kepada Pengguna dari waktu ke waktu.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('b.',
                        'Jika disyaratkan atau diperbolehkan oleh peraturan perundang-undangan yang berlaku atau atas perintah dan/atau permintaan resmi dari otoritas, lembaga, institusi negara, dan/atau aparat penegak hukum.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('c.',
                        'Untuk keperluan proses hukum dalam bentuk apapun antara Pengguna dengan EIDUPAY.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('d.',
                        'Untuk tujuan audit, baik rutin maupun insidentil, sebagaimana diperlukan dari waktu ke waktu;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('e.',
                        'Untuk keperluan pemrosesan izin, pendaftaran, ataupun pencatatan yang diperlukan untuk kegiatan usaha EIDUPAY;'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: desc('f.',
                        'Untuk segala proses verifikasi yang diperlukan sebelum mendaftarkan Pengguna sebagai Pengguna, termasuk proses Mengenal Pelanggan (Know Your Customer).'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('3.',
                        'EIDUPAY tidak akan menjual atau menyewakan Data Pribadi Pengguna kepada pihak lain.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('V.', 'LAYANAN PIHAK KETIGA DAN SITUS WEB'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Aplikasi EIDUPAY mungkin menyediakan tautan ke situs web dan layanan lain (termasuk aplikasi yang dioperasikan oleh pihak ketiga) untuk kemudahan dan informasi Pengguna. Layanan dan situs web ini dapat beroperasi secara independen dari kami dan mungkin memiliki pemberitahuan atau kebijakan privasinya sendiri, kami sarankan Pengguna untuk membaca terlebih dahulu sebelum menggunakan layanan mereka atau melakukan kegiatan apa pun di situs web tersebut. Penyediaan tautan ke situs web dan layanan lain sifatnya hanya merupakan informasi saja. Kami tidak memberikan dukungan atau jaminan apapun terhadap konten dan informasi yang dimuat dalam tautan tersebut. Terhadap situs web yang Pengguna kunjungi yang tidak dimiliki atau dikendalikan oleh kami, kami tidak bertanggung jawab atas isi, praktik privasi, dan kualitas layanan tersebut.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('VI.', 'PENYIMPANAN DAN KEMANAN DATA'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('1.',
                        'Kami memastikan bahwa Data Pribadi pengguna yang dikumpulkan dan/atau terkumpul oleh Kami akan disimpan dengan aman sesuai dengan peraturan perundang-undangan yang berlaku di Indonesia. '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('2.',
                        'Kami akan menyimpan Data Pribadi Pengguna selama diperlukan untuk memenuhi tujuan dari pengumpulann yang dijelaskan dalam Kebijakan Privasi ini atau selama penyimpanan tersebut diwajibkan atau diperbolehkan oleh peraturan perundang-undangan yang berlaku.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('3.',
                        'Kami mengambil semua langkah yang wajar dan semaksimal mungkin termasuk memberikan  perlindungan teknis, administrasi dan fisik untuk membantu melindungi Data Pribadi Pengguna yang kami proses dari suatu resiko kehilangan, penyalahgunaan dan akses tanpa izin, pengungkapan, perubahan dan penghancuran yang tidak diinginkan.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('VII.', 'AKSES TIDAK SAH'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Kami berkomitmen untuk melindungi Data Pribadi anda sebagai Pengguna kami dimana kami berusaha mengimplementasikan langkah teknis sebaik mungkin, sesuai dengan standar industri atau peraturan perundang-undangan, untuk melindungi keamanan Data Pribadi anda. Namun, sebagai Pengguna, anda harus memahami bahwa tidak ada sistem yang sepenuhnya aman. Oleh karena itu, sebagai Pengguna, anda wajib menerapkan langkah-langkah untuk melindungi Akun EIDUPAY Pengguna dengan menjaga penguasaaan Nomor Ponsel dan Perangkat yang digunakan untuk mengakses Aplikasi DANA, serta menggunakan serta merahasiakan kata sandi dan/atau kode PIN yang kuat dan unik untuk mencegah akses yang tidak diinginkan.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child:
                        title('VIII.', 'PERUBAHAN TERHADAP KEBIJAKAN PRIVASI '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Kami memegang hak eksklusif untuk mengubah, menambah, memperbaharui dan/atau merevisi Sebagian atau seluruh ketentuan dalam Kebijakan Privasi ini, dari waktu ke waktu sesuai dengan bisnis kami kedepan dan/atau perubahan peraturan perundang-undangan.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Kami akan memberi tahu pengguna untu meminta memberikan persetujuan terhadap Kebijakan Privasi yang telah diubah/ditambah/diperbaharui/direvisi.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Apabila Pengguna tidak memberikan persetujuan terhadap Kebijakan Privasi yang telah diubah, ditambah, dan/atau direvisi tersebut, maka EIDUPAY memiliki kewenangan penuh untuk menghentikan penyediaan layanan-layanan dalam Aplikasi EIDUPAY kepada Pengguna. Pengguna setuju bahwa pengguna bertanggung jawab untuk meninjau Kebijakan Privasi ini secara berkala untuk mendapatkan informasi terbaru mengenai pengolahan data dan praktik perlindungan data.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title(
                        'IX.', 'PERMINTAAN AKSES DAN PERUBAHAN DATA PRIBADI '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Apabila Pengguna hendak mengajukan pertanyaan atau menyampaikan keluhan, meminta akses dan/atau meminta perubahan data pribadi, silahkan menghubungi Layanan Pelanggan (Customer Service) EIDUPAY dibawah ini (dengan menyertakan dokumen pendung):'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2('PT Visi Jaya Indonesia (EIDUPAY)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2('Gd Balimuda Center'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Jalan Mampang Prapatan XIV No. 99, Jakarta Selatan 12790'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Jam Kerja	: Senin – Jumat, pukul 08.30 – 17.00 WIB'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2('Telepon		: 021-7994444 '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2('Email		: support@eidupay.com'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2('WaCenter	: 08119007911 '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('X.', 'PERNYATAAN'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Pengguna berhak untuk meminta Kami untuk berhenti menggunakan Data Pribadi pengguna untuk tujuan sebagaimana disebutkan di atas. Apabila Anda bermaksud untuk meminta Kami menghentikan penggunaan Data Pribadi, pengguna dapat menghubungi Layanan Pelanggan EIDUPAY (dengan menyertakan bukti pendukung) atau memilih opsi “unsubscribe” yang terdapat di dalam pesan yang Kami kirim agar Anda tidak lagi menerima pesan-pesan semacam itu di masa mendatang.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc2(
                        'Dalam hal pencabutan persetujuan tersebut dapat mengakibatkan penghentian setiap layanan Akun pemgguna atau perjanjian Kami dengan pengguna, dengan ketentuan semua hak dan kewajiban yang muncul setelahnya harus dipenuhi. Setelah pengguna menyampaikan maksud untuk mencabut persetujuan, Kami akan memberitahukan tentang akibat yang mungkin terjadi, sehingga pengguna dapat memutuskan apakah tetap ingin mencabut persetujuan Anda atau tidak.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('XI.', 'HUKUM YANG BERLAKU'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('1.',
                        'Kebijakan Privasi ini tunduk, diatur dan dilaksanakan sesuai dengan hukum Negara Republik Indonesia.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('2.',
                        'Jika terjadi perselisihan dalam hal interpretasi dan implementasi Peraturan Data Pribadi ini, Pengguna dan PT VJI setuju untuk menyelesaikannya dengan musyawarah. Jika dalam jangka waktu 30 (tiga puluh) hari kalender Pengguna dan PT VJI tidak dapat mencapai suatu kesepakatan melalui musyawarah tersebut, maka perselisihan tersebut akan diselesaikan dengan merujuk pada Pengadilan Negeri Jakarta Selatan.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: title('XII.', 'KETENTUAN LAIN'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('1.',
                        'Peraturan Data Pribadi ini dibuat dalam Bahasa Indonesia dan Bahasa Inggris. Dalam hal terjadi inkonsistensi dan/atau pertentangan antara versi bahasa Inggris dan versi bahasa Indonesia, maka versi Bahasa Indonesia yang akan berlaku dan versi Bahasa Inggris akan dianggap menyesuaikan dengan versi Bahasa Indonesia.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: desc('2.',
                        'Kami akan menerapkan sistem pengamanan informasi yang kami anggap memadai dan sesuai dengan standar industri atau peraturan perundang-undangan. Namun, transmisi informasi melalui saluran komunikasi tidak sepenuhnya aman dan bebas dari celah. Dengan demikian, setiap transmisi informasi oleh Pengguna kepada kami memiliki risiko keamanan, dalam hal mana risiko tersebut ditanggung oleh Pengguna. Kami tidak menjamin keamanan database kami dan kami juga tidak menjamin bahwa data yang Pengguna berikan sepenuhnya tidak akan tertahan/terganggu saat sedang dikirim kepada kami.'),
                  ),
                  const SizedBox(height: 40)
                ],
              ),
            )));
  }
}

Widget title(String simbol, String isi) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(simbol,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
      const SizedBox(width: 10),
      Flexible(
          child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isi,
              style: const TextStyle(
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
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: t100)),
      const SizedBox(width: 10),
      Flexible(
          child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isi,
              style: const TextStyle(
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
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: t70),
            )
          ],
        ),
      )),
    ],
  );
}
