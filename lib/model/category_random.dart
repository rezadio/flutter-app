import 'package:json_annotation/json_annotation.dart';
import 'package:eidupay/model/category_data.dart';

part 'category_random.g.dart';

@JsonSerializable()
class CategoryRandom {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataCategory> dataRandomCategory;

  CategoryRandom({required this.ack, required this.dataRandomCategory});
  factory CategoryRandom.fromJson(Map<String, dynamic> json) =>
      _$CategoryRandomFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryRandomToJson(this);
}
