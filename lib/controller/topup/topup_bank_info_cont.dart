import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eidupay/controller/home_cont.dart';
import 'package:eidupay/extension.dart';
import 'package:get/get.dart';

class TopupBankInfoCont extends GetxController {
  final _homeController = Get.find<HomeCont>();

  void copyData(String va) {
    Clipboard.setData(ClipboardData(text: va));
    Get.snackbar(
      'Eidupay',
      'Data has been copied to the clipboard',
      icon: const Icon(Icons.person, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String maxBalance() {
    if (_homeController.idVerifyStatus.value == '1') {
      return 'Rp. ${10000000.amountFormat}';
    } else {
      return 'Rp. ${2000000.amountFormat}';
    }
  }

  String maxTopUp() {
    if (_homeController.idVerifyStatus.value == '1') {
      final max =
          10000000 - int.parse(_homeController.balance.value.numericOnly());
      return max.amountFormat;
    } else {
      final max =
          2000000 - int.parse(_homeController.balance.value.numericOnly());
      return max.amountFormat;
    }
  }

  String checkVirtualAccNo(Map<String, dynamic> dataBank) => (dataBank[
              'name'] ==
          'BRI Link')
      ? dataBank['vabri']
      : (dataBank['name'] == 'agen 46')
          ? dataBank['vabni']
          : dataBank[
                  'va${dataBank['name'].toString().toLowerCase().removeAllWhitespace.substring(4)}'] ??
              '--';

  List<String> getAtmInstruction(String bankName) {
    if (bankName.toLowerCase().removeAllWhitespace.contains('brilink')) {
      return [
        'Datang ke Agen BRILink terdekat',
        'Pilih menu Mini ATM, lalu pilih menu Pembayaran',
        'Setelah itu pilih menu BRIVA',
        'Swipe(gesek) kartu ATM anda ke EDC BRI',
        'Masukkan nomor rekening Virtual Account \n(contoh: 8000812877XXXXX)',
        'Lalu masukkan PIN kartu ATM Anda',
        'Ketika muncul konfirmasi pembayaran, silahkan periksa dan pilih Lanjut jika sudah benar',
        'Transaksi selesai dan silahkan ambil bukti pembayaran anda',
      ];
    } else if (bankName.toLowerCase().contains('agen')) {
      return [
        'Kunjungi Agen46 terdekat (warung/toko/kios dengan tulisan Agen46)',
        'Informasikan kepada Agen46, bahwa ingin melakukan pembayaran “Virtual Account',
        'Serahkan nomor Virtual Account Anda kepada Agen46',
        'Agen46 melakukan konfirmasi kepada Anda',
        'Agen46 Proses Transaksi',
        'Apabila transaksi Sukses anda akan menerima bukti pembayaran dari Agen46 tersebut'
      ];
    } else if (bankName.toLowerCase().contains('bri')) {
      return [
        'Masukkan kartu ATM & PIN Anda',
        'Pilih menu Transaksi lain > Pembayaran > Lainnya > BRIVA',
        'Masukkan nomor virtual account (BRIVA) anda di atas atau dengan format: \n• 12444 + No handphone member, contoh: \n 1233308122298xxxx',
        'Muncul konfirmasi dan pastikan data sesuai kemudian klik YA',
        'Masukkan nominal top up, dan klik benar',
        'Muncul konfirmasi data customer & nominal top up. Cek & pastikan kembali data sudah sesuai. Kemudian klik Ya',
        'Transaksi berhasil, simpan struk bukti pembayaran'
      ];
    } else if (bankName.toLowerCase().contains('bni')) {
      return [
        'Masukkan kartu ATM & PIN bank BNI',
        'Pilih menu Lain > Transfer > Pilih Rekening Asal',
        'Pilih tujuan transfer > Ke Rekening BNI/BNI Syariah',
        'Masukkan nomor virtual acount anda di atas atau dengan format berikut, kemudian tekan Benar \n• 8096 + No handphone Member, \ncontoh: 809608122298xxxx',
        'Masukkan jumlah nominal Top-up Anda, dan pilih Benar',
        'Muncul konfirmasi pembayaran, pastikan data (Nama dan Nominal) sesuai. Kemudian tekan Benar',
        'Transaksi Berhasil'
      ];
    } else if (bankName.toLowerCase().contains('mandiri')) {
      return [
        'Masukkan kartu ATM & PIN bank Mandiri',
        'Pilih menu Bayar/Beli > Lainnya > Multipayment',
        'Masukkan kode perusahaan/kode institusi "Plink Pay" 89039, tekan Benar. Atau klik DAFTAR KODE',
        'Masukkan nomor virtual account anda di atas atau dengan format berikut, kemudian tekan Benar \n• ID Account, contoh: 89039036 + 8 Angka yang diberikan',
        'Masukkan nominal isi saldo, kemudian tekan Benar',
        'Muncul konfirmasi data customer, pilih nomor 1 sesuai jumlah yang akan dibayarkan. Kemudian tekan YA',
        'Muncul konfirmasi pembayaran, tekan YA untuk bayar',
        'Simpan struk sebagai bukti pembayaran',
      ];
    } else if (bankName.toLowerCase().contains('bca')) {
      return [
        'Masukkan kartu ATM & PIN bank BCA',
        'Pilih menu TRANSAKSI LAINNYA > TRANSFER > BCA VIRTUAL ACCOUNT',
        'Masukkan nomor virtual account anda di atas atau dengan format berikut, kemudian tekan Benar \n• 11844 + No handphone member \n• Contoh: 1184408122298xxxx',
        'Masukkan nominal isi saldo, kemudian tekan Benar',
        'Muncul konfirmasi pembayaran, tekan YA untuk bayar',
        'Simpan struk sebagai butki pembayaran',
      ];
    } else if (bankName.toLowerCase().contains('muamalat')) {
      return [
        'Masukkan kartu ATM, lalu input PIN Anda',
        'Pilih menu TRANSAKSI LAIN',
        'Pilih menu PEMBAYARAN kemudian pilih menu VIRTUAL ACCOUNT',
        'Masukkan Nomor Virtual ACCount 8274 01 xxxxxxxxxx',
        'Tekan BAYAR jika setuju dengan informasi pembayaran',
        'Periksa kembali jumlah tagihan',
        'Apabisa sudah sesuai, tekan BENAR, lalu tekan BAYAR',
        'Simpan struk ATM sebagai bukti pembayaran',
      ];
    } else if (bankName.toLowerCase().contains('bsi')) {
      return [
        'Masukkan kartu ATM & PIN bank BSI',
        'Pilih menu PAYMENT/PEMBAYARAN/PEMBELIAN',
        'Pilih INSTITUSI',
        'Masukkan kode atau nama institusi (9310 - PT Visi Jaya Indonesia) dan Masukkan NOMOR PONSEL yang terdaftar di eidupay \n• contoh: 9312081xxxx \n• Jika nomor ponsel 11 digit tambahakan 0 menjadi 931200 + nomor ponsel \n• Jika nomor ponsel 10 digit, tambahkan 00 menjadi 931200 + nomor ponsel',
        'Masukkan nominal lalu tekan tombol BENAR/SELANJUTNYA',
        'Layar VALIDASI transaksi akan muncul, pastikan data sudah benar. Lalu klik BENAR/YA',
        'Transaksi Berhasil',
      ];
    } else {
      return [];
    }
  }

  List<String> getMobileBankingInstruction(String bankName) {
    if (bankName.toLowerCase().removeAllWhitespace.contains('brilink')) {
      return [];
    } else if (bankName.toLowerCase().contains('bri')) {
      return [
        'Login ke mobile banking BRI',
        'Pilih menu Pembayaran kemudian pilih BRIVA',
        'Masukkan nomor virtual account (BRIVA) anda di atas atau dengan format: \n• 12444 + No handphone member, contoh: \n1244408122298xxxx',
        'Masukkan PIN m-Banking BRI anda, klik Send (kirim)',
        'Muncul notifikasi untuk pengiriman SMS, klik OK',
        'Notifikasi transaksi sukses dikirimkan melalui SMS'
      ];
    } else if (bankName.toLowerCase().contains('bni')) {
      return [
        'Login ke mobile banking atau internet banking BNI',
        'Pilih menu Transfer',
        'Pilih Virtual Account Billing',
        'Masukkan nomor virtual account anda di atas atau dengan format berikut, kemudian tekan Benar \n• 8096 + No handphone member, \ncontoh: 809608122298xxxx',
        'Masukkan jumlah nominal TopUp Anda',
        'Muncul layar konfirmasi. Pastikan data sesuai. Lalu masukkan PIN Transaksi mBanking atau iBanking anda',
        'Transaksi Berhasil'
      ];
    } else if (bankName.toLowerCase().contains('mandiri')) {
      return [
        'Login ke mobile banking atau internet banking Mandiri',
        'Pilih menu Bayar/Beli > Lainnya > Multipayment',
        'Masukkan kode perusahaan / kode institusi "Plink Pay" 89039, tekan Benar. Atau klik DAFTAR KODE',
        'Masukkan nomor virtual account anda di atas atau dengan format berikut, kemudian tekan Benar \n• ID Account, contoh: 89039036 + 8 Angka yang diberikan',
        'Masukkan nominal isi saldo, kemudian tekan Benar',
        'Muncul konfirmasi data customer, pilih nomor 1 sesuai jumlah yang akan dibayarkan. Kemudian tekan YA',
        'Muncul konfirmasi pembayaran, tekan YA untuk bayar',
        'Simpan notifikasi sukses sebagai bukti pembayaran'
      ];
    } else if (bankName.toLowerCase().contains('bca')) {
      return [
        'Login ke mobile banking BCA',
        'Pilih menu M-TRANSFER > BCA VIRTUAL ACCOUNT',
        'Masukkan nomor virtual account anda di atas atau dengan format berikut, kemudian tekan Benar \n• 11844 + No handphone Member \n• Contoh: 1184408122298xxxx',
        'Masukkan nominal isi saldo, kemudian tekan Benar',
        'Masukkan PIN anda',
        'Simpan notifikasi sukses sebagai bukti pembayaran'
      ];
    } else if (bankName.toLowerCase().contains('muamalat')) {
      return [
        'Login ke mobile banking Muamalat',
        'Pilih menu PEMBAYARAN',
        'Masukkan nomor Virtual Account 8274 01 XXXXXXXXXX, klik PROSES',
        'Periksa kembali jumlah pembayaran',
        'Apabila sudah sesuai, masukkan kode verifikasi lalu klik PROSES jika setuju dengan informasi pembayaran',
        'Transaksi anda selesai. Simpan struk sebagai bukti transaksi'
      ];
    } else if (bankName.toLowerCase().contains('bsi')) {
      return [
        'Pilih menu PAYMENT/PEMBAYARAN',
        'Pilih INSTITUSI',
        'Masukkan kode 9312 - PT Visi Jaya Indonesia dan NOMOR PONSEL yang terdaftar di Eidupay \n• Terdaftar di Eidupay, contoh: 9312081xxxx \n• Jika nomor ponsel 11 digit tambahkan 0 menjadi 93120 + nomor ponsel \n• Jika nomor ponsel 10 digit, tambahkan 00 menjadi 931200 + nomor ponsel',
        'Lalu klik SETUJU',
        'Masukkan NOMINAL, lalu klik SELANJUTNYA',
        'Layar VALIDASI transaksi akan muncul, pastikan data sudah benar. Lalu klik SELANJUTNYA',
        'Masukkan PIN dan tekan tombol SELANJUTNYA untuk memproses transaksi'
      ];
    } else {
      return [];
    }
  }
}
