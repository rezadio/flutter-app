import 'package:eidupay/model/komunitas.dart';
import 'package:get/get.dart';

class KomunitasListCont extends GetxController {
  var filteredListKomunitas = <DataKomunitas>[].obs;
  late List<DataKomunitas> dtKomunitas = <DataKomunitas>[];

  @override
  void onInit() {
    super.onInit();
    filteredListKomunitas.clear();
  }

  void onSearchChange(String val) {
    filteredListKomunitas.clear();
    for (final komunitas in dtKomunitas) {
      final id = komunitas.communityId.toString();
      if (val.isEmpty) {
        filteredListKomunitas.clear();
      } else if (id.contains(val)) {
        filteredListKomunitas.add(komunitas);
      }
    }
  }
}
