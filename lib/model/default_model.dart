import 'package:json_annotation/json_annotation.dart';

part 'default_model.g.dart';

@JsonSerializable()
class DefaultModel {
  final String pesan;
  @JsonKey(name: 'ACK')
  final String ack;

  DefaultModel({required this.pesan, required this.ack});
  factory DefaultModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultModelFromJson(json);
  Map<String, dynamic> toJson() => _$DefaultModelToJson(this);

  @override
  String toString() => 'Pesan: $pesan';
}
