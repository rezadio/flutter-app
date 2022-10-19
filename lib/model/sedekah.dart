import 'package:json_annotation/json_annotation.dart';

part 'sedekah.g.dart';

@JsonSerializable()
class Sedekah {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataSedekah> dataList;

  Sedekah({required this.ack, required this.dataList});
  factory Sedekah.fromJson(Map<String, dynamic> json) =>
      _$SedekahFromJson(json);
  Map<String, dynamic> toJson() => _$SedekahToJson(this);
}

@JsonSerializable()
class DataSedekah {
  final String merchantPhone;
  final int merchantId;
  final String? merchantLogo;
  final String merchantName;
  final int? donasiProgramId;
  final String? programName;
  final String? programLogo;
  final int? programId;

  DataSedekah({
    required this.merchantPhone,
    required this.merchantId,
    this.merchantLogo,
    required this.merchantName,
    this.donasiProgramId,
    this.programName,
    this.programLogo,
    this.programId,
  });
  factory DataSedekah.fromJson(Map<String, dynamic> json) =>
      _$DataSedekahFromJson(json);
  Map<String, dynamic> toJson() => _$DataSedekahToJson(this);
}
