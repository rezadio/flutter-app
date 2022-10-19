import 'package:json_annotation/json_annotation.dart';

part 'faq.g.dart';

@JsonSerializable()
class FaqResponse {
  @JsonKey(name: 'ACK')
  final String ack;
  final String pesan;
  final List<Faq> data;

  FaqResponse({required this.ack, required this.pesan, required this.data});
  factory FaqResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqResponseFromJson(json);
}

@JsonSerializable()
class Faq {
  final int id;
  final int urutan;
  final String pertanyaan;
  final String jawaban;

  Faq(
      {required this.id,
      required this.urutan,
      required this.pertanyaan,
      required this.jawaban});
  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
}
