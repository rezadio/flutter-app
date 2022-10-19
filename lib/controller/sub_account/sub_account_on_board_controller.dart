import 'package:eidupay/tools.dart';
import 'package:eidupay/view/sub_account/sub_account_list_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubAccountOnBoardController extends GetxController {
  final textContent = <String>[
    'Extended User merupakan fitur khusus yang digunakan untuk keperluan memberi akses terbatas pada orang terdekat (keluarga hingga sahabat) yang belum punya akun Eidupay',
    'Semua transaksi Extended User tercatat dan bisa dilihat pada history transaksi',
    'Setiap Extended User bisa diatur memiliki saldo yang berbeda-beda',
    'Limit pengeluaran harian/bulanan bisa diatur berbeda-beda untuk masing-masing Extended User',
    'Kamu tetap pegang kendali penuh. Kapanpun hak akses Extended bisa dinon-aktifkan',
    'Proses penambahan Extended mudah dan cepat',
  ];

  Future<void> toSubAccountList() async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.setBool(kSubAccountOnBoardTapped, true);
    await Get.offNamed(SubAccountListPage.route.name);
  }
}
