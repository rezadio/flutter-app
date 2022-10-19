import 'package:json_annotation/json_annotation.dart';

part 'negara.g.dart';

@JsonSerializable()
class NegaraResponse {
  final List<Negara> dataNegara;
  @JsonKey(name: 'ACK')
  final String ack;

  NegaraResponse({required this.ack, required this.dataNegara});
  factory NegaraResponse.fromJson(Map<String, dynamic> json) =>
      _$NegaraResponseFromJson(json);
}

@JsonSerializable()
class Negara {
  @JsonKey(name: 'country_flag_active')
  final String countryFlagActive;
  @JsonKey(name: 'country_code')
  final String countryCode;
  @JsonKey(name: 'country_name')
  final String countryName;
  @JsonKey(name: 'country_msisdn_prefix')
  final String countryMSISDNPrefix;
  @JsonKey(name: 'country_id')
  final String countryId;
  final DateTime? timeStamp;

  Negara(
      {required this.countryFlagActive,
      required this.countryCode,
      required this.countryName,
      required this.countryMSISDNPrefix,
      required this.countryId,
      this.timeStamp});
  factory Negara.fromJson(Map<String, dynamic> json) => _$NegaraFromJson(json);
}
