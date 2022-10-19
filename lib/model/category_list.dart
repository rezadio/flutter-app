import 'package:json_annotation/json_annotation.dart';
import 'package:eidupay/model/category_data.dart';

part 'category_list.g.dart';

@JsonSerializable()
class CategoryList {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataCategory> dataListCategory;

  CategoryList({required this.ack, required this.dataListCategory});
  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}
