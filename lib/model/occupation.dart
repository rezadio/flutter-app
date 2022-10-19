import 'package:json_annotation/json_annotation.dart';

part 'occupation.g.dart';

@JsonSerializable()
class OccupationResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final List<Occupation> data;

  const OccupationResponse(this.ack, this.pesan, this.data);
  factory OccupationResponse.fromJson(Map<String, dynamic> json) =>
      _$OccupationResponseFromJson(json);
}

@JsonSerializable()
class Occupation {
  final String occupationCode;
  final String occupationDetail;

  const Occupation(this.occupationCode, this.occupationDetail);
  factory Occupation.fromJson(Map<String, dynamic> json) =>
      _$OccupationFromJson(json);
}
